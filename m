Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262475AbVCVEyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262475AbVCVEyE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 23:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262469AbVCVExB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 23:53:01 -0500
Received: from mail.shareable.org ([81.29.64.88]:12181 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262367AbVCVEsx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 23:48:53 -0500
Date: Tue, 22 Mar 2005 04:48:38 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, cmorgan@alum.wpi.edu, paul@linuxaudiosystems.com,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: Re: kernel bug: futex_wait hang
Message-ID: <20050322044838.GB32432@mail.shareable.org>
References: <1111463950.3058.20.camel@mindpipe> <20050321202051.2796660e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050321202051.2796660e.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> iirc we ended up deciding that the futex problems around that time were due
> to userspace problems (a version of libc).  But then, there's no discussion
> around Seto's patch and it didn't get applied.  So I don't know what
> happened to that work - it's all a bit mysterious.

It can be fixed _either_ in Glibc, or by changing the kernel.

That problem is caused by differing assumptions between Glibc and the
kernel about subtle futex semantics.  Which goes to show they are
really clever, or something.

I provided pseudo-code for the Glibc fix, but not an actual patch
because NPTL is quite complicated and I wanted to know the Glibc
people were interested, but apparently they were too busy at the time
- benchmarks would have made sense for such a patch.

Scott Snyder started fixing part of Glibc, and that did fix his
instance of this problem so we know the approach works.  But a full
patch for Glibc was not prepared.

The most recent messages under "Futex queue_me/get_user ordering",
with a patch from Jakub Jelinek will fix this problem by changing the
kernel.  Yes, you should apply Jakub's most recent patch, message-ID
"<20050318165326.GB32746@devserv.devel.redhat.com>".

I have not tested the patch, but it looks convincing.

I argued for fixing Glibc on the grounds that the changed kernel
behaviour, or more exactly having Glibc depend on it, loses a certain
semantic property useful for unusual operations on multiple futexes at
the same time.  But I appear to have lost the argument, and Jakub's
latest patch does clean up some cruft quite nicely, with no expected
performance hit.

-- Jamie
