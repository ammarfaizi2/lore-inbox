Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269092AbUIHK05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269092AbUIHK05 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 06:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269079AbUIHK05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 06:26:57 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:28563 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S269092AbUIHK0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 06:26:53 -0400
Date: Wed, 8 Sep 2004 12:26:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Patrick Mochel <mochel@digitalimplant.org>, rjw@sisk.pl,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fw: 2.6.9-rc1-mm4: swsusp + AMD64 = LOCKUP on CPU0
Message-ID: <20040908102652.GA2921@atrey.karlin.mff.cuni.cz>
References: <20040908021637.57525d43.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908021637.57525d43.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> One for you guys on lkml ;)

It simply takes long to count pages (O(n^2) algorithm), so watchdog
triggers. I have better algorithm locally, but would like merge to
linus first. (I posted it to lkml some days ago, I can attach the
bigdiff).

Just disable the watchdog. Suspend *is* going to take time with
disabled interrupts.

								Pavel

> Begin forwarded message:
> 
> Date: Wed, 8 Sep 2004 09:54:09 +0200
> From: "Rafael J. Wysocki" <rjw@sisk.pl>
> To: linux-kernel@vger.kernel.org
> Subject: 2.6.9-rc1-mm4: swsusp + AMD64 = LOCKUP on CPU0
> 
> 
> Sorry for posting it twice, but it seems to me that it didn't make it to the 
> LKML previously:
> 
> I tried the software suspend (echo 4 > /proc/acpi/sleep) on 2.6.9-rc1-mm4 
> (AMD64) and it reported a LOCKUP on CPU0:
> 
> Stopping tasks: ==============================|
> Freeing memory: .....................................|
> PM: Attempting to suspend to disk.
> PM: snapshotting memory.
> swsusp: critical section:
> ..<7>[nosave pfn 
> 0x618].........................................................swsusp: Need 
> to copy 11534 pages
> suspend: (pages needed: 11534 + 512 free: 119345)
> ..<7>[nosave pfn 0x618]...............................................NMI 
> Watchdog detected LOCKUP on CPU0, registers:
> CPU 0
> Modules linked in: usbserial parport_pc lp parport joydev sg st sd_mod sr_mod 
> scsi_mod nvram usbhid powernow_k8 freq_table snd_d
> Pid: 11700, comm: bash Not tainted 2.6.9-rc1-mm4
> RIP: 0010:[<ffffffff801737a4>] <ffffffff801737a4>{is_head_of_free_region+244}
> RSP: 0018:000001001482bd70  EFLAGS: 00000003
> RAX: 0000010001679080 RBX: ffffffff804ad220 RCX: 0000000000000002
> RDX: 00000100016790a8 RSI: 0000000000000030 RDI: ffffffff804ad250
> RBP: 000001000163cc08 R08: 0000000000000002 R09: 0000000000000030
> R10: 000001000140c108 R11: 0000000000000000 R12: 0000000000000004
> R13: 6db6db6db6db6db7 R14: cccccccccccccccd R15: 0000000000000000
> FS:  0000002a95d330a0(0000) GS:ffffffff805e7500(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000002a955a5000 CR3: 0000000000101000 CR4: 00000000000006e0
> Process bash (pid: 11700, threadinfo 000001001482a000, task 000001001f702270)
> Stack: cccccccccccccccd 0000000000000012 000000000001c837 000001001482bdc0
>        0000010000000000 ffffffff8016774c 0000000000002d8e ffffffff804ad220
>        000001000bf425e0 ffffffff80167cdb
> Call Trace:<ffffffff8016774c>{saveable+284} 
> <ffffffff80167cdb>{suspend_prepare_image+971}
>        <ffffffff802ef1ef>{pci_device_suspend+63} 
> <ffffffff80167db6>{swsusp_swap_check+22}
>        <ffffffff8036f9c2>{suspend_device+50} 
> <ffffffff8012233c>{swsusp_arch_suspend+124}
>        <ffffffff8016702c>{swsusp_suspend+12} 
> <ffffffff8016837a>{pm_suspend_disk+90}
>        <ffffffff80165d26>{enter_state+70} 
> <ffffffff80330615>{acpi_system_write_sleep+100}
>        <ffffffff8019c284>{vfs_write+228} <ffffffff8019c3c3>{sys_write+83}
>        <ffffffff8011102a>{system_call+126}
> 
> Code: 48 39 c5 0f 85 9b 00 00 00 48 81 3b 3c 4b 24 1d 74 1d 48 89
> console shuts up ...
> 
> This is 100% reproducible and always happens in is_head_of_free_region().
> 
> The .config and the output of dmesg are attached.
> 
> Greets,
> RJW
> 


-- 
