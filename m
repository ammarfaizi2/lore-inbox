Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267275AbSLEKrT>; Thu, 5 Dec 2002 05:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267276AbSLEKqP>; Thu, 5 Dec 2002 05:46:15 -0500
Received: from holomorphy.com ([66.224.33.161]:44169 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267280AbSLEKqE>;
	Thu, 5 Dec 2002 05:46:04 -0500
Date: Thu, 05 Dec 2002 02:52:59 -0800
From: wli@holomorphy.com
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, kernel-janitor-discuss@lists.sourceforge.net,
       rmk@arm.linux.org.uk, jgarzik@pobox.com, miura@da-cha.org,
       alan@lxorguk.ukuu.org.uk, viro@math.psu.edu, pavel@ucw.cz
Subject: [warnings] [0/8] fix warnings in mainline
Message-ID: <0212050252.ZakdfbOcNbscMdIa~a.cRahaUambTcPa20143@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch series vs. 2.5.50-bk as of Thu Dec  5 02:26:45 PST 2002
This patch series fixes various warnings encountered compiling
2.5.50-bk as of the time posted. Various driver etc. maintainers
cc:'d for proper acks etc.

These fixes have been pending for a while; hence Linus on the To:
line. Otherwise it's pure driver/etc. maintainer acks.

[0/8] warn-2.5.50-0  fix warnings in mainline
	numerous warnings appear compiling mainling 2.5.50 kernels
[1/8] warn-2.5.50-hugetlbfs-1  fix hugetlbfs security.h problem
	hugetlbfs wants security_inode_setattr(), which is an inline
	defined in <linux/security.h>
[2/8] warn-2.5.50-serial-2  fix uninitialized quot in drivers/serial/core.c
	quot needs to be a baud divisor; this sets it to something sane
	so that things can proceed
[3/8] warn-2.5.50-suspend-3  fix duplicate decls in swsusp
	swsusp conditionally declares software_suspend() as an inline 
	no-op; remove reboot.h extern declaration.
[4/8] warn-2.5.50-cyrix-4  remove unused cr0 in cyrix.c
	cr0 is just not used here. Remove it.
[5/8] warn-2.5.50-starfire-5  fix printk() type warning in drivers/net/starfire.c
	Cast to (u64) and use %Lx in all cases.
[6/8] warn-2.5.50-ioapic-6  fix mismatched function type in arch/i386/kernel/ioapic.c
	the function needs to return int; give it a return type and
	return 0 unconditionally from it (as it cannot fail)
[7/8] warn-2.5.50-tulip-7  fix printk() type warning in drivers/net/tulip/interrupt.c
	Cast to (u64) and use %Lx in all cases.
[8/8] warn-2.5.50-floppy-8  fix unused function warning in drivers/block/floppy.c
	unregister_devfs_entries() is only used in the #if MODULE
	case; move it into #if MODULE so it doesn't affect non-modular
