Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263129AbVCKFA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbVCKFA4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 00:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbVCKFAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 00:00:54 -0500
Received: from fire.osdl.org ([65.172.181.4]:14569 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263129AbVCKFAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 00:00:16 -0500
Date: Thu, 10 Mar 2005 20:59:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: jerome lacoste <jerome.lacoste@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops / 2.6.11 / run_timer_softirq (mountvirtfs)
Message-Id: <20050310205943.794b8efd.akpm@osdl.org>
In-Reply-To: <5a2cf1f6050310161085f2da6@mail.gmail.com>
References: <5a2cf1f6050310161085f2da6@mail.gmail.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jerome lacoste <jerome.lacoste@gmail.com> wrote:
>
> On an VIA EPIA board, I got this single oops at boot. Wasn't stored on
> file so I had to take a screenshot with a digital camera. Basicallly
> goes along those lines:
> 
> Process: S36mountvirtfs
> 
> Call trace:
>      run_timer_softirq+0x16f/0x200
>      __do_softirq
>      do_softirq
>      irq_exit
>      do_IRQ
>      common_interrupt
> 
> Process is found here on my system:
> 
> lrwxr-xr-x  1 root root 21 Mar  1 00:29 /etc/rcS.d/S36mountvirtfs ->
> ../init.d/mountvirtfs
> 
> The exact screenshot (500k) can be found here:
> 
> http://coffeebreaks.dyndns.org/~jerome/static/images/linux/oops_2.6.11_run_timer_softirq_boot.jpg
> 

An oops in cascade() is tricky.  Normally it means that some piece of code
has done something bad with a kernel timer.  Later, a clock tick happens
and the kernel falls over.  We're left with no hints as to which part of
the kernel misbehaved.

Please try enabling CONFIG_DEBUG_SLAB and CONFIG_DEBUG_PAGEALLOC and see if
that reveals any additional info.

Apart from that, you have a lot of modules configured there.  Please try
disabling them all, see if the oops goes away.  If it does then try
re-enabling them, see if you can narrow it down to the one which is causing
the timer list corruption.

Thanks.
