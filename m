Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266851AbSLUJhl>; Sat, 21 Dec 2002 04:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266852AbSLUJhl>; Sat, 21 Dec 2002 04:37:41 -0500
Received: from h-64-105-34-78.SNVACAID.covad.net ([64.105.34.78]:10434 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S266851AbSLUJhl>; Sat, 21 Dec 2002 04:37:41 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 21 Dec 2002 01:43:20 -0800
Message-Id: <200212210943.BAA08993@adam.yggdrasil.com>
To: wli@holomorphy.com
Subject: Re: linux-2.5.40 64GB highmem BUG()
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 	Although 2.5.40 has been out for a while, I think I ought
>> to post this bug as I haven't seen any other mention of it.
>> 	When I boot an 2.5.40 x86 kernel built with CONFIG_HIGHMEM64G,
>> and with a 920kB initial ramdisk (2.2MB uncompressed), I get a kernel
>> BUG() at highmem.c line 480, preceded by a message saying "scheduling
>> with KM_TYPE 15 held!"  The machine on which I experienced this
>> problem has 1.25GB of RAM.  The problem occurs with and without
>> CONFIG_PREEMPT.  All kernels that tried were SMP kernels running on a
>> uniprocessor.

>This is not reproducible here with 2.5.52-mm2. Is the initrd required
>to trigger this?

	Yes, the initrd seems to be required.  It happens when
the initrd attempts to mount /proc (it runs a shell script that
starts by setting PATH, mounting /dev, and mounting /proc).

	I've verified that under 2.5.52 the problem occurs with
CONFIG_HIGHME64G and not with CONFIG_HIGHMEM4G.  Actually, now the
problem is a BUG() at slab.c:1451, which is also memory corruption,
and I suspect just an evolution of the same problem from 2.5.40.

	Anyhow, in case it helps you, I've put the vmlinux and initrd
that produce this problem in
ftp://ftp.yggdrasil.com/private/adam/for-wli/.  Note that the ramdisk
has kernel modules that don't match the kernel but that's not the
issue, as I configured that kernel to have a different version name.

       Thanks for your attention to this problem.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
