Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261968AbVCLQNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbVCLQNz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 11:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbVCLQKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 11:10:19 -0500
Received: from host218-153.pool80183.interbusiness.it ([80.183.153.218]:50442
	"HELO gg.mine.nu") by vger.kernel.org with SMTP id S261955AbVCLQHI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 11:07:08 -0500
Message-ID: <20050312160704.22527.qmail@gg.mine.nu>
From: "Guido Villa" <piribillo@yahoo.it>
To: linux-kernel@vger.kernel.org
Subject: Error with Sil3112A SATA controller and Maxtor 300GB HDD
Date: Sat, 12 Mar 2005 17:07:04 +0100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

I have an error as described in subject.
I couldn't find a previous report for this kind of error, so maybe you are 
interested in it. 

Motherboard: ASUS TUV4X, BIOS rev. 1005
SATA controller: Silicon Image 3112A, bios rev. 4.2.50
Hard disk: Maxtor Maxtor 6B300S0 (300GB, SATA) 

This is the only HDD attached to the controller. It is not the boot device, 
I have other HDDs on the IDE channels, but I don't think it matters. 

Kernels: 2.6.9, 2.6.10, 2.6.11.2
I also patched the 2.6.11.2 by adding this Maxtor disk to the sata_sil.c 
blacklist (once with the SIL_QUIRK_MOD15WRITE and once with the 
SIL_QUIRK_UDMA5MAX), but the behaviour did not change. 

Problem:
I create a single partition on the hard disk, I format it with ext2, I mount 
it, I begin writing onto the partition. After seconds (or minutes) of 
copying, I get this error: 

EXT2-fs error (device sda1): ext2_new_block: Allocating block in system zone 
 - block = 22413316 

I have also tried with ext3, in this case it prints more error messages: 

EXT3-fs error (device sda1): ext3_new_block: Allocating block in system zone 
 - block = 61997060
Aborting journal on device sda1.
EXT3-fs error (device sda1) in ext3_prepare_write: Journal has aborted
__journal_remove_journal_head: freeing b_committed_data
__journal_remove_journal_head: freeing b_frozen_data
__journal_remove_journal_head: freeing b_committed_data
__journal_remove_journal_head: freeing b_frozen_data
__journal_remove_journal_head: freeing b_committed_data
__journal_remove_journal_head: freeing b_frozen_data
__journal_remove_journal_head: freeing b_committed_data
__journal_remove_journal_head: freeing b_frozen_data
__journal_remove_journal_head: freeing b_frozen_data
ext3_abort called.
EXT3-fs error (device sda1): ext3_journal_start_sb: Detected aborted journal
Remounting filesystem read-only
EXT3-fs error (device sda1) in start_transaction: Journal has aborted 

 

When the disk is formatted and mounted as ext3, the error happens earlier 
that when formatted with ext2. 

Running badblocks on the disk gives random results, every time it finds a 
few bad blocks in different positions.
The powermax utility from Maxtor says that the HDD is ok, and there are no 
bad blocks, actually I do not think it is an hardware problem, but a problem 
with the SATA controller driver (and mybe some incompatibility with the 
Maxtor drive). 

Please let me know if you need any more information. 

Good bye,
Guido 

