Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030372AbWJSMcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030372AbWJSMcj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 08:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030368AbWJSMci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 08:32:38 -0400
Received: from mx.go2.pl ([193.17.41.41]:63917 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1030334AbWJSMch (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 08:32:37 -0400
Date: Thu, 19 Oct 2006 14:37:42 +0200
From: Jarek Poplawski <jarkao2@o2.pl>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] lockdep: fix ide/proc interaction
Message-ID: <20061019123742.GE3296@ff.dom.local>
Mail-Followup-To: Jarek Poplawski <jarkao2@o2.pl>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20061019084051.GB1872@ff.dom.local> <1161255956.3036.84.camel@taijtu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161255956.3036.84.camel@taijtu>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 01:05:56PM +0200, Peter Zijlstra wrote:
> On Thu, 2006-10-19 at 10:40 +0200, Jarek Poplawski wrote:
...
> > But now:
> > >  (proc_subdir_lock){--..}, at: [<c04a33b0>] remove_proc_entry+0x40/0x191
> > 
> > is taken here with irqs and bhs enabled (btw. this: {--..} looks
> > as if it wasn't called from here with spin_lock_irqsave?) 
> > IMHO it is hard to believe this lock isn't anywhere used in
> > hard or soft irq context so probably local_irq_disable/enable
> > or local_bh_disable/enable is needed around this.
> 
> it really isnt, check fs/proc/{generic,proc_devtree}.c

I did it - but I hope all places were checked and 
remove_proc_entry (or other with proc_subdir_lock)
is not used by any timer etc. 

Sorry for false alarm,

Regards,

Jarek P.
