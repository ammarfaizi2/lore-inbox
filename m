Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTIXMwb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 08:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbTIXMwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 08:52:31 -0400
Received: from cpc1-cwma1-5-0-cust4.swan.cable.ntl.com ([80.5.120.4]:35023
	"EHLO dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261305AbTIXMwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 08:52:30 -0400
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mc@cs.stanford.edu
In-Reply-To: <20030924001334.A19940@devserv.devel.redhat.com>
References: <20030923140503.N20572@osdlab.pdx.osdl.net>
	 <20030924001334.A19940@devserv.devel.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1064407793.13459.17.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Wed, 24 Sep 2003 13:49:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-09-24 at 05:13, Pete Zaitcev wrote: 
> -	spin_lock(&codec->ac97_lock);
> +	down(&unit->ac97_lock);
>  	/* XXX Do make use of dev->id */
> -	ymfpci_codec_ready(codec, 0, 0);

This breaks ac97 locking and should not be applied. The core ac97
code is called some times with interrupts disabled. That is unavoidable.

The only change that is relevant is the kfree

