Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284546AbRLRSig>; Tue, 18 Dec 2001 13:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284491AbRLRShq>; Tue, 18 Dec 2001 13:37:46 -0500
Received: from adsl-209-76-109-63.dsl.snfc21.pacbell.net ([209.76.109.63]:42624
	"EHLO adsl-209-76-109-63.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S284467AbRLRShl>; Tue, 18 Dec 2001 13:37:41 -0500
Date: Tue, 18 Dec 2001 10:37:30 -0800
From: Wayne Whitney <whitney@math.berkeley.edu>
Message-Id: <200112181837.fBIIbUF02685@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
To: "Wenyong Deng" <wydeng@platodesign.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to use >3G memory per process
In-Reply-To: <OHEPLPGMMIEGHANJIEBAIEPKCEAA.wydeng@platodesign.com>
In-Reply-To: <OHEPLPGMMIEGHANJIEBAIEPKCEAA.wydeng@platodesign.com>
Reply-To: whitney@math.berkeley.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In mailing-lists.linux-kernel, you wrote:

> [1] What need to be done for the kernel to support 3.5G or more user
> address space per process?

On ia32, change the value of __PAGE_OFFSET (where kernel space starts)
in include/asm-i386/page.h.  The size of kernel space must be a power
of 2, so you can change __PAGE_OFFSET from its default of 0xC0000000
to either 0xE0000000 (reasonable) or 0xF0000000 (overboard ?).
You must also change the unlabeled value near the top of
arch/i386/vmlinux.lds to match the value of __PAGE_OFFSET.

> [2] What need to be done at compilation time? Any option for
> compiler/linker?

No changes are required in the method of compiling the kernel.  As for
your application, no changes should be required, although I am not
familiar with libhoard.  

Note that this change increases the mmap() region of user space, but
since you are speak of using malloc() and/or libhoard, that should be
sufficient for your purposes.  With __PAGE_OFFSET set to 0xE0000000,
your program should have (3.5GB - 2 * Program Size - Stack Size) of
usable address space.

Cheers, Wayne

