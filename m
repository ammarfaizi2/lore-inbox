Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752122AbWCFHrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122AbWCFHrQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 02:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752144AbWCFHrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 02:47:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:59082 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1752122AbWCFHrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 02:47:15 -0500
X-Authenticated: #14349625
Subject: Re: Fw: Re: oops in choose_configuration()
From: Mike Galbraith <efault@gmx.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0603052043170.13139@g5.osdl.org>
References: <20060304121723.19fe9b4b.akpm@osdl.org>
	 <Pine.LNX.4.64.0603041235110.22647@g5.osdl.org>
	 <20060304213447.GA4445@kroah.com> <20060304135138.613021bd.akpm@osdl.org>
	 <20060304221810.GA20011@kroah.com> <20060305154858.0fb0006a.akpm@osdl.org>
	 <Pine.LNX.4.64.0603052043170.13139@g5.osdl.org>
Content-Type: text/plain
Date: Mon, 06 Mar 2006 08:47:20 +0100
Message-Id: <1141631240.26111.11.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-05 at 21:00 -0800, Linus Torvalds wrote:

> 
> Is there something else I've missed?

Maybe.  Does this add anything to the picture?  During boot,
recalc_task_prio() is called with now < p->timestamp.  This causes quite
a stir.  If you WARN_ON(now < p->timestamp) or printk, you'll have a
dead box due to hundreds of gripes as things churn.  Adding...

if (unlikely(now < p->timestamp))
	__sleep_time = 0ULL;

...turns it into exactly one gripe.

	-Mike

