Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268959AbUJKNxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268959AbUJKNxl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 09:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268966AbUJKNxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 09:53:41 -0400
Received: from cantor.suse.de ([195.135.220.2]:50360 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268959AbUJKNwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 09:52:55 -0400
Message-ID: <416A58C2.6090304@suse.de>
Date: Mon, 11 Oct 2004 11:56:18 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: ncunningham@linuxmail.org, linux-kernel@vger.kernel.org,
       pascal.schmidt@email.de
Subject: Re: 2.6.9-rc2-mm1 swsusp bug report.
References: <2HO0C-4xh-29@gated-at.bofh.it> <2I5b2-88s-15@gated-at.bofh.it> <2I5E5-6h-19@gated-at.bofh.it> <2I7Zd-1TK-11@gated-at.bofh.it> <E1CB10O-0000HL-FJ@localhost> <20040925101640.GB4039@elf.ucw.cz>
In-Reply-To: <20040925101640.GB4039@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Pavel Machek wrote:

> OTOH this is first report of this failure. If it fails once in a blue
> moon, it is probably better to let it fail than waste memory.

PM: Attempting to suspend to disk.
PM: snapshotting memory.
swsusp: critical section:
swsusp: Saving Highmem
[nosave pfn 0x3be]<7>[nosave pfn 0x3bf]swsusp: Need to copy 30519 pages
suspend: (pages needed: 30519 + 512 free: 100469)
do_acpi_sleep: page allocation failure. order:7, mode:0x120
 [<c013a628>] __alloc_pages+0x3a8/0x3b0
 [<c013a648>] __get_free_pages+0x18/0x30
 [<c0132c37>] alloc_pagedir+0x17/0x60
 [<c0132ddb>] swsusp_alloc+0x4b/0xa0
 [<c0132e63>] suspend_prepare_image+0x33/0x80
 [<c028beda>] swsusp_arch_suspend+0x2a/0x30
 [<c0132f1b>] swsusp_suspend+0x2b/0x40
 [<c01332ad>] pm_suspend_disk+0x3d/0xb0
 [<c0131765>] enter_state+0x85/0x90
 [<c01318b1>] state_store+0xc1/0xc3
 [<c01317f0>] state_store+0x0/0xc3
 [<c01852e6>] subsys_attr_store+0x26/0x30
 [<c018548d>] flush_write_buffer+0x1d/0x30
 [<c01854c9>] sysfs_write_file+0x29/0x40
 [<c01854a0>] sysfs_write_file+0x0/0x40
 [<c0150c7f>] vfs_write+0x9f/0x100
 [<c0150d8c>] sys_write+0x3c/0x70
 [<c0105c69>] sysenter_past_esp+0x52/0x79
suspend: Allocating pagedir failed.
swsusp: Restoring Highmem

this happened right now, after running fine over the weekend and doing a
successful suspend/resume cycle this morning.
It was a "battery critical" suspend, so this is not nice :-( I had about
2 minutes left until hard powerdown during which i tried to get it to
suspend but failed. Yes, userspace should handle the "failed
battery-critical suspend" case better and probably call "shutdown -h now".

      Stefan

