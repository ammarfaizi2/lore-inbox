Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262355AbVCVFQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbVCVFQM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 00:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262472AbVCVFLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 00:11:51 -0500
Received: from fire.osdl.org ([65.172.181.4]:63694 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262355AbVCVFIi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 00:08:38 -0500
Date: Mon, 21 Mar 2005 21:08:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: rlrevell@joe-job.com, linux-kernel@vger.kernel.org, mingo@elte.hu,
       cmorgan@alum.wpi.edu, paul@linuxaudiosystems.com,
       seto.hidetoshi@jp.fujitsu.com
Subject: Re: kernel bug: futex_wait hang
Message-Id: <20050321210802.14be70cc.akpm@osdl.org>
In-Reply-To: <20050322044838.GB32432@mail.shareable.org>
References: <1111463950.3058.20.camel@mindpipe>
	<20050321202051.2796660e.akpm@osdl.org>
	<20050322044838.GB32432@mail.shareable.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> wrote:
>
> Andrew Morton wrote:
> > iirc we ended up deciding that the futex problems around that time were due
> > to userspace problems (a version of libc).  But then, there's no discussion
> > around Seto's patch and it didn't get applied.  So I don't know what
> > happened to that work - it's all a bit mysterious.
> 
> It can be fixed _either_ in Glibc, or by changing the kernel.
> 
> That problem is caused by differing assumptions between Glibc and the
> kernel about subtle futex semantics.  Which goes to show they are
> really clever, or something.
> 
> I provided pseudo-code for the Glibc fix, but not an actual patch
> because NPTL is quite complicated and I wanted to know the Glibc
> people were interested, but apparently they were too busy at the time
> - benchmarks would have made sense for such a patch.
> 
> Scott Snyder started fixing part of Glibc, and that did fix his
> instance of this problem so we know the approach works.  But a full
> patch for Glibc was not prepared.
> 
> The most recent messages under "Futex queue_me/get_user ordering",
> with a patch from Jakub Jelinek will fix this problem by changing the
> kernel.  Yes, you should apply Jakub's most recent patch, message-ID
> "<20050318165326.GB32746@devserv.devel.redhat.com>".
> 
> I have not tested the patch, but it looks convincing.

OK, thanks.  Lee && Paul, that's at
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.6.12-rc1-mm1/broken-out/futex-queue_me-get_user-ordering-fix.patch


> I argued for fixing Glibc on the grounds that the changed kernel
> behaviour, or more exactly having Glibc depend on it, loses a certain
> semantic property useful for unusual operations on multiple futexes at
> the same time.  But I appear to have lost the argument, and Jakub's
> latest patch does clean up some cruft quite nicely, with no expected
> performance hit.

Futexes were initially so simple.
