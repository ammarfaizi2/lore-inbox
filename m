Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262509AbVAERoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262509AbVAERoe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 12:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbVAERmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 12:42:10 -0500
Received: from animx.eu.org ([216.98.75.249]:46995 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S262528AbVAERi5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 12:38:57 -0500
Date: Wed, 5 Jan 2005 12:47:52 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Oops on megaraid.
Message-ID: <20050105174752.GA6859@animx.eu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel: 2.6.8.1 vanilla
Card: Dell PERC DC/2 (megaraid)

The oops happened when I attempted to unload the megaraid module.  Before
doing this, I ran the dellmgr program to reconfigure the raid.

Before the "oops" text, I saw:
Badness in remove_proc_entry at fs/proc/generic.c:688
 [<c017c3fa>] remove_proc_entry+0x10a/0x150
 [<d88f6e3e>] megaraid_exit+0x2e/0x3e [megaraid]
 [<c012c690>] sys_delete_module+0x150/0x1a0
 [<c0142a00>] do_munmap+0x140/0x190
 [<c010513b>] syscall_call+0x7/0xb

That above explains the few lines above "Unable to handle kernel paging..."

This system boots via NFS and / is nfsroot.  There is no swap setup on the
machine since there are no local disks.  The raid there for testing before
moving it to another machine.  The system has 384mb of physical ram.

Oops follows:

ksymoops 2.4.9 on i686 2.6.8.1.  Options used
     -v /lib/modules/2.6.8.1/build/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.8.1/ (default)
     -m /boot/System.map-2.6.8.1 (default)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
 [<c017c3fa>] remove_proc_entry+0x10a/0x150
 [<d88f6e3e>] megaraid_exit+0x2e/0x3e [megaraid]
 [<c012c690>] sys_delete_module+0x150/0x1a0
 [<c0142a00>] do_munmap+0x140/0x190
 [<c010513b>] syscall_call+0x7/0xb
Unable to handle kernel paging request at virtual address 4b87ad72
c017b52e
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c017b52e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010292   (2.6.8.1) 
eax: 4b87ad6e   ebx: d7b68cb4   ecx: 00000004   edx: d7b68c80
esi: 00000004   edi: 4b87ad6e   ebp: 000040f8   esp: d23d3e8c
ds: 007b   es: 007b   ss: 0068
Stack: 00000004 4b87ad6e c017c33c 00000004 d23d3ed4 4b87ad6e d23d3ec8 d23d3ed4 
       d77d9000 d7e6c1d4 d75c4074 d88f6d6a d23d3ed4 d7b68c80 00000000 177db000 
       0000007e d7e6c000 30616268 00000000 00000000 d704dbcc c4087800 d88fab44 
Call Trace:
 [<c017c33c>] remove_proc_entry+0x4c/0x150
 [<d88f6d6a>] megaraid_remove_one+0x34a/0x370 [megaraid]
 [<c01aca7b>] pci_device_remove+0x3b/0x40
 [<c01e5a96>] device_release_driver+0x66/0x70
 [<c01e5acb>] driver_detach+0x2b/0x40
 [<c01e5f7c>] bus_remove_driver+0x4c/0x90
 [<c01e64e3>] driver_unregister+0x13/0x30
 [<c01acce6>] pci_unregister_driver+0x16/0x30
 [<d88f6e4a>] megaraid_exit+0x3a/0x3e [megaraid]
 [<c012c690>] sys_delete_module+0x150/0x1a0
 [<c0142a00>] do_munmap+0x140/0x190
 [<c010513b>] syscall_call+0x7/0xb
Code: 0f b7 48 04 3b 4c 24 0c 74 0d 31 c0 8b 34 24 8b 7c 24 04 83 


>>EIP; c017b52e <proc_match+e/40>   <=====

>>ebx; d7b68cb4 <pg0+1785dcb4/3fcf3000>
>>edx; d7b68c80 <pg0+1785dc80/3fcf3000>
>>esp; d23d3e8c <pg0+120c8e8c/3fcf3000>

Trace; c017c33c <remove_proc_entry+4c/150>
Trace; d88f6d6a <pg0+185ebd6a/3fcf3000>
Trace; c01aca7b <pci_device_remove+3b/40>
Trace; c01e5a96 <device_release_driver+66/70>
Trace; c01e5acb <driver_detach+2b/40>
Trace; c01e5f7c <bus_remove_driver+4c/90>
Trace; c01e64e3 <driver_unregister+13/30>
Trace; c01acce6 <pci_unregister_driver+16/30>
Trace; d88f6e4a <pg0+185ebe4a/3fcf3000>
Trace; c012c690 <sys_delete_module+150/1a0>
Trace; c0142a00 <do_munmap+140/190>
Trace; c010513b <syscall_call+7/b>

Code;  c017b52e <proc_match+e/40>
00000000 <_EIP>:
Code;  c017b52e <proc_match+e/40>   <=====
   0:   0f b7 48 04               movzwl 0x4(%eax),%ecx   <=====
Code;  c017b532 <proc_match+12/40>
   4:   3b 4c 24 0c               cmp    0xc(%esp),%ecx
Code;  c017b536 <proc_match+16/40>
   8:   74 0d                     je     17 <_EIP+0x17>
Code;  c017b538 <proc_match+18/40>
   a:   31 c0                     xor    %eax,%eax
Code;  c017b53a <proc_match+1a/40>
   c:   8b 34 24                  mov    (%esp),%esi
Code;  c017b53d <proc_match+1d/40>
   f:   8b 7c 24 04               mov    0x4(%esp),%edi
Code;  c017b541 <proc_match+21/40>
  13:   83 00 00                  addl   $0x0,(%eax)


1 error issued.  Results may not be reliable.

Modules loaded:
Module                  Size  Used by
reiserfs              244368  0 
dm_mirror              20404  2 
aic7xxx               195544  0 
sd_mod                 16320  0 
megaraid               42376  0 
snd_ymfpci             55236  0 
snd_ac97_codec         66948  1 snd_ymfpci
snd_pcm                86152  1 snd_ymfpci
snd_opl3_lib            8896  1 snd_ymfpci
snd_timer              21316  3 snd_ymfpci,snd_pcm,snd_opl3_lib
snd_hwdep               7076  1 snd_opl3_lib
snd_page_alloc          9032  2 snd_ymfpci,snd_pcm
snd_mpu401_uart         6144  1 snd_ymfpci
snd_rawmidi            20164  1 snd_mpu401_uart
snd_seq_device          6440  2 snd_opl3_lib,snd_rawmidi
snd                    47972  9
snd_ymfpci,snd_ac97_codec,snd_pcm,snd_opl3_lib,snd_timer,snd_hwdep,snd_mpu401_uart,snd_rawmidi,snd_seq_device
ymfpci                 47872  0 
ac97_codec             17004  1 ymfpci
soundcore               7328  2 snd,ymfpci
usbhid                 29664  0 
uhci_hcd               29936  0 
usbcore               103908  4 usbhid,uhci_hcd
piix                   11488  0 [permanent]
ide_core              115868  1 piix
evdev                   7296  0 
sr_mod                 13668  0 
scsi_mod               70432  4 aic7xxx,sd_mod,megaraid,sr_mod
cdrom                  37756  1 sr_mod
isofs                  24228  0 
dm_mod                 56124  1 dm_mirror


-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
