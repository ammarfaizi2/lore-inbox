Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265996AbUJEVMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265996AbUJEVMZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 17:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266009AbUJEVMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 17:12:25 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:55461 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S265996AbUJEVMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 17:12:14 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: 2.6.9-rc3[+recent swsusp patches]: swsusp kernel-preemption-unfriendly?
Date: Tue, 5 Oct 2004 23:14:25 +0200
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410052314.25253.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It looks like there's a probel with the kernel preemption vs swsusp:

Stopping tasks: 
=============================================================================|
Freeing 
memory: ......................................................................................................................|
PM: Attempting to suspend to disk.
PM: snapshotting memory.
swsusp: critical section:
..<7>[nosave pfn 
0x5be].............................................................................swsusp: 
Need to copy 17764 pages
suspend: (pages needed: 17764 + 512 free: 113115)
..<7>[nosave pfn 
0x5be].............................................................................swsusp: 
critical section/: done (1)
Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP:
<ffffffff8059b5a6>{cpu_init+38}
PML4 bc83067 PGD bfe9067 PMD 0
Oops: 0000 [1] PREEMPT
CPU 0
Modules linked in: usbserial parport_pc lp parport ipv6 joydev sg st sd_mod 
sr_mod scsi_mod usbhid snd_seq_oss snd_seq_midi_event snd_d
Pid: 19437, comm: hibernate.sh Not tainted 2.6.9-rc3
RIP: 0010:[<ffffffff8059b5a6>] <ffffffff8059b5a6>{cpu_init+38}
RSP: 0018:000001000fe93e40  EFLAGS: 00010002
RAX: 0000000000000089 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 000001000fe93e6c RDI: ffffffff80442f50
RBP: 0000000000000004 R08: 0000000000000000 R09: 00000000ffffffff
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff80455d80
R13: 0000000000000002 R14: 0000002a955a4000 R15: 0000000000000000
FS:  0000002a95d330a0(0000) GS:ffffffff8058fb40(0000) knlGS:0000000057c90bb0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000000101000 CR4: 00000000000006e0
Process hibernate.sh (pid: 19437, threadinfo 000001000fe92000, task 
0000010018cb92d0)
Stack: ffffffff80121b49 0000000000000000 0000000000000004 8000895060002080
       00000000ffffffff ffffffff8050bfa0 ffffffff80121d38 0000000000000000
       ffffffff80166dd3 0000000000000000
Call Trace:<ffffffff80121b49>{fix_processor_context+137} 
<ffffffff80121d38>{__restore_processor_state+120}
       <ffffffff80166dd3>{swsusp_suspend+19} 
<ffffffff8016810a>{pm_suspend_disk+90}
       <ffffffff80165b84>{enter_state+68} 
<ffffffff802ceac5>{acpi_system_write_sleep+100}
       <ffffffff8019cf14>{vfs_write+228} <ffffffff8019d053>{sys_write+83}
       <ffffffff801110da>{system_call+126}

Code: 0a 2b 20 2a 20 46 6f 72 20 65 78 61 6d 70 6c 65 2c 20 6f 6e
RIP <ffffffff8059b5a6>{cpu_init+38} RSP <000001000fe93e40>
CR2: 0000000000000000
 <6>note: hibernate.sh[19437] exited with preempt_count 1
bad: scheduling while atomic!

Call Trace:<ffffffff803d2b7e>{schedule+94} <ffffffff80183982>{unmap_vmas+1666}
       <ffffffff80187915>{exit_mmap+293} <ffffffff8013a960>{mmput+272}
       <ffffffff80143724>{do_exit+820} <ffffffff80112449>{oops_end+201}
       <ffffffff80125a0f>{do_page_fault+1247} <ffffffff8013d66d>{printk+141}
       <ffffffff8013d66d>{printk+141} <ffffffff8011198d>{error_exit+0}
       <ffffffff8059b5a6>{cpu_init+38} 
<ffffffff80121b49>{fix_processor_context+137}
       <ffffffff80121d38>{__restore_processor_state+120} 
<ffffffff80166dd3>{swsusp_suspend+19}
       <ffffffff8016810a>{pm_suspend_disk+90} 
<ffffffff80165b84>{enter_state+68}
       <ffffffff802ceac5>{acpi_system_write_sleep+100} 
<ffffffff8019cf14>{vfs_write+228}
       <ffffffff8019d053>{sys_write+83} <ffffffff801110da>{system_call+126}

The system is an x86-64 box.  Please let me know if you need more information.  
Sorry for the noise if it's a known issue.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
