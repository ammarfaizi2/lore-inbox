Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbVDSNTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVDSNTl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 09:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVDSNTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 09:19:41 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:39384 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S261502AbVDSNT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 09:19:29 -0400
From: Akinobu Mita <mita@miraclelinux.com>
To: ak@suse.de
Subject: x86-64 Uncorrected machine check panic on boot
Date: Tue, 19 Apr 2005 22:12:43 +0900
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504192212.44742.mita@miraclelinux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I got the following Machine Check Exception on 4-way Opteron Server.
I've tried 2.6.11.7 and 2.6.12-rc2.
The kernel parameter "nomce" could help to boot it up.

I wrote this panic messages by hand.
This panic seems to happen around "arch/x86_64/pci/../../i386/pci/direct.c:28"

==========================================================
Calling initcall 0xffffffff........: netlink_proto_init...
NET: Registered protocol family 16

Calling initcall 0xffffffff........: pcibus_class_init...
Calling initcall 0xffffffff........: pci_driver_init
Calling initcall 0xffffffff........: tty_class_init
Calling initcall 0xffffffff........: mtrr_if_init
Calling initcall 0xffffffff........: pci_direct_init

CPU3: Machine Check Exception: 7 Bank 3: b40000000000083b
RIP 10: <ffffffff802cfefe> {pci_conf1_read+0xce/0x110}
TSC 85ece4f ADDR fdfc000cfe

kernel panic - not syncing: Uncorrected machine check
==========================================================


$ addr2line -e vmlinux ffffffff802cfee0
arch/x86_64/pci/../../i386/pci/direct.c:28

$ addr2line -e vmlinux ffffffff802cfee2
include/asm/io.h:81

$ addr2line -e vmlinux ffffffff802cfefe
include/asm/io.h:84


