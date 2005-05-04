Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbVEDVx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbVEDVx3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 17:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbVEDVx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 17:53:29 -0400
Received: from UX9.SP.CS.CMU.EDU ([128.2.220.166]:57555 "HELO
	ux9.sp.cs.cmu.edu") by vger.kernel.org with SMTP id S261697AbVEDVxR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 17:53:17 -0400
Date: Wed, 4 May 2005 17:53:11 -0400
To: linux-kernel@vger.kernel.org
Subject: repeatable mm/rmap.c crash in 2.6.11.*
Message-ID: <20050504215311.GA28900@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Eric Cooper <ecc@cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I first noticed this in 2.6.11, and it has been present in each point
release since then.  This is on a machine that runs 2.6.10 with no
problems.  I finally got around to capturing the output over a serial
console, using 2.6.11.8.  It happens on every boot, almost always
before the init scripts are finished.  Here's one example.  I can
provide others, or more info, as needed.  Thanks.

kernel BUG at mm/rmap.c:482!
invalid operand: 0000 [#1]
Modules linked in: af_packet evdev ns558 floppy aic7xxx scsi_mod i2c_piix4 intel_agp snd_bt87x tuner msp3400 bttv video_buf firmware_class i2c_algo_bit v4l2_common btcx_risc tveeprom i2c_core videodev 8139too mii crc32 snd_cs46xx snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc gameport uhci_hcd agpgart rtc ide_cd cdrom
CPU:    0
EIP:    0060:[<c0143e88>]    Not tainted VLI
EFLAGS: 00010282   (2.6.11.8) 
EIP is at page_remove_rmap+0x38/0x50
eax: fffff001   ebx: 00034000   ecx: c1261f00   edx: c1261f00
esi: d3137224   edi: 00084000   ebp: c1261f00   esp: d3103c70
ds: 007b   es: 007b   ss: 0068
Process udev (pid: 2731, threadinfo=d3102000 task=d37a9a00)
Stack: 00084000 00033000 c013d0b8 c1261f00 00000007 00000000 00000020 130f8045 
       00000000 08055000 c0351428 08455000 d30db084 080d9000 00000000 c013d233 
       c0351428 d30db080 08055000 00084000 00000000 08055000 d30db084 080d9000 
Call Trace:
 [<c013d0b8>] zap_pte_range+0x168/0x290
 [<c013d233>] zap_pmd_range+0x53/0x70
 [<c013d293>] zap_pud_range+0x43/0x60
 [<c013d32e>] unmap_page_range+0x7e/0xa0
 [<c013d446>] unmap_vmas+0xf6/0x1f0
 [<c0141fd2>] exit_mmap+0x72/0x140
 [<c0113d0f>] mmput+0x2f/0x80
 [<c0157527>] exec_mmap+0xa7/0x130
 [<c01576ea>] flush_old_exec+0xca/0x6a0
 [<c014d498>] vfs_read+0xc8/0x130
 [<c015746e>] kernel_read+0x4e/0x60
 [<c0173670>] load_elf_binary+0x2e0/0xc30
 [<c0128640>] autoremove_wake_function+0x0/0x60
 [<c0157f06>] search_binary_handler+0x56/0x1b0
 [<c01728b5>] load_script+0x215/0x250
 [<c01343a3>] __alloc_pages+0x2e3/0x420
 [<c01afc86>] copy_from_user+0x46/0x80
 [<c0156f71>] copy_strings+0x1d1/0x220
 [<c0157f06>] search_binary_handler+0x56/0x1b0
 [<c01581e6>] do_execve+0x186/0x220
 [<c01010f2>] sys_execve+0x42/0x80
 [<c01024a3>] syscall_call+0x7/0xb
Code: 34 83 42 08 ff 0f 98 c0 84 c0 74 1b 8b 42 08 40 78 19 c7 04 24 10 00 00 00 b8 ff ff ff ff 89 44 24 04 e8 cc 09 ff ff 83 c4 08 c3 <0f> 0b e2 01 32 a1 28 c0 eb dd 0f 0b df 01 32 a1 28 c0 eb c2 8d 
 <6>note: udev[2731] exited with preempt_count 1
------------[ cut here ]------------
kernel BUG at mm/rmap.c:482!
invalid operand: 0000 [#2]

(etc., etc.)
