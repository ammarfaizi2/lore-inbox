Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261963AbVGEWmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbVGEWmh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 18:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbVGEWma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 18:42:30 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35855 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261946AbVGEWmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 18:42:25 -0400
Date: Tue, 5 Jul 2005 23:42:20 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12: arm compilation problems
Message-ID: <20050705234220.A19003@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20050705215001.GC2259@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050705215001.GC2259@elf.ucw.cz>; from pavel@ucw.cz on Tue, Jul 05, 2005 at 11:50:01PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2005 at 11:50:01PM +0200, Pavel Machek wrote:
> I get this, trying to cross-compile 2.6.12 for arm. I tried different
> configs... What am I doing wrong? [2.6.11 compiles ok, and even works
> on my zaurus after some patches. I tried unpatched 2.6.12, too.]
> 
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> /scratchbox/compilers/arm-gcc-3.3.4-glibc-2.3.2/bin/arm-linux-ld:arch/arm/kernel/vmlinux.lds:648:
> syntax error

Your binutils is probably too old and therefore buggy.  2.16 seems
reasonable, others prefer the known-buggy in other respects 2.15
version (iirc assembler doesn't complain about undefined constant
symbols, doesn't correctly hide $a, $d, $t symbols.)

The exact problem is the ASSERT() macro in the linker script - it
appears some versions of binutils are documented to accept this
but unfortunately it incorrectly errors out with a ficticious syntax
error.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
