Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264540AbUANUcj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 15:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbUANUcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 15:32:39 -0500
Received: from smtp.uniroma2.it ([160.80.6.16]:54029 "EHLO mail-gw.uniroma2.it")
	by vger.kernel.org with ESMTP id S264540AbUANUce (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 15:32:34 -0500
Message-ID: <4005A6F0.1000906@tiscali.it>
Date: Wed, 14 Jan 2004 21:30:40 +0100
From: Mauro Andreolini <m.andreolini@tiscali.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031118
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniele Venzano <webvenza@libero.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: problems with suspend-to-disk (ACPI), 2.6.1-rc2
References: <20040114165056.GD13899@picchio.gall.it> <3FE5F1110002D60F@mail-4.tiscali.it> <20040114191818.GG13899@picchio.gall.it>
In-Reply-To: <20040114191818.GG13899@picchio.gall.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: scanned for viruses!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniele Venzano wrote:

>On Wed, Jan 14, 2004 at 06:59:36PM +0100, m.andreolini@tiscali.it wrote:
>  
>
>>I can't even 'tcpdump eth0' since the eth0 interface is not brought up correctly
>>on resume:
>>ifconfig yields only the loopback entry.
>>    
>>
>
>If the card isn't even brought up it means that you're lacking power
>management completely for that device.
>
>I'm using pmdisk, perhaps swsusp is using different calls to device drivers,
>and no one has ever written them for sis900.
>I searched documentation on swsusp interface, but found nothing,
>as a matter of fact I assumed that what's in Documentation/power would
>apply to both pmdisk and swsusp, since they're similar implementations.
>
>Check that the patch at:
>http://teg.homeunix.org/kernel_patches.html is in your tree.
>
>If you have time try to match my configuration (2.6.1, pmdisk and sis900
>compiled in) and see if that way it works.
>
>Bye
>
>  
>
Hi Daniele,

I've ricompiled 2.6.1 (sis900.diff was already there) and used the 
pmdisk implementation. The bash still crashes
during resume, but the network card is working. The dmesg output is as 
follows:

<snip>

Stopping tasks: =====================|
Freeing memory: ....................|
hdc: start_power_step(step: 0)
hdc: completing PM request, suspend
hda: start_power_step(step: 0)
hda: start_power_step(step: 1)
hda: complete_power_step(step: 1, stat: 50, err: 0)
hda: completing PM request, suspend
PM: Attempting to suspend to disk.
PM: snapshotting memory.
PM: Image restored successfully.
bad: scheduling while atomic!
Call Trace:
 [<c0119d36>] schedule+0x586/0x590
 [<c0124f7c>] __mod_timer+0xfc/0x170
 [<c0125ad3>] schedule_timeout+0x63/0xc0
 [<c0125a60>] process_timeout+0x0/0x10
 [<c01da6ab>] pci_set_power_state+0xeb/0x190
 [<c02338f3>] sis900_resume+0x63/0x130
 [<c01dcc06>] pci_device_resume+0x26/0x30
 [<c021ecc9>] resume_device+0x29/0x30
 [<c021ed04>] dpm_resume+0x34/0x60
 [<c021ed49>] device_resume+0x19/0x30
 [<c0137228>] finish+0x8/0x40
 [<c0138195>] pmdisk_free+0x5/0x10
 [<c013738e>] pm_suspend_disk+0x7e/0xc0
 [<c0135025>] enter_state+0xa5/0xb0
 [<c013511c>] state_store+0x6c/0x76
 [<c01889aa>] subsys_attr_store+0x3a/0x40
 [<c0188c7b>] flush_write_buffer+0x3b/0x50
 [<c0188cf0>] sysfs_write_file+0x60/0x70
 [<c015477e>] vfs_write+0xbe/0x130
 [<c01548a2>] sys_write+0x42/0x70
 [<c010949b>] syscall_call+0x7/0xb

hda: Wakeup request inited, waiting for !BSY...
hda: start_power_step(step: 1000)
blk: queue ebd6ca00, I/O limit 4095Mb (mask 0xffffffff)
hda: completing PM request, resume
hdc: Wakeup request inited, waiting for !BSY...
hdc: start_power_step(step: 1000)
hdc: completing PM request, resume
Restarting tasks...<3>bad: scheduling while atomic!
Call Trace:
 [<c0119d36>] schedule+0x586/0x590
 [<c0118efe>] try_to_wake_up+0x9e/0x160
 [<c0118fde>] wake_up_process+0x1e/0x20
 [<c0135438>] thaw_processes+0xb8/0x100
 [<c01f63f9>] acpi_pm_finish+0x14/0x38
 [<c0137236>] finish+0x16/0x40
 [<c013738e>] pm_suspend_disk+0x7e/0xc0
 [<c0135025>] enter_state+0xa5/0xb0
 [<c013511c>] state_store+0x6c/0x76
 [<c01889aa>] subsys_attr_store+0x3a/0x40
 [<c0188c7b>] flush_write_buffer+0x3b/0x50
 [<c0188cf0>] sysfs_write_file+0x60/0x70
 [<c015477e>] vfs_write+0xbe/0x130
 [<c01548a2>] sys_write+0x42/0x70
 [<c010949b>] syscall_call+0x7/0xb

 done
bad: scheduling while atomic!
Call Trace:
 [<c0119d36>] schedule+0x586/0x590
 [<c01548a2>] sys_write+0x42/0x70
 [<c01094c2>] work_resched+0x5/0x16

bad: scheduling while atomic!
Call Trace:
 [<c0119d36>] schedule+0x586/0x590
 [<c01187d6>] fixup_exception+0x16/0x40
 [<c0117b8e>] __is_prefetch+0x6e/0x220
 [<c0117e50>] do_page_fault+0x110/0x512
 [<c011dd3d>] printk+0x11d/0x180
 [<c011abe7>] sys_sched_yield+0x87/0xd0
 [<c0160cb8>] coredump_wait+0x38/0xa0
 [<c0160e0b>] do_coredump+0xeb/0x1ec
 [<c0118ffa>] wake_up_state+0x1a/0x20
 [<c0126e24>] specific_send_sig_info+0xc4/0x130
 [<c0126838>] __dequeue_signal+0xe8/0x190
 [<c0126915>] dequeue_signal+0x35/0xa0
 [<c0128dea>] get_signal_to_deliver+0x20a/0x380
 [<c0109272>] do_signal+0xe2/0x120
 [<c0118d50>] recalc_task_prio+0x90/0x1a0
 [<c0119ae4>] schedule+0x334/0x590
 [<c0117d40>] do_page_fault+0x0/0x512
 [<c0109309>] do_notify_resume+0x59/0x5c
 [<c01094e6>] work_notifysig+0x13/0x15

note: bash[3588] exited with preempt_count 1
eth0: Abnormal interrupt,status 0x03008001.
eth0: Media Link On 100mbps full-duplex

<end of snip>

Thanks for the help.

Bye
Mauro Andreolini

