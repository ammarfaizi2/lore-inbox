Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVAaQEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVAaQEh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 11:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbVAaQEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 11:04:36 -0500
Received: from bay101-f30.bay101.hotmail.com ([64.4.56.40]:54815 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261242AbVAaQEF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 11:04:05 -0500
Message-ID: <BAY101-F30CAC730D634C205C71635FE7C0@phx.gbl>
X-Originating-IP: [12.2.142.7]
X-Originating-Email: [jay_roplekar@hotmail.com]
From: "Jayant Roplekar" <jay_roplekar@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel bug: mm/rmap.c:483 and related {now 2.6.8}
Date: Mon, 31 Jan 2005 16:03:07 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 31 Jan 2005 16:04:01.0119 (UTC) FILETIME=[7A8556F0:01C507AE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had reported a week ago that with  a custom 2.6.10 (tainted with 
ndiswrapper
a windows driver loader) I got error above and that I could not reproduce it
after Hugh Dickins patch to 2.6.10.  Now I have sudden rash of similar 
errors
and lock ups with 2.6.8.1-10mdk  (my daily use kernel)  in the last couple 
of
days.  This *does not* use Hugh's patch.  I ran  memtest overnight with 19
passes and no errors.   I am enclosing all the lines from /var/log/messages 
apparently
related  to mm  errors [ I am a kernel newbie] .  Thanks,

Jay
P.S. This is 250 lines post, you can jump to  commentary  by searching for 
####
#### As a recap:
I  have VIA motherboard and a matrox AGP card.  Following might be relevant
CONFIG_AGP_VIA=m
CONFIG_DRM=y
CONFIG_DRM_MGA=m

#### Following message appears three times in syslog at (Jan 29 08:27:03 )
####  and at  (Jan 29 08:27:08)  with identical  addresses  and
####  then the machine was rebooted
Jan 29 08:25:02 localhost kernel: Bad page state at prep_new_page (in 
process
'X', page c1251ae0)
Jan 29 08:25:02 localhost kernel: flags:0x20000004 mapping:00006a00 
mapcount:0
count:0
Jan 29 08:25:02 localhost kernel: Backtrace:
Jan 29 08:25:02 localhost kernel:  [dump_stack+30/32] dump_stack+0x1e/0x20
Jan 29 08:25:02 localhost kernel:  [<c0107bfe>] dump_stack+0x1e/0x20
Jan 29 08:25:02 localhost kernel:  [bad_page+108/160] bad_page+0x6c/0xa0
Jan 29 08:25:02 localhost kernel:  [<c013d63c>] bad_page+0x6c/0xa0
Jan 29 08:25:02 localhost kernel:  [prep_new_page+40/112]
prep_new_page+0x28/0x70
Jan 29 08:25:02 localhost kernel:  [<c013d968>] prep_new_page+0x28/0x70
Jan 29 08:25:02 localhost kernel:  [buffered_rmqueue+216/384]
buffered_rmqueue+0xd8/0x180
Jan 29 08:25:02 localhost kernel:  [<c013de58>] buffered_rmqueue+0xd8/0x180
Jan 29 08:25:02 localhost kernel:  [__alloc_pages+161/752]
__alloc_pages+0xa1/0x2f0
Jan 29 08:25:02 localhost kernel:  [<c013dfa1>] __alloc_pages+0xa1/0x2f0
Jan 29 08:25:02 localhost kernel:  [do_anonymous_page+102/368]
do_anonymous_page+0x66/0x170
Jan 29 08:25:02 localhost kernel:  [<c0148796>] do_anonymous_page+0x66/0x170
Jan 29 08:25:03 localhost kernel:  [do_no_page+95/816] do_no_page+0x5f/0x330
Jan 29 08:25:03 localhost kernel:  [<c01488ff>] do_no_page+0x5f/0x330
Jan 29 08:25:03 localhost kernel:  [handle_mm_fault+341/416]
handle_mm_fault+0x155/0x1a0
Jan 29 08:25:03 localhost kernel:  [<c0148e15>] handle_mm_fault+0x155/0x1a0
Jan 29 08:25:03 localhost kernel:  [do_page_fault+396/1456]
do_page_fault+0x18c/0x5b0
Jan 29 08:25:03 localhost kernel:  [<c01198ec>] do_page_fault+0x18c/0x5b0
Jan 29 08:25:03 localhost kernel:  [error_code+45/56] error_code+0x2d/0x38
Jan 29 08:25:03 localhost kernel:  [<c0107849>] error_code+0x2d/0x38
Jan 29 08:25:03 localhost kernel: Trying to fix it up, but a reboot is 
needed

#### After the reboot there were no issues. On the next boot half an hour
####  after the boot following stuff appears in the log
Jan 30 08:33:38 localhost kernel: ------------[ cut here ]------------
Jan 30 08:33:38 localhost kernel: kernel BUG at mm/rmap.c:407!
Jan 30 08:33:38 localhost kernel: invalid operand: 0000 [#1]
Jan 30 08:33:38 localhost kernel: Modules linked in: sd_mod usb-storage
scsi_mod mga md5 ipv6 snd-seq-oss snd-seq-midi-event snd-seq snd-pcm-oss
snd-mixer-oss snd-via82xx snd-ac97-codec snd-pcm snd-timer snd-page-alloc
gameport snd-mpu401-uart snd-rawmidi snd-seq-device snd soundcore af_packet
fealnx mii eth1394 ide-cd cdrom ohci1394 ieee1394 loop ntfs nls_iso8859-1
nls_cp437 vfat fat ndiswrapper via-agp agpgart uhci-hcd usbcore genrtc ext3
jbd
Jan 30 08:33:38 localhost kernel: CPU:    0
Jan 30 08:33:38 localhost kernel: EIP:    0060:[page_remove_rmap+68/112]
Not tainted VLI
Jan 30 08:33:38 localhost kernel: EIP:    0060:[<c014d204>]    Not tainted 
VLI
Jan 30 08:33:38 localhost kernel: EFLAGS: 00010246   (2.6.8.1-10mdk)
Jan 30 08:33:38 localhost kernel: EIP is at page_remove_rmap+0x44/0x70
Jan 30 08:33:38 localhost kernel: eax: 00000000   ebx: 00104000   ecx:
c039f1d0   edx: c1327000
Jan 30 08:33:38 localhost kernel: esi: cda49530   edi: 0032b000   ebp:
cd02bb78   esp: cd02bb78
Jan 30 08:33:38 localhost kernel: ds: 007b   es: 007b   ss: 0068
Jan 30 08:33:38 localhost kernel: Process net_applet (pid: 5428,
threadinfo=cd02a000 task=d125da30)
Jan 30 08:33:38 localhost kernel: Stack: cd02bba4 c014718a c1327000 00000080
00000080 cfbd8ec0 19380045 c1327000
Jan 30 08:33:38 localhost kernel:        08c48000 ce93b08c 08b73000 cd02bbd4
c0147332 c039f1d0 ce93b088 08848000
Jan 30 08:33:38 localhost kernel:        0032b000 00000000 00000000 c039f1d0
08848000 ce93b08c 08b73000 cd02bbfc
Jan 30 08:33:38 localhost kernel: Call Trace:
Jan 30 08:33:38 localhost kernel:  [show_stack+127/160] show_stack+0x7f/0xa0
Jan 30 08:33:38 localhost kernel:  [<c0107bbf>] show_stack+0x7f/0xa0
Jan 30 08:33:38 localhost kernel:  [show_registers+342/464]
show_registers+0x156/0x1d0
Jan 30 08:33:38 localhost kernel:  [<c0107d56>] show_registers+0x156/0x1d0
Jan 30 08:33:38 localhost kernel:  [die+102/208] die+0x66/0xd0
Jan 30 08:33:38 localhost kernel:  [<c0107ef6>] die+0x66/0xd0
Jan 30 08:33:38 localhost kernel:  [do_invalid_op+159/192]
do_invalid_op+0x9f/0xc0
Jan 30 08:33:38 localhost kernel:  [<c01082df>] do_invalid_op+0x9f/0xc0
Jan 30 08:33:38 localhost kernel:  [error_code+45/56] error_code+0x2d/0x38
Jan 30 08:33:38 localhost kernel:  [<c0107849>] error_code+0x2d/0x38
Jan 30 08:33:38 localhost kernel:  [zap_pte_range+314/640]
zap_pte_range+0x13a/0x280
Jan 30 08:33:38 localhost kernel:  [<c014718a>] zap_pte_range+0x13a/0x280
Jan 30 08:33:38 localhost kernel:  [zap_pmd_range+98/128]
zap_pmd_range+0x62/0x80
Jan 30 08:33:38 localhost kernel:  [<c0147332>] zap_pmd_range+0x62/0x80
Jan 30 08:33:38 localhost kernel:  [unmap_page_range+85/144]
unmap_page_range+0x55/0x90
Jan 30 08:33:38 localhost kernel:  [<c01473a5>] unmap_page_range+0x55/0x90
Jan 30 08:33:38 localhost kernel:  [unmap_vmas+249/448] 
unmap_vmas+0xf9/0x1c0
Jan 30 08:33:38 localhost kernel:  [<c01474d9>] unmap_vmas+0xf9/0x1c0
Jan 30 08:33:38 localhost kernel:  [exit_mmap+122/320] exit_mmap+0x7a/0x140
Jan 30 08:33:38 localhost kernel:  [<c014b62a>] exit_mmap+0x7a/0x140
Jan 30 08:33:38 localhost kernel:  [mmput+73/96] mmput+0x49/0x60
Jan 30 08:33:38 localhost kernel:  [<c011c769>] mmput+0x49/0x60
Jan 30 08:33:38 localhost kernel:  [exec_mmap+153/272] exec_mmap+0x99/0x110
Jan 30 08:33:38 localhost kernel:  [<c0160c29>] exec_mmap+0x99/0x110
Jan 30 08:33:38 localhost kernel:  [flush_old_exec+91/560]
flush_old_exec+0x5b/0x230
Jan 30 08:33:38 localhost kernel:  [<c0160d5b>] flush_old_exec+0x5b/0x230
Jan 30 08:33:38 localhost kernel:  [load_elf_binary+910/3328]
load_elf_binary+0x38e/0xd00
Jan 30 08:33:38 localhost kernel:  [<c017d8de>] load_elf_binary+0x38e/0xd00
Jan 30 08:33:38 localhost kernel:  [search_binary_handler+101/512]
search_binary_handler+0x65/0x200
Jan 30 08:33:38 localhost kernel:  [<c0161705>]
search_binary_handler+0x65/0x200
Jan 30 08:33:38 localhost kernel:  [do_execve+384/560] do_execve+0x180/0x230
Jan 30 08:33:38 localhost kernel:  [<c0161a20>] do_execve+0x180/0x230
Jan 30 08:33:38 localhost kernel:  [sys_execve+59/144] sys_execve+0x3b/0x90
Jan 30 08:33:38 localhost kernel:  [<c0105aab>] sys_execve+0x3b/0x90
Jan 30 08:33:38 localhost kernel:  [sysenter_past_esp+82/113]
sysenter_past_esp+0x52/0x71
Jan 30 08:33:38 localhost kernel:  [<c0106dcd>] sysenter_past_esp+0x52/0x71
Jan 30 08:33:38 localhost kernel: Code: 08 75 26 8b 02 a9 00 00 10 00 74 12 
8b
42 10 85 c0 74 2c c7 42 10 00 00 00 00 0f ba 32 14 9c 58 fa ff 0d f0 80 3c 
c0
50 9d 5d c3 <0f> 0b 97 01 85 37 2e c0 eb c6 0f 0b 96 01 85 37 2e c0 eb b5 0f
Jan 30 08:53:37 localhost kernel:  ------------[ cut here ]------------
Jan 30 08:53:37 localhost kernel: kernel BUG at mm/rmap.c:407!
Jan 30 08:53:37 localhost kernel: invalid operand: 0000 [#2]
Jan 30 08:53:37 localhost kernel: Modules linked in: sd_mod usb-storage
scsi_mod mga md5 ipv6 snd-seq-oss snd-seq-midi-event snd-seq snd-pcm-oss
snd-mixer-oss snd-via82xx snd-ac97-codec snd-pcm snd-timer snd-page-alloc
gameport snd-mpu401-uart snd-rawmidi snd-seq-device snd soundcore af_packet
fealnx mii eth1394 ide-cd cdrom ohci1394 ieee1394 loop ntfs nls_iso8859-1
nls_cp437 vfat fat ndiswrapper via-agp agpgart uhci-hcd usbcore genrtc ext3
jbd
Jan 30 08:53:37 localhost kernel: CPU:    0
Jan 30 08:53:37 localhost kernel: EIP:    0060:[page_remove_rmap+68/112]
Not tainted VLI
Jan 30 08:53:37 localhost kernel: EIP:    0060:[<c014d204>]    Not tainted 
VLI
Jan 30 08:53:37 localhost kernel: EFLAGS: 00210246   (2.6.8.1-10mdk)
Jan 30 08:53:37 localhost kernel: EIP is at page_remove_rmap+0x44/0x70
Jan 30 08:53:37 localhost kernel: eax: 00000000   ebx: 0031c000   ecx:
c039f1d0   edx: c1191a00
Jan 30 08:53:37 localhost kernel: esi: cd5edc70   edi: 0038d000   ebp:
d1475e74   esp: d1475e74
Jan 30 08:53:37 localhost kernel: ds: 007b   es: 007b   ss: 0068
Jan 30 08:53:37 localhost kernel: Process pixie (pid: 4271,
threadinfo=d1474000 task=d1471480)
Jan 30 08:53:37 localhost kernel: Stack: d1475ea0 c014718a c1191a00 4278b000
00000001 d1475ed4 0c8d0067 c1191a00
Jan 30 08:53:37 localhost kernel:        42c00000 d262242c 42b8d000 d1475ed0
c0147332 c039f1d0 d2622428 42800000
Jan 30 08:53:37 localhost kernel:        0038d000 00000000 00000000 c039f1d0
42800000 d262242c 42b8d000 d1475ef8
Jan 30 08:53:37 localhost kernel: Call Trace:
Jan 30 08:53:37 localhost kernel:  [show_stack+127/160] show_stack+0x7f/0xa0
Jan 30 08:53:37 localhost kernel:  [<c0107bbf>] show_stack+0x7f/0xa0
Jan 30 08:53:37 localhost kernel:  [show_registers+342/464]
show_registers+0x156/0x1d0
Jan 30 08:53:37 localhost kernel:  [<c0107d56>] show_registers+0x156/0x1d0
Jan 30 08:53:37 localhost kernel:  [die+102/208] die+0x66/0xd0
Jan 30 08:53:37 localhost kernel:  [<c01082df>] do_invalid_op+0x9f/0xc0
Jan 30 08:53:37 localhost kernel:  [error_code+45/56] error_code+0x2d/0x38
Jan 30 08:53:37 localhost kernel:  [<c0107849>] error_code+0x2d/0x38
Jan 30 08:53:37 localhost kernel:  [zap_pte_range+314/640]
zap_pte_range+0x13a/0x280
Jan 30 08:53:37 localhost kernel:  [<c014718a>] zap_pte_range+0x13a/0x280
Jan 30 08:53:37 localhost kernel:  [zap_pmd_range+98/128]
zap_pmd_range+0x62/0x80
Jan 30 08:53:37 localhost kernel:  [<c0147332>] zap_pmd_range+0x62/0x80
Jan 30 08:53:37 localhost kernel:  [unmap_page_range+85/144]
unmap_page_range+0x55/0x90
Jan 30 08:53:37 localhost kernel:  [<c01473a5>] unmap_page_range+0x55/0x90
Jan 30 08:53:37 localhost kernel:  [unmap_vmas+249/448] 
unmap_vmas+0xf9/0x1c0
Jan 30 08:53:37 localhost kernel:  [<c01474d9>] unmap_vmas+0xf9/0x1c0
Jan 30 08:53:37 localhost kernel:  [unmap_region+110/224]
unmap_region+0x6e/0xe0
Jan 30 08:53:37 localhost kernel:  [<c014af6e>] unmap_region+0x6e/0xe0
Jan 30 08:53:37 localhost kernel:  [do_munmap+290/416] do_munmap+0x122/0x1a0
Jan 30 08:53:37 localhost kernel:  [<c014b272>] do_munmap+0x122/0x1a0
Jan 30 08:53:37 localhost kernel:  [sys_munmap+67/112] sys_munmap+0x43/0x70
Jan 30 08:53:37 localhost kernel:  [<c014b333>] sys_munmap+0x43/0x70
Jan 30 08:53:37 localhost kernel:  [sysenter_past_esp+82/113]
sysenter_past_esp+0x52/0x71
Jan 30 08:53:37 localhost kernel:  [<c0106dcd>] sysenter_past_esp+0x52/0x71
Jan 30 08:53:37 localhost kernel: Code: 08 75 26 8b 02 a9 00 00 10 00 74 12 
8b
42 10 85 c0 74 2c c7 42 10 00 00 00 00 0f ba 32 14 9c 58 fa ff 0d f0 80 3c 
c0
50 9d 5d c3 <0f> 0b 97 01 85 37 2e c0 eb c6 0f 0b 96 01 85 37 2e c0 eb b5 0f
Jan 30 08:53:37 localhost kernel:  <0>Bad page state at prep_new_page (in
process 'kjournald', page c1191a00)
Jan 30 08:53:37 localhost kernel: flags:0x20000014 mapping:00000000 
mapcount:0
count:0
Jan 30 08:53:37 localhost kernel: Backtrace:
Jan 30 08:53:37 localhost kernel:  [dump_stack+30/32] dump_stack+0x1e/0x20
Jan 30 08:53:37 localhost kernel:  [<c0107bfe>] dump_stack+0x1e/0x20
Jan 30 08:53:37 localhost kernel:  [bad_page+108/160] bad_page+0x6c/0xa0
Jan 30 08:53:37 localhost kernel:  [<c013d63c>] bad_page+0x6c/0xa0
Jan 30 08:53:37 localhost kernel:  [prep_new_page+40/112]
prep_new_page+0x28/0x70
Jan 30 08:53:37 localhost kernel:  [<c013d968>] prep_new_page+0x28/0x70
Jan 30 08:53:37 localhost kernel:  [buffered_rmqueue+216/384]
buffered_rmqueue+0xd8/0x180
Jan 30 08:53:37 localhost kernel:  [<c013de58>] buffered_rmqueue+0xd8/0x180
Jan 30 08:53:37 localhost kernel:  [__alloc_pages+161/752]
__alloc_pages+0xa1/0x2f0
Jan 30 08:53:37 localhost kernel:  [<c013dfa1>] __alloc_pages+0xa1/0x2f0
Jan 30 08:53:37 localhost kernel:  [find_or_create_page+102/192]
find_or_create_page+0x66/0xc0
Jan 30 08:53:37 localhost kernel:  [<c013a026>] 
find_or_create_page+0x66/0xc0
Jan 30 08:53:37 localhost kernel:  [grow_dev_page+48/320]
grow_dev_page+0x30/0x140
Jan 30 08:53:37 localhost kernel:  [<c0158bf0>] grow_dev_page+0x30/0x140
Jan 30 08:53:37 localhost kernel:  [__getblk_slow+190/384]
__getblk_slow+0xbe/0x180
Jan 30 08:53:37 localhost kernel:  [<c0158dbe>] __getblk_slow+0xbe/0x180
Jan 30 08:53:37 localhost kernel:  [__getblk+87/96] __getblk+0x57/0x60
Jan 30 08:53:37 localhost kernel:  [<c01591c7>] __getblk+0x57/0x60
Jan 30 08:53:37 localhost kernel:  [pg0+541281953/1069604864]
journal_get_descriptor_buffer+0x51/0xb0 [jbd]
Jan 30 08:53:37 localhost kernel:  [<e0824ea1>]
journal_get_descriptor_buffer+0x51/0xb0 [jbd]
Jan 30 08:53:37 localhost kernel:  [pg0+541269430/1069604864]
journal_commit_transaction+0xa66/0x1020 [jbd]
Jan 30 08:53:37 localhost kernel:  [<e0821db6>]
journal_commit_transaction+0xa66/0x1020 [jbd]
Jan 30 08:53:37 localhost kernel:  [pg0+541279318/1069604864]
kjournald+0xa6/0x1f0 [jbd]
Jan 30 08:53:37 localhost kernel:  [<e0824456>] kjournald+0xa6/0x1f0 [jbd]
Jan 30 08:53:37 localhost kernel:  [kernel_thread_helper+5/16]
kernel_thread_helper+0x5/0x10
Jan 30 08:53:37 localhost kernel:  [<c01052c5>] 
kernel_thread_helper+0x5/0x10
Jan 30 08:53:37 localhost kernel: Trying to fix it up, but a reboot is 
needed

#### The machine was up for  4 hours after the above,  then there was
#### following error which  I think is due to above, then I had to do a 
power
#### button due to  lockup
Jan 30 13:32:01 localhost kernel: Assertion failure in journal_dirty_data() 
at
fs/jbd/transaction.c:985: "jh->b_transaction ==
journal->j_committing_transaction"
Jan 30 13:32:01 localhost kernel: ------------[ cut here ]------------
Jan 30 13:32:01 localhost kernel: kernel BUG at fs/jbd/transaction.c:985!


