Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263645AbTJaWRC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 17:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263647AbTJaWRC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 17:17:02 -0500
Received: from smtp.mailix.net ([216.148.213.132]:53955 "EHLO smtp.mailix.net")
	by vger.kernel.org with ESMTP id S263645AbTJaWQ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 17:16:58 -0500
Date: Fri, 31 Oct 2003 23:16:52 +0100
From: Alex Riesen <fork0@users.sf.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Greg Kroah-Hartman <greg@kroah.com>,
       Matthew Dharm <mdharm-usb@one-eyed-alien.net>
Subject: 2.6.0-test9+bk: very slow mount of a Canon FC-32M compactflash card
Message-ID: <20031031221652.GA1213@steel.home>
Reply-To: Alex Riesen <fork0@users.sf.net>
Mail-Followup-To: Alex Riesen <fork0@users.sf.net>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Matthew Dharm <mdharm-usb@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a strange 32Mb CF card. The card was causing this "slow mount" as
long as I can remember (I probably even reported it already, but not
sure). First (after boot) attempt to mount is usually normally fast,
but all subsequent attempts make "mount" hang in D state for almost a
minute. The card is mounted and read correctly, though. No other ill
effects noticed.

The reader is a 6-in-1 ICS35 thing which works flawlessly with any other
card, except this one. The card is Canon FC-32M compactflash card.
USB is UHCI.

Call trace of mount:

mount         D 39B24413     0  1066   1026                     (NOTLB)
 d4357a24 00000086 dbc9ecc0 39b24413 00000086 db8dcb00 d4357a0c c01f4446
 db8dcb00 39b24413 00000086 dbc9ecc0 dbc9ece0 00002daa 39b24782 00000086
 d4357a9c d4356000 d4356000 d4357a78 c011a678 00000000 d2d82140 c011a370
 Call Trace:
  [elv_next_request+22/272] elv_next_request+0x16/0x110
  [<c01f4446>] elv_next_request+0x16/0x110
  [wait_for_completion+120/208] wait_for_completion+0x78/0xd0
  [<c011a678>] wait_for_completion+0x78/0xd0
  [default_wake_function+0/48] default_wake_function+0x0/0x30
  [<c011a370>] default_wake_function+0x0/0x30
  [default_wake_function+0/48] default_wake_function+0x0/0x30
  [<c011a370>] default_wake_function+0x0/0x30
  [_end+475509342/1070289096] scsi_wait_req+0x76/0x90 [scsi_mod]
  [<dc8c4196>] scsi_wait_req+0x76/0x90 [scsi_mod]
  [_end+475509096/1070289096] scsi_wait_done+0x0/0x80 [scsi_mod]
  [<dc8c40a0>] scsi_wait_done+0x0/0x80 [scsi_mod]
  [_end+475278750/1070289096] sd_read_capacity+0x76/0x350 [sd_mod]
  [<dc88bcd6>] sd_read_capacity+0x76/0x350 [sd_mod]
  [_end+475280610/1070289096] sd_revalidate_disk+0xea/0x150 [sd_mod]
  [<dc88c41a>] sd_revalidate_disk+0xea/0x150 [sd_mod]
  [check_disk_change+119/144] check_disk_change+0x77/0x90
  [<c015ae97>] check_disk_change+0x77/0x90
  [_end+475276457/1070289096] sd_open+0x71/0x100 [sd_mod]
  [<dc88b3e1>] sd_open+0x71/0x100 [sd_mod]
  [get_gendisk+33/64] get_gendisk+0x21/0x40
  [<c01f9291>] get_gendisk+0x21/0x40
  [_end+475276344/1070289096] sd_open+0x0/0x100 [sd_mod]
  [<dc88b370>] sd_open+0x0/0x100 [sd_mod]
  [do_open+305/1024] do_open+0x131/0x400
  [<c015b091>] do_open+0x131/0x400
  [blkdev_get+101/112] blkdev_get+0x65/0x70
  [<c015b3c5>] blkdev_get+0x65/0x70
  [do_open+600/1024] do_open+0x258/0x400
  [<c015b1b8>] do_open+0x258/0x400
  [blkdev_get+101/112] blkdev_get+0x65/0x70
  [<c015b3c5>] blkdev_get+0x65/0x70
  [open_bdev_excl+81/192] open_bdev_excl+0x51/0xc0
  [<c015b811>] open_bdev_excl+0x51/0xc0
  [get_sb_bdev+48/336] get_sb_bdev+0x30/0x150
  [<c0159de0>] get_sb_bdev+0x30/0x150
  [__kmalloc+359/512] __kmalloc+0x167/0x200
  [<c013e7a7>] __kmalloc+0x167/0x200
  [_end+477299030/1070289096] vfat_get_sb+0x2e/0x40 [vfat]
  [<dca7908e>] vfat_get_sb+0x2e/0x40 [vfat]
  [_end+477298872/1070289096] vfat_fill_super+0x0/0x70 [vfat]
  [<dca78ff0>] vfat_fill_super+0x0/0x70 [vfat]
  [do_kern_mount+86/208] do_kern_mount+0x56/0xd0
  [<c015a106>] do_kern_mount+0x56/0xd0
  [do_add_mount+117/352] do_add_mount+0x75/0x160
  [<c016f475>] do_add_mount+0x75/0x160
  [__alloc_pages+171/848] __alloc_pages+0xab/0x350
  [<c013a14b>] __alloc_pages+0xab/0x350
  [do_mount+304/384] do_mount+0x130/0x180
  [<c016f790>] do_mount+0x130/0x180
  [copy_mount_options+135/256] copy_mount_options+0x87/0x100
  [<c016f5e7>] copy_mount_options+0x87/0x100
  [sys_mount+180/288] sys_mount+0xb4/0x120
  [<c016fb74>] sys_mount+0xb4/0x120
  [syscall_call+7/11] syscall_call+0x7/0xb
  [<c010952b>] syscall_call+0x7/0xb


