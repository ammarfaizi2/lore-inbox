Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315200AbSHHFtu>; Thu, 8 Aug 2002 01:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315222AbSHHFtu>; Thu, 8 Aug 2002 01:49:50 -0400
Received: from h-66-134-202-172.SNVACAID.covad.net ([66.134.202.172]:16265
	"EHLO freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S315200AbSHHFtt>; Thu, 8 Aug 2002 01:49:49 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 7 Aug 2002 22:53:01 -0700
Message-Id: <200208080553.WAA09913@adam.yggdrasil.com>
To: pavel@suse.cz
Subject: Re: Patch: linux-2.5.30/arch/arm/mach-iop310/iq80310-pci.c BUG_ON(cond1 || cond2) separation
Cc: linux-kernel@vger.kernel.org, mporter@mvista.com, rmk@arm.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek writes:
>it makes code slower/bigger... probably bad idea

	 The costs of expanding these two BUG_ON's is trivial,
considering that they get executed something like once per device,
during an initialization process.  This is a section of code where I
would think correctness and ease of debugging would be more important,
especially since they might be from bug reports submitted by users who
might have limited tolerance for repeatedly trying new kernels.

	If you're really squeezed for space, you're probably going to
have to define BUG() and BUG_ON() to something smaller that does not
generate a file name and line number (include/asm-i386/page.h an "#if"
for this, although mips does not), or even defining them as nothing.

	By the way, if no bug is detected, BUG_ON(cond1 || cond2)
executes the same instructions as BUG_ON(cond1); BUG_ON(cond2),
although there are probably greater instruction prefetch costs due to
the the ~20 bytes of code (that is normally not executed) for the
different call or trap instruction, and instruction cache issues.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
