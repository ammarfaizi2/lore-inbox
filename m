Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262821AbSI3SZY>; Mon, 30 Sep 2002 14:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262823AbSI3SZY>; Mon, 30 Sep 2002 14:25:24 -0400
Received: from hera.cwi.nl ([192.16.191.8]:19074 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262821AbSI3SZX>;
	Mon, 30 Sep 2002 14:25:23 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 30 Sep 2002 20:30:48 +0200 (MEST)
Message-Id: <UTC200209301830.g8UIUmR20205.aeb@smtp.cwi.nl>
To: aebr@win.tue.nl, axboe@suse.de
Subject: Re: 2.5.37 oopses at boot in ide_toggle_bounce
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does it work in 2.4.20-pre-ac?


In 2.4.20-pre8 and in 2.5.33 the disks on a HPT366 are
detected without CONFIG_BLK_DEV_HPT366 being present.
Look at 2.4.20-pre8 in ide-pci.c and find an explicit list
ide_pci_chipsets that is walked by ide_scan_pcidev().

In 2.4.20-pre8ac2 and in 2.5.38 this HPT366 is not seen
without CONFIG_BLK_DEV_HPT366. The routine ide_scan_pcidev()
in setup-pci.c walks a list ide_pci_drivers that is
initially empty. HPT366 will only add itself when hpt366.c
is present and its hpt366_ide_init() invokes
ide_pci_register_driver().


So, all is well in both worlds, but one has to add
CONFIG_BLK_DEV_HPT366=y to .config now.
Long ago that would cause corruption, but so far
I have not seen any bad effects with recent kernels.

All the best - Andries
