Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266526AbUH1OsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266526AbUH1OsU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 10:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266786AbUH1OsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 10:48:20 -0400
Received: from zero.aec.at ([193.170.194.10]:4612 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266526AbUH1OsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 10:48:17 -0400
To: "Kaigai Kohei" <kaigai@ak.jp.nec.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]atomic_inc_return() for i386/x86_64 (Re: RCU issue with
 SELinux)
References: <2wJxj-7g2-23@gated-at.bofh.it> <2x2JC-3Uu-11@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sat, 28 Aug 2004 16:48:13 +0200
In-Reply-To: <2x2JC-3Uu-11@gated-at.bofh.it> (Kaigai Kohei's message of
 "Wed, 25 Aug 2004 12:00:12 +0200")
Message-ID: <m3k6vjco9e.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Kaigai Kohei" <kaigai@ak.jp.nec.com> writes:

> atomic_inc_return() is not defined for arm,arm26,i386,x86_64 and um archtectures.
> This attached patch adds atomic_inc_return() and atomic_dec_return() to arm,i386 and x86_64.
>
> It is implemented by 'xaddl' operation with LOCK prefix for i386 and x86_64.
> But this operation is permitted after i486 processor only.
> Another implementation may be necessary for i386SX/DX processor.
> But 'xaddl' operation is used in 'include/asm-i386/rwsem.h' unconditionally.
> I think it has agreed on using 'xaddl' operation in past days.

We don't support SMP on 386 boxes. What you can do for 386 is to use 
alternative() and just use an non SMP safe version for 386 and xadd 
for 486+ 

This will require adding a new pseudo CPUID bit in cpufeature.h 
that can be tested for in alternative (similar to the X86_FEATURE_P3/P4 
flags that are already there)

-Andi

