Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbWCGFuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWCGFuu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 00:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWCGFuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 00:50:50 -0500
Received: from mail.gmx.de ([213.165.64.20]:31643 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750839AbWCGFut (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 00:50:49 -0500
X-Authenticated: #14349625
Subject: Re: Fw: Re: oops in choose_configuration()
From: Mike Galbraith <efault@gmx.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>
In-Reply-To: <1141631240.26111.11.camel@homer>
References: <20060304121723.19fe9b4b.akpm@osdl.org>
	 <Pine.LNX.4.64.0603041235110.22647@g5.osdl.org>
	 <20060304213447.GA4445@kroah.com> <20060304135138.613021bd.akpm@osdl.org>
	 <20060304221810.GA20011@kroah.com> <20060305154858.0fb0006a.akpm@osdl.org>
	 <Pine.LNX.4.64.0603052043170.13139@g5.osdl.org>
	 <1141631240.26111.11.camel@homer>
Content-Type: text/plain
Date: Tue, 07 Mar 2006 06:51:09 +0100
Message-Id: <1141710669.7901.9.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-06 at 08:47 +0100, Mike Galbraith wrote:
> On Sun, 2006-03-05 at 21:00 -0800, Linus Torvalds wrote:
> 
> > 
> > Is there something else I've missed?
> 
> Maybe.  Does this add anything to the picture?  During boot,
> recalc_task_prio() is called with now < p->timestamp.  This causes quite
> a stir.  If you WARN_ON(now < p->timestamp) or printk, you'll have a
> dead box due to hundreds of gripes as things churn.  Adding...
> 
> if (unlikely(now < p->timestamp))
> 	__sleep_time = 0ULL;
> 
> ...turns it into exactly one gripe.

Nope.  Further research shows that this is just a speed-step problem.
Still, the scheduler needs to protect itself, because even with all of
the speed-step stuff enabled, these continue to occurr even after
boot-up if you switch to a low power setting, which screws up the
scheduler.

	-Mike

