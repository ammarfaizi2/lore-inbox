Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbTH3ACh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 20:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbTH3ABV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 20:01:21 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:16564 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S262051AbTH3AAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 20:00:55 -0400
Date: Fri, 29 Aug 2003 17:00:28 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 1169] New: Consistently getting oops when trying standby or mem 
Message-ID: <910000.1062201628@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1169

           Summary: Consistently getting oops when trying standby or mem
    Kernel Version: arjan's kernel-2.6.0-0.test4.1.32 rpms
            Status: NEW
          Severity: normal
             Owner: len.brown@intel.com
         Submitter: richard.torkar@htu.se


Distribution: rh9
Hardware Environment: DELL latitude L400 laptop, BIOS A09, 
Software Environment:
Problem Description:
Whenever I try to use acpi and standby my computer throws an oops. Same thing
happens when I try to use cat "mem" > /sys/power/state

Steps to reproduce:
cat "mem" > /sys/power/state
or
cat "standby" > /sys/power/state


This first ksymoops output is from somehing that I *think* happened when I
pressed the Fn-Esc (Suspend) on my lapop.
----- BEGIN -----
ksymoops 2.4.9 on i686 2.6.0-0.test4.1.32.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-0.test4.1.32/ (default)
     -m /boot/System.map-2.6.0-0.test4.1.32 (specified)
 
Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Aug 29 22:39:27 lalle kernel: Call Trace:
Aug 29 22:39:27 lalle kernel:  [<c011afed>] __might_sleep+0x5d/0x70
Aug 29 22:39:27 lalle kernel:  [<c010d0ea>] save_v86_state+0x6a/0x200
Aug 29 22:39:27 lalle kernel:  [<c0138f65>] generic_file_aio_write+0x85/0xb0
Aug 29 22:39:27 lalle kernel:  [<c010dc27>] handle_vm86_fault+0xb7/0x900
Aug 29 22:39:27 lalle kernel:  [<d085df24>] ext3_file_write+0x44/0xd0 [ext3]
Aug 29 22:39:27 lalle kernel:  [<c015365b>] do_sync_write+0x8b/0xc0
Aug 29 22:39:27 lalle kernel:  [<c01a4c35>] inode_has_perm+0x65/0xa0
Aug 29 22:39:27 lalle kernel:  [<c010bba0>] do_general_protection+0x0/0xb0
Aug 29 22:39:27 lalle kernel:  [<c010ae29>] error_code+0x2d/0x38
Aug 29 22:39:27 lalle kernel:  [<c010ac7f>] syscall_call+0x7/0xb
Warning (Oops_read): Code line not seen, dumping what data is available
 
 
Trace; c011afed <__might_sleep+5d/70>
Trace; c010d0ea <save_v86_state+6a/200>
Trace; c0138f65 <generic_file_aio_write+85/b0>
Trace; c010dc27 <handle_vm86_fault+b7/900>
Trace; d085df24 <__crc_SELECT_MASK+8de980/c78e6e>
Trace; c015365b <do_sync_write+8b/c0>
Trace; c01a4c35 <inode_has_perm+65/a0>
Trace; c010bba0 <do_general_protection+0/b0>
Trace; c010ae29 <error_code+2d/38>
Trace; c010ac7f <syscall_call+7/b>
 
 
1 warning and 1 error issued.  Results may not be reliable.
----- END -----

This is from actually doing cat "mem" > /sys/power/state
--- BEGIN ---
ksymoops 2.4.9 on i686 2.6.0-0.test4.1.32.  Options used
     -V (default)
     -k /proc/kallsyms (specified)
     -l /proc/modules (specified)
     -o /lib/modules/2.6.0-0.test4.1.32/ (default)
     -m /boot/System.map-2.6.0-0.test4.1.32 (specified)
 
Warning (read_ksyms): no kernel symbols in ksyms, is /proc/kallsyms a valid
ksyms file?
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference
00000000
*pde = 00000000
Oops: 0000 [1]
CPU: 0
EIP: 0060:[<00000000>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
eax: 00000000 ebx: 00000000 ecx: c03334a8 edx: c03332a8
esi: c02fd0c0 edi: 00000004 ebp: c02fd100 esp: c4bffef8
ds: 007b es: 007b ss: 0068
Stack:  c013365d 00000004 c02fd0f8 c4985001 00000008 c0133864 00000004
        c02fd120 c02fd198 c4961610 00000008 c01895ea c02fd120 c4985000 00000008
        c02fff20 c01898fb c02fd130 c02fd198 c4985000 00000008 c5a99a48 c49615f0
Call trace:
[<c013365d>] enter_state+0x4d/0x80
[<c01338b4>] state_store+0x64/0x80
[<c01895ea>] subsys_attr_store+0x3a/0x40
[<c01898fb>] flush_write_buffer+0x36/0x50
[<c0189970>] sysfs_write_file+0x60/0x70
[<c0189910>] sysfs_write_file+0x0/0x70
[<c015377c>] vfs_write+0xec/0x150
[<c0153892>] sys_write+0x42/0x70
[<c010ac2d>] sysenter_past_esp+0x52/0x71
Code:  Bas EIP value.
Warning (Oops_read): Code line not seen, dumping what data is available
 
 
>> EIP; 00000000 Before first symbol
 
>> ecx; c03334a8 <dpm_sem+0/10>
>> edx; c03332a8 <legacy_bus+88/c0>
>> esi; c02fd0c0 <pm_sem+0/10>
>> ebp; c02fd100 <pm_states+20/40>
>> esp; c4bffef8 <__crc_ide_end_drive_cmd+ea344/13f4e9>
 
Trace; c013365d <enter_state+4d/80>
Trace; c01338b4 <state_store+64/80>
Trace; c01895ea <subsys_attr_store+3a/40>
Trace; c01898fb <flush_write_buffer+3b/50>
Trace; c0189970 <sysfs_write_file+60/70>
Trace; c0189910 <sysfs_write_file+0/70>
Trace; c015377c <vfs_write+ec/150>
Trace; c0153892 <sys_write+42/70>
Trace; c010ac2d <sysenter_past_esp+52/71>
 
 
2 warnings issued.  Results may not be reliable.
--- END ---

Just tell me if you need anymore info...


