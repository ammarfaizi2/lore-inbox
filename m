Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264861AbUFAAwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264861AbUFAAwO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 20:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264862AbUFAAwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 20:52:14 -0400
Received: from mailout.despammed.com ([65.112.71.29]:31999 "EHLO
	mailout.despammed.com") by vger.kernel.org with ESMTP
	id S264861AbUFAAwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 20:52:13 -0400
Date: Mon, 31 May 2004 19:38:59 -0500 (CDT)
Message-Id: <200406010038.i510cxk23507@mailout.despammed.com>
From: ndiamond@despammed.com
To: linux-kernel@vger.kernel.org
Subject: Re: How to use floating point in a module?
X-Mailer: despammed.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In http://www.ussg.iu.edu/hypermail/linux/kernel/0405.3/1620.html,
Linus Torvalds wrote:

> You can do it "safely" on x86 using
> kernel_fpu_begin();
> ...
> kernel_fpu_end();
> and make sure that _all_ the FP stuff is in between those two things, and 
> that you don't do _anything_ that might fault or sleep.

In http://www.uwsg.iu.edu/hypermail/linux/kernel/0202.1/1591.html,
Alan Cox two years ago advised another questioner that init_fpu()
could be called after kernel_fpu_begin().  Looking at the source code,
this seems like a good idea.

Since the kernel is 2.4. 20something, init_fpu() takes no arguments.

I am looking at directory linux/arch/i386/kernel, with file i387.c
containing functions kernel_fpu_begin() and init_fpu() and others,
file i387.o resulting from a compilation, and Makefile saying that
i387 is included in the obj-y list.  So it seems to me that the executing
kernel should have kernel_fpu_begin() and init_fpu() built in.

But when we do insmod on our module, the list of undefined symbols
includes kernel_fpu_begin and init_fpu.  How is this possible?

(The CPU is an i686.  I'll have to look up its opcodes and see if its
hardware will come close enough for everything the driver needs.  If it
doesn't, I'll buy one of the books that some others kindly recommended
and do polynomial approximations.)  (By the way the driver is being
ported from VxWorks, where it seems that the kernel can do floating
point including trig, logarithms, etc.)

