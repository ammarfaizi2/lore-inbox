Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbTIPLst (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 07:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbTIPLst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 07:48:49 -0400
Received: from gprs149-223.eurotel.cz ([160.218.149.223]:54657 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261836AbTIPLsq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 07:48:46 -0400
Date: Tue, 16 Sep 2003 13:48:23 +0200
From: Pavel Machek <pavel@suse.cz>
To: Mathieu LESNIAK <maverick@eskuel.net>
Cc: LKML <linux-kernel@vger.kernel.org>, mochel@osdl.org
Subject: Re: Nearly succes with suspend to disk in -test5-mm2
Message-ID: <20030916114822.GB602@elf.ucw.cz>
References: <3F660BF7.6060106@eskuel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F660BF7.6060106@eskuel.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I've tested the last kernel of -mm series, -test5-mm2. One of the 
> important feature to me is the suspend to disk, and it's one of the 
> first kernel that suspend fine on my laptop. I'm now able to do a 
> suspend / resume cycle with nearly no problem :)
> However, I saw some oops while resuming. Nothing critical, but if it an 
> help debugging ...
> 
> See the attached file for the syslog part showing suspend / resume with 
> the oops.
> 
> I can give more details on my setup if you want.

cat you try with echo 4 > /proc/acpi/sleep?
										Pavel

> Sep 15 20:46:38 minimaverick kernel: Stopping tasks: ================================|
> Sep 15 20:46:38 minimaverick kernel: Freeing memory: ........................|
> Sep 15 20:46:38 minimaverick kernel: hdc: start_power_step(step: 0)
> Sep 15 20:46:38 minimaverick kernel: hdc: completing PM request, suspend
> Sep 15 20:46:38 minimaverick kernel: hda: start_power_step(step: 0)
> Sep 15 20:46:38 minimaverick kernel: hda: start_power_step(step: 1)
> Sep 15 20:46:38 minimaverick kernel: hda: complete_power_step(step: 1, stat: 50, err: 0)
> Sep 15 20:46:38 minimaverick kernel: hda: completing PM request, suspend
> Sep 15 20:46:38 minimaverick kernel: eth0: remaining active for wake-on-lan
> Sep 15 20:46:38 minimaverick kernel: PM: Attempting to suspend to disk.
> Sep 15 20:46:38 minimaverick kernel: PM: snapshotting memory.
> Sep 15 20:46:38 minimaverick kernel: /critical section: Counting pages to copy[nosave c044d000] (pages needed: 3978+512=4490 free: 44901)
> Sep 15 20:46:38 minimaverick kernel: Alloc pagedir
> Sep 15 20:46:39 minimaverick kernel: [nosave c044d000]<7>PM: Image restored successfully.
> Sep 15 20:46:39 minimaverick kernel: Freeing prev allocated pagedir
> Sep 15 20:46:39 minimaverick kernel: eth0: autonegotiation did not complete in 4000 usec.
> Sep 15 20:46:39 minimaverick kernel: hda: Wakeup request inited, waiting for !BSY...
> Sep 15 20:46:39 minimaverick kernel: hda: start_power_step(step: 1000)
> Sep 15 20:46:39 minimaverick kernel: blk: queue c1377800, I/O limit 4095Mb (mask 0xffffffff)
> Sep 15 20:46:39 minimaverick kernel: hda: completing PM request, resume
> Sep 15 20:46:39 minimaverick kernel: hdc: Wakeup request inited, waiting for !BSY...
> Sep 15 20:46:39 minimaverick kernel: hdc: start_power_step(step: 1000)
> Sep 15 20:46:39 minimaverick kernel: hdc: completing PM request, resume
> Sep 15 20:46:39 minimaverick kernel: Restarting tasks...<3>bad: scheduling while atomic!
> Sep 15 20:46:39 minimaverick kernel: Call Trace:
> Sep 15 20:46:39 minimaverick kernel:  [schedule+1436/1456] schedule+0x59c/0x5b0
> Sep 15 20:46:39 minimaverick kernel:  [wake_up_process+38/48] wake_up_process+0x26/0x30
> Sep 15 20:46:39 minimaverick kernel:  [thaw_processes+164/256] thaw_processes+0xa4/0x100
> Sep 15 20:46:39 minimaverick kernel:  [acpi_pm_finish+20/54] acpi_pm_finish+0x14/0x36
> Sep 15 20:46:39 minimaverick kernel:  [finish+22/64] finish+0x16/0x40
> Sep 15 20:46:39 minimaverick kernel:  [pm_suspend_disk+126/192] pm_suspend_disk+0x7e/0xc0
> Sep 15 20:46:39 minimaverick kernel:  [enter_state+165/176] enter_state+0xa5/0xb0
> Sep 15 20:46:39 minimaverick kernel:  [state_store+103/113] state_store+0x67/0x71
> Sep 15 20:46:39 minimaverick kernel:  [subsys_attr_store+58/64] subsys_attr_store+0x3a/0x40
> Sep 15 20:46:39 minimaverick kernel:  [flush_write_buffer+59/80] flush_write_buffer+0x3b/0x50
> Sep 15 20:46:39 minimaverick kernel:  [sysfs_write_file+96/112] sysfs_write_file+0x60/0x70
> Sep 15 20:46:39 minimaverick kernel:  [sysfs_write_file+0/112] sysfs_write_file+0x0/0x70
> Sep 15 20:46:39 minimaverick kernel:  [vfs_write+184/304] vfs_write+0xb8/0x130
> Sep 15 20:46:39 minimaverick kernel:  [sys_write+66/112] sys_write+0x42/0x70
> Sep 15 20:46:39 minimaverick kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> Sep 15 20:46:39 minimaverick kernel: 
> Sep 15 20:46:39 minimaverick kernel:  done
> Sep 15 20:46:39 minimaverick kernel: bad: scheduling while atomic!
> Sep 15 20:46:39 minimaverick kernel: Call Trace:
> Sep 15 20:46:39 minimaverick kernel:  [schedule+1436/1456] schedule+0x59c/0x5b0
> Sep 15 20:46:39 minimaverick kernel:  [sys_write+66/112] sys_write+0x42/0x70
> Sep 15 20:46:39 minimaverick kernel:  [work_resched+5/22] work_resched+0x5/0x16
> Sep 15 20:46:39 minimaverick kernel: 
> Sep 15 20:46:39 minimaverick kernel: Unable to handle kernel paging request at virtual address 401279b8
> Sep 15 20:46:39 minimaverick kernel:  printing eip:
> Sep 15 20:46:39 minimaverick kernel: 401279b8
> Sep 15 20:46:39 minimaverick kernel: *pde = 084d3067
> Sep 15 20:46:39 minimaverick kernel: *pte = 00000000
> Sep 15 20:46:39 minimaverick kernel: Oops: 0004 [#1]
> Sep 15 20:46:39 minimaverick kernel: PREEMPT 
> Sep 15 20:46:39 minimaverick kernel: CPU:    0
> Sep 15 20:46:39 minimaverick kernel: EIP:    0073:[<401279b8>]    Not tainted VLI
> Sep 15 20:46:39 minimaverick kernel: EFLAGS: 00010246
> Sep 15 20:46:39 minimaverick kernel: EIP is at 0x401279b8
> Sep 15 20:46:39 minimaverick kernel: eax: 00000004   ebx: 00000001   ecx: 080f8c08   edx: 00000004
> Sep 15 20:46:39 minimaverick kernel: esi: 00000004   edi: 080f8c08   ebp: bffff7c8   esp: bffff798
> Sep 15 20:46:39 minimaverick kernel: ds: 007b   es: 007b   ss: 007b
> Sep 15 20:46:39 minimaverick kernel: Process bash (pid: 429, threadinfo=c80f4000 task=ca26f310)
> Sep 15 20:46:39 minimaverick kernel:  <6>note: bash[429] exited with preempt_count 1
> Sep 15 20:46:39 minimaverick kernel: Losing too many ticks!
> Sep 15 20:46:39 minimaverick kernel: TSC cannot be used as a timesource. (Are you running with SpeedStep?)
> Sep 15 20:46:39 minimaverick kernel: Falling back to a sane timesource.
> 


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
