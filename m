Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbTIXQjS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 12:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbTIXQjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 12:39:18 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:23195 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261491AbTIXQjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 12:39:15 -0400
Date: Wed, 24 Sep 2003 12:38:58 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pete Zaitcev <zaitcev@redhat.com>, Chris Wright <chrisw@osdl.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mc@cs.stanford.edu
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths
Message-ID: <20030924123858.B4714@devserv.devel.redhat.com>
References: <20030923140503.N20572@osdlab.pdx.osdl.net> <20030924001334.A19940@devserv.devel.redhat.com> <1064407793.13459.17.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1064407793.13459.17.camel@dhcp23.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Wed, Sep 24, 2003 at 01:49:54PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > -	spin_lock(&codec->ac97_lock);
> > +	down(&unit->ac97_lock);
> >  	/* XXX Do make use of dev->id */
> > -	ymfpci_codec_ready(codec, 0, 0);
> 
> This breaks ac97 locking and should not be applied. The core ac97
> code is called some times with interrupts disabled. That is unavoidable.
> 
> The only change that is relevant is the kfree

In that case, whoever added spinlocks should have removed
schedule() from ymfpci_ready_wait().

-- Pete
