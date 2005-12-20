Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbVLTEnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbVLTEnl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 23:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbVLTEnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 23:43:40 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:35270 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750782AbVLTEnk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 23:43:40 -0500
Subject: Compile errors on i386 with CONFIG_PCI_GOMMCONFIG
From: Pavel Roskin <proski@gnu.org>
To: linux <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 19 Dec 2005 23:43:30 -0500
Message-Id: <1135053810.3815.9.camel@dv>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 (2.4.1-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

If I set "PCI access mode" in the configuration to "MMConfig", the build
fails:

arch/i386/pci/built-in.o(.text+0x3a2): In function `pci_mmcfg_read':
mmconfig.c: undefined reference to `pci_conf1_read'
arch/i386/pci/built-in.o(.text+0x4b6): In function `pci_mmcfg_write':
mmconfig.c: undefined reference to `pci_conf1_write'
arch/i386/pci/built-in.o(.init.text+0x38c): In function
`unreachable_devices':
mmconfig.c: undefined reference to `pci_conf1_read'
make[2]: *** [.tmp_vmlinux1] Error 1

It happens with current Linux from git when compiled for i386.

Missing functions are in arch/i386/pci/direct.c, which is enabled by
selecting "Direct" or "Any" as PCI access mode.

I believe the most straight fix would be to move shared functions to a
separate file (e.g. conf1.c) under arch/i386/pci/ that would be compiled
if either CONFIG_PCI_MMCONFIG or CONFIG_PCI_DIRECT is set.

-- 
Regards,
Pavel Roskin

