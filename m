Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269066AbUJKPEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269066AbUJKPEz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 11:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269077AbUJKPA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 11:00:59 -0400
Received: from gprs214-190.eurotel.cz ([160.218.214.190]:33920 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S269063AbUJKO7b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 10:59:31 -0400
Date: Mon, 11 Oct 2004 16:59:11 +0200
From: Pavel Machek <pavel@suse.cz>
To: Stefan Seyfried <seife@suse.de>
Cc: ncunningham@linuxmail.org, linux-kernel@vger.kernel.org,
       pascal.schmidt@email.de
Subject: Re: 2.6.9-rc2-mm1 swsusp bug report.
Message-ID: <20041011145911.GB2672@elf.ucw.cz>
References: <2HO0C-4xh-29@gated-at.bofh.it> <2I5b2-88s-15@gated-at.bofh.it> <2I5E5-6h-19@gated-at.bofh.it> <2I7Zd-1TK-11@gated-at.bofh.it> <E1CB10O-0000HL-FJ@localhost> <20040925101640.GB4039@elf.ucw.cz> <416A58C2.6090304@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416A58C2.6090304@suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > OTOH this is first report of this failure. If it fails once in a blue
> > moon, it is probably better to let it fail than waste memory.
> 
> PM: Attempting to suspend to disk.
> PM: snapshotting memory.
> swsusp: critical section:
> swsusp: Saving Highmem
> [nosave pfn 0x3be]<7>[nosave pfn 0x3bf]swsusp: Need to copy 30519 pages
> suspend: (pages needed: 30519 + 512 free: 100469)
> do_acpi_sleep: page allocation failure. order:7, mode:0x120
>  [<c013a628>] __alloc_pages+0x3a8/0x3b0
>  [<c013a648>] __get_free_pages+0x18/0x30
>  [<c0132c37>] alloc_pagedir+0x17/0x60
>  [<c0132ddb>] swsusp_alloc+0x4b/0xa0
>  [<c0132e63>] suspend_prepare_image+0x33/0x80
>  [<c028beda>] swsusp_arch_suspend+0x2a/0x30
>  [<c0132f1b>] swsusp_suspend+0x2b/0x40
>  [<c01332ad>] pm_suspend_disk+0x3d/0xb0
>  [<c0131765>] enter_state+0x85/0x90
>  [<c01318b1>] state_store+0xc1/0xc3
>  [<c01317f0>] state_store+0x0/0xc3
>  [<c01852e6>] subsys_attr_store+0x26/0x30
>  [<c018548d>] flush_write_buffer+0x1d/0x30
>  [<c01854c9>] sysfs_write_file+0x29/0x40
>  [<c01854a0>] sysfs_write_file+0x0/0x40
>  [<c0150c7f>] vfs_write+0x9f/0x100
>  [<c0150d8c>] sys_write+0x3c/0x70
>  [<c0105c69>] sysenter_past_esp+0x52/0x79
> suspend: Allocating pagedir failed.
> swsusp: Restoring Highmem
> 
> this happened right now, after running fine over the weekend and doing a
> successful suspend/resume cycle this morning.
> It was a "battery critical" suspend, so this is not nice :-( I had about
> 2 minutes left until hard powerdown during which i tried to get it to
> suspend but failed. Yes, userspace should handle the "failed
> battery-critical suspend" case better and probably call "shutdown -h now".

Ok... And I guess it is nearly impossible to trigger this on demand,
right?

I do not think I can use vmalloc easily because reallocate_pagedir
depends on it being contiguous.. Switching to link list is "just a
simple matter of coding", but it is going to be quite a lot of
changes.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
