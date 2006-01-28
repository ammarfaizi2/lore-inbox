Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422758AbWA1DVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422758AbWA1DVo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 22:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWA1DVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 22:21:44 -0500
Received: from macferrin.com ([65.98.32.91]:262 "EHLO macferrin.com")
	by vger.kernel.org with ESMTP id S1751380AbWA1DVn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 22:21:43 -0500
Message-ID: <43DAE307.5010306@macferrin.com>
Date: Fri, 27 Jan 2006 20:20:39 -0700
From: Ken MacFerrin <lists@macferrin.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Thunderbird/1.0.7 Mnenhy/0.7
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: kernel BUG at mm/rmap.c:486 - kernel 2.6.15-r1
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I started getting hard lockups on my desktop PC with the error "kernel 
BUG at mm/rmap.c:487" starting with kernel 2.6.13 and continuing through 
2.6.14.  After switching to 2.6.15 the lockups have continued with the 
message "kernel BUG at mm/rmap.c:486".

The frequency and circumstance are completely random which originally 
had me suspecting bad memory but after running Memtest86+ for over 12 
hours without error I'm at a loss.

I'm running the binary Nvidia driver so I'll understand if I can't get 
help here but in searching through the list archives it would seem I'm 
not alone and I am willing to try any patches that may help diagnose the 
issue.  The crash happens at least daily and I've seen no difference in 
running kernels with or without PREEMPT enabled.

The machine is a P4 3.00GHz with 2048MB PC3200 Unbuffered RAM on an ASUS 
motherboard with an ICH5 chipset.  XFX GF 6600GT video card, 600W power 
supply and plenty of cooling.

Below I've included output from ver_linux, syslog and lspci.

Thanks,
Ken

------------------------------------------------------------
### ver_linux output ###
------------------------------------------------------------
mm-home1 linux # sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux mm-home1 2.6.15-gentoo-r1 #4 SMP PREEMPT Wed Jan 25 16:50:47 MST 
2006 i686 Intel(R) Pentium(R) 4 CPU 3.00GHz GenuineIntel GNU/Linux

Gnu C                  3.3.6
Gnu make               3.80
binutils               2.16.1
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.1
e2fsprogs              1.38
jfsutils               1.1.8
reiserfsprogs          3.6.19
reiser4progs           line
xfsprogs               2.6.25
PPP                    2.4.2
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   081
Modules Loaded         ipt_limit iptable_mangle ipt_LOG ipt_MASQUERADE 
ip_nat ipt_TOS ipt_REJECT ip_conntrack_irc ip_conntrack_ftp ipt_state 
ip_conntrack iptable_filter ip_tables snd_seq_midi snd_emu10k1_synth 
snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_emu10k1 snd_rawmidi 
snd_ac97_codec snd_ac97_bus snd_util_mem snd_hwdep eth1394 nls_utf8 
rfcomm bnep l2cap bluetooth dv1394 video1394 raw1394 ohci1394 ieee1394 
3c59x marvell loop nvidia ntfs rtc tsdev
------------------------------------------------------------


------------------------------------------------------------
### /var/log/messages output ###
------------------------------------------------------------
Jan 26 00:26:09 mm-home1 ------------[ cut here ]------------
Jan 26 00:26:09 mm-home1 kernel BUG at mm/rmap.c:486!
Jan 26 00:26:09 mm-home1 invalid operand: 0000 [#1]
Jan 26 00:26:09 mm-home1 PREEMPT SMP
Jan 26 00:26:09 mm-home1 Modules linked in: ipt_limit iptable_mangle 
ipt_LOG ipt_MASQUERADE ip_nat ipt_TOS ipt_REJECT ip_conntrack_irc 
ip_conntrack_ftp ipt_state ip_conntrack iptable_filter ip_tables 
snd_seq_midi snd_emu10k1_synth snd_emux_synth snd_seq_virmidi 
snd_seq_midi_emul snd_emu10k1 snd_rawmidi snd_ac97_codec snd_ac97_bus 
snd_util_mem snd_hwdep eth1394 nls_utf8 rfcomm bnep l2cap bluetooth 
dv1394 video1394 raw1394 ohci1394 ieee1394 3c59x marvell loop nvidia 
ntfs rtc tsdev
Jan 26 00:26:09 mm-home1 CPU:    0
Jan 26 00:26:09 mm-home1 EIP:    0060:[<c0147c05>]    Tainted: P      VLI
Jan 26 00:26:09 mm-home1 EFLAGS: 00010286   (2.6.15-gentoo-r1)
Jan 26 00:26:09 mm-home1 EIP is at page_remove_rmap+0x16/0x2a
Jan 26 00:26:09 mm-home1 eax: ffffffff   ebx: c1c4c404   ecx: 00000038 
  edx: c1c4c404
Jan 26 00:26:09 mm-home1 esi: 00000020   edi: fffb5c4c   ebp: b7713000 
  esp: c5cfbdc4
Jan 26 00:26:09 mm-home1 ds: 007b   es: 007b   ss: 0068
Jan 26 00:26:09 mm-home1 Process thunderbird-bin (pid: 15527, 
threadinfo=c5cfa000 task=cd69d030)
Jan 26 00:26:09 mm-home1 Stack: c0142203 c1c4c404 c1c18348 00000000 
fffffffe f7016180 b7780000 cd69fb74
Jan 26 00:26:09 mm-home1 00000000 cd69fb74 c014238c c220e900 c67a664c 
cd69fb74 b7712000 b7780000
Jan 26 00:26:09 mm-home1 c5cfbe48 00000000 b7780000 cd69fb74 00000001 
c67a664c b7712000 b7780000
Jan 26 00:26:09 mm-home1 Call Trace:
Jan 26 00:26:09 mm-home1 [<c0142203>] zap_pte_range+0x166/0x250
Jan 26 00:26:09 mm-home1 [<c014238c>] unmap_page_range+0x9f/0xed
Jan 26 00:26:09 mm-home1 [<c01424c4>] unmap_vmas+0xea/0x1f1
Jan 26 00:26:09 mm-home1 [<c0146376>] exit_mmap+0x6c/0xff
Jan 26 00:26:09 mm-home1 [<c0116add>] mmput+0x21/0x7a
Jan 26 00:26:09 mm-home1 [<c011ae5a>] do_exit+0x174/0x379
Jan 26 00:26:09 mm-home1 [<c011b120>] sys_exit_group+0x0/0x11
Jan 26 00:26:09 mm-home1 [<c0122c2f>] get_signal_to_deliver+0x2b0/0x2d8
Jan 26 00:26:09 mm-home1 [<c01026dd>] do_signal+0x50/0xc2
Jan 26 00:26:09 mm-home1 [<c012007b>] del_timer+0x9/0x4b
Jan 26 00:26:09 mm-home1 [<c015b291>] pipe_poll+0x1a/0x8e
Jan 26 00:26:09 mm-home1 [<c01395cb>] free_hot_cold_page+0x7a/0x10b
Jan 26 00:26:09 mm-home1 [<c016073c>] poll_freewait+0x37/0x3e
Jan 26 00:26:09 mm-home1 [<c0161224>] sys_poll+0x1dd/0x1e9
Jan 26 00:26:09 mm-home1 [<c0160743>] __pollwait+0x0/0x9b
Jan 26 00:26:09 mm-home1 [<c0102777>] do_notify_resume+0x28/0x39
Jan 26 00:26:09 mm-home1 [<c0102942>] work_notifysig+0x13/0x19
Jan 26 00:26:09 mm-home1 kdm[14992]: X server for display :0 terminated 
unexpectedly
Jan 26 00:26:09 mm-home1 Code: 42 08 0f 94 c0 84 c0 74 0b 6a 01 6a 10 e8 
14 23 ff ff 58 5a c3 8b 54 24 04 f0 83 42 08 ff 0f 98 c0 84 c0 74 19 8b 
42 08 40 79 08 <0f> 0b e6 01 12 82 3e c0 6a ff 6a 10 e8 ea 22 ff ff 59 
58 c3 55
Jan 26 00:26:09 mm-home1 <1>Fixing recursive fault but reboot is needed!
Jan 26 00:26:09 mm-home1 scheduling while atomic: 
thunderbird-bin/0x00000003/15527
Jan 26 00:26:09 mm-home1 [<c03bbb17>] schedule+0x43/0xac0
Jan 26 00:26:09 mm-home1 [<c0119174>] vprintk+0x1f8/0x232
Jan 26 00:26:09 mm-home1 [<c01035eb>] show_trace+0x1e/0x6e
Jan 26 00:26:09 mm-home1 [<c0147c19>] try_to_unmap_one+0x0/0x18c
Jan 26 00:26:09 mm-home1 [<c011ad95>] do_exit+0xaf/0x379
Jan 26 00:26:09 mm-home1 [<c01039fc>] do_trap+0x0/0xc1
Jan 26 00:26:09 mm-home1 [<c0103c5d>] do_invalid_op+0x0/0x86
Jan 26 00:26:09 mm-home1 [<c0103cd7>] do_invalid_op+0x7a/0x86
Jan 26 00:26:09 mm-home1 [<c01203ef>] update_wall_time+0xa/0x32
Jan 26 00:26:09 mm-home1 [<c01206bb>] do_timer+0x2e/0xa3
Jan 26 00:26:09 mm-home1 [<c0147c05>] page_remove_rmap+0x16/0x2a
Jan 26 00:26:09 mm-home1 [<c0134af7>] handle_IRQ_event+0x20/0x4c
Jan 26 00:26:09 mm-home1 [<c0134bcc>] __do_IRQ+0xa9/0xdd
Jan 26 00:26:09 mm-home1 [<c0134bf2>] __do_IRQ+0xcf/0xdd
Jan 26 00:26:09 mm-home1 [<c010486a>] do_IRQ+0x1e/0x24
Jan 26 00:26:09 mm-home1 [<c010327e>] common_interrupt+0x1a/0x20
Jan 26 00:26:09 mm-home1 [<c013007b>] search_module_extables+0x86/0x87
Jan 26 00:26:09 mm-home1 [<c01033d7>] error_code+0x4f/0x54
Jan 26 00:26:09 mm-home1 [<c013007b>] search_module_extables+0x86/0x87
Jan 26 00:26:09 mm-home1 [<c0147c05>] page_remove_rmap+0x16/0x2a
Jan 26 00:26:09 mm-home1 [<c0142203>] zap_pte_range+0x166/0x250
Jan 26 00:26:09 mm-home1 [<c014238c>] unmap_page_range+0x9f/0xed
Jan 26 00:26:09 mm-home1 [<c01424c4>] unmap_vmas+0xea/0x1f1
Jan 26 00:26:09 mm-home1 [<c0146376>] exit_mmap+0x6c/0xff
Jan 26 00:26:09 mm-home1 [<c0116add>] mmput+0x21/0x7a
Jan 26 00:26:09 mm-home1 [<c011ae5a>] do_exit+0x174/0x379
Jan 26 00:26:09 mm-home1 [<c011b120>] sys_exit_group+0x0/0x11
Jan 26 00:26:09 mm-home1 [<c0122c2f>] get_signal_to_deliver+0x2b0/0x2d8
Jan 26 00:26:09 mm-home1 [<c01026dd>] do_signal+0x50/0xc2
Jan 26 00:26:09 mm-home1 [<c012007b>] del_timer+0x9/0x4b
Jan 26 00:26:09 mm-home1 [<c015b291>] pipe_poll+0x1a/0x8e
Jan 26 00:26:09 mm-home1 [<c01395cb>] free_hot_cold_page+0x7a/0x10b
Jan 26 00:26:09 mm-home1 [<c016073c>] poll_freewait+0x37/0x3e
Jan 26 00:26:09 mm-home1 [<c0161224>] sys_poll+0x1dd/0x1e9
Jan 26 00:26:09 mm-home1 [<c0160743>] __pollwait+0x0/0x9b
Jan 26 00:26:09 mm-home1 [<c0102777>] do_notify_resume+0x28/0x39
Jan 26 00:26:09 mm-home1 [<c0102942>] work_notifysig+0x13/0x19
Jan 26 00:26:09 mm-home1 kde(pam_unix)[14996]: session closed for user krm
Jan 26 00:26:09 mm-home1 Unable to handle kernel NULL pointer 
dereference at virtual address 00000020
Jan 26 00:26:09 mm-home1 printing eip:
Jan 26 00:26:09 mm-home1 c025c4ef
Jan 26 00:26:09 mm-home1 *pde = 00000000
Jan 26 00:26:09 mm-home1 Oops: 0000 [#2]
Jan 26 00:26:09 mm-home1 PREEMPT SMP
Jan 26 00:26:09 mm-home1 Modules linked in: ipt_limit iptable_mangle 
ipt_LOG ipt_MASQUERADE ip_nat ipt_TOS ipt_REJECT ip_conntrack_irc 
ip_conntrack_ftp ipt_state ip_conntrack iptable_filter ip_tables 
snd_seq_midi snd_emu10k1_synth snd_emux_synth snd_seq_virmidi 
snd_seq_midi_emul snd_emu10k1 snd_rawmidi snd_ac97_codec snd_ac97_bus 
snd_util_mem snd_hwdep eth1394 nls_utf8 rfcomm bnep l2cap bluetooth 
dv1394 video1394 raw1394 ohci1394 ieee1394 3c59x marvell loop nvidia 
ntfs rtc tsdev
Jan 26 00:26:09 mm-home1 CPU:    1
Jan 26 00:26:09 mm-home1 EIP:    0060:[<c025c4ef>]    Tainted: P      VLI
Jan 26 00:26:09 mm-home1 EFLAGS: 00010297   (2.6.15-gentoo-r1)
Jan 26 00:26:09 mm-home1 EIP is at get_index+0x1b/0x3b
Jan 26 00:26:09 mm-home1 eax: cdd231e4   ebx: ce94bdf4   ecx: ce94bdf0 
  edx: ffffffd8
Jan 26 00:26:09 mm-home1 esi: f71bdcfc   edi: ce94bdf0   ebp: cdd231e4 
  esp: ce94bdd4
Jan 26 00:26:09 mm-home1 ds: 007b   es: 007b   ss: 0068
Jan 26 00:26:09 mm-home1 Process artsd (pid: 15963, threadinfo=ce94a000 
task=f71df550)
Jan 26 00:26:09 mm-home1 Stack: c6625c4c c025c7da cdd231e4 00000000 
ce94bdf0 ce94bdf4 c0141aa8 c6d32eac
Jan 26 00:26:09 mm-home1 c6d72d46 cdd231c8 cdd231f4 c237ec80 f71bdcd4 
c0144919 cdd231e4 f71bdcfc
Jan 26 00:26:09 mm-home1 cdd231c8 f71bdcd4 f7b6af3c b3b00000 00000000 
c0141b73 f71bdcd4 f71bdcd4
Jan 26 00:26:09 mm-home1 Call Trace:
Jan 26 00:26:09 mm-home1 [<c025c7da>] prio_tree_remove+0x30/0xaf
Jan 26 00:26:09 mm-home1 [<c0141aa8>] free_pgd_range+0xc5/0x14a
Jan 26 00:26:09 mm-home1 [<c0144919>] unlink_file_vma+0x27/0x3a
Jan 26 00:26:09 mm-home1 [<c0141b73>] free_pgtables+0x46/0x84
Jan 26 00:26:09 mm-home1 [<c0146395>] exit_mmap+0x8b/0xff
Jan 26 00:26:09 mm-home1 [<c0116add>] mmput+0x21/0x7a
Jan 26 00:26:09 mm-home1 [<c0159498>] exec_mmap+0x19d/0x1bb
Jan 26 00:26:09 mm-home1 [<c0159a74>] flush_old_exec+0x552/0x74d
Jan 26 00:26:09 mm-home1 [<c01592f2>] kernel_read+0x38/0x41
Jan 26 00:26:09 mm-home1 [<c0177027>] load_elf_binary+0x4cd/0xb64
Jan 26 00:26:09 mm-home1 [<c0140ed7>] kunmap_high+0x13/0x80
Jan 26 00:26:09 mm-home1 [<c0140f27>] kunmap_high+0x63/0x80
Jan 26 00:26:09 mm-home1 [<c0158f70>] copy_strings+0x1e5/0x1f2
Jan 26 00:26:09 mm-home1 [<c0176b5a>] load_elf_binary+0x0/0xb64
Jan 26 00:26:09 mm-home1 [<c0159f07>] search_binary_handler+0xd6/0x269
Jan 26 00:26:09 mm-home1 [<c015a205>] do_execve+0x16b/0x207
Jan 26 00:26:09 mm-home1 [<c010170d>] sys_execve+0x2c/0x6d
Jan 26 00:26:09 mm-home1 [<c01028b1>] syscall_call+0x7/0xb
Jan 26 00:26:09 mm-home1 Code: ff d6 ba 01 00 00 00 58 5b 89 d0 5e c3 90 
90 90 53 8b 44 24 08 8b 54 24 0c 8b 4c 24 10 66 83 78 06 00 8b 5c 24 14 
74 17 83 ea 28 <8b> 42 48 89 01 8b 42 08 2b 42 04 c1 e8 0c 03 42 48 48 
eb 08 8b
Jan 26 00:26:09 mm-home1 <6>note: artsd[15963] exited with preempt_count 2
Jan 26 00:26:09 mm-home1 Unable to handle kernel paging request at 
virtual address 005d7533
Jan 26 00:26:09 mm-home1 printing eip:
Jan 26 00:26:09 mm-home1 c01407f2
Jan 26 00:26:09 mm-home1 *pde = 00000000
Jan 26 00:26:09 mm-home1 Oops: 0002 [#3]
Jan 26 00:26:09 mm-home1 PREEMPT SMP
Jan 26 00:26:09 mm-home1 Modules linked in: ipt_limit iptable_mangle 
ipt_LOG ipt_MASQUERADE ip_nat ipt_TOS ipt_REJECT ip_conntrack_irc 
ip_conntrack_ftp ipt_state ip_conntrack iptable_filter ip_tables 
snd_seq_midi snd_emu10k1_synth snd_emux_synth snd_seq_virmidi 
snd_seq_midi_emul snd_emu10k1 snd_rawmidi snd_ac97_codec snd_ac97_bus 
snd_util_mem snd_hwdep eth1394 nls_utf8 rfcomm bnep l2cap bluetooth 
dv1394 video1394 raw1394 ohci1394 ieee1394 3c59x marvell loop nvidia 
ntfs rtc tsdev
Jan 26 00:26:09 mm-home1 CPU:    0
Jan 26 00:26:09 mm-home1 EIP:    0060:[<c01407f2>]    Tainted: P      VLI
Jan 26 00:26:09 mm-home1 EFLAGS: 00210207   (2.6.15-gentoo-r1)
Jan 26 00:26:09 mm-home1 EIP is at vma_prio_tree_remove+0x68/0xbf
Jan 26 00:26:09 mm-home1 eax: c6f57b44   ebx: 005d7507   ecx: f700b514 
  edx: 005d752f
Jan 26 00:26:09 mm-home1 esi: c70be4ec   edi: f700b4ec   ebp: ce911e78 
  esp: ce943f04
Jan 26 00:26:09 mm-home1 ds: 007b   es: 007b   ss: 0068
Jan 26 00:26:09 mm-home1 Process kicker (pid: 15118, threadinfo=ce942000 
task=f7096030)
Jan 26 00:26:09 mm-home1 Stack: ce911e5c ce911e88 f3d0f480 c70be4ec 
c0144919 c70be4ec ce911e78 ce911e5c
Jan 26 00:26:09 mm-home1 c70be4ec c70be494 b63fe000 00000000 c0141b73 
c70be4ec c70be4ec ce943f64
Jan 26 00:26:09 mm-home1 c6d7c9bc f7045300 00000100 c0146395 ce943f64 
c6d7c9bc 00000000 00000000
Jan 26 00:26:09 mm-home1 Call Trace:
Jan 26 00:26:09 mm-home1 [<c0144919>] unlink_file_vma+0x27/0x3a
Jan 26 00:26:09 mm-home1 [<c0141b73>] free_pgtables+0x46/0x84
Jan 26 00:26:09 mm-home1 [<c0146395>] exit_mmap+0x8b/0xff
Jan 26 00:26:09 mm-home1 [<c0116add>] mmput+0x21/0x7a
Jan 26 00:26:09 mm-home1 [<c011ae5a>] do_exit+0x174/0x379
Jan 26 00:26:09 mm-home1 [<c011b120>] sys_exit_group+0x0/0x11
Jan 26 00:26:09 mm-home1 [<c01028b1>] syscall_call+0x7/0xb
Jan 26 00:26:09 mm-home1 Code: 5d e9 dd bf 11 00 39 77 34 74 08 0f 0b 7d 
00 a5 81 3e c0 83 7e 30 00 74 3a 8d 4f 28 8b 57 28 31 db 39 ca 74 11 8b 
41 04 8d 5a d8 <89> 42 04 89 10 89 49 04 89 4f 28 8d 47 28 50 8d 46 28 
50 55 e8
Jan 26 00:26:09 mm-home1 <1>Fixing recursive fault but reboot is needed!
Jan 26 00:26:09 mm-home1 scheduling while atomic: kicker/0x00000002/15118
Jan 26 00:26:09 mm-home1 [<c03bbb17>] schedule+0x43/0xac0
Jan 26 00:26:09 mm-home1 [<c0119174>] vprintk+0x1f8/0x232
Jan 26 00:26:09 mm-home1 [<c01035eb>] show_trace+0x1e/0x6e
Jan 26 00:26:09 mm-home1 [<c0140806>] vma_prio_tree_remove+0x7c/0xbf
Jan 26 00:26:09 mm-home1 [<c011ad95>] do_exit+0xaf/0x379
Jan 26 00:26:09 mm-home1 [<c01039fc>] do_trap+0x0/0xc1
Jan 26 00:26:09 mm-home1 [<c0111ecf>] do_page_fault+0x377/0x4a9
Jan 26 00:26:09 mm-home1 [<c0111b58>] do_page_fault+0x0/0x4a9
Jan 26 00:26:09 mm-home1 [<c01033d7>] error_code+0x4f/0x54
Jan 26 00:26:09 mm-home1 [<c01407f2>] vma_prio_tree_remove+0x68/0xbf
Jan 26 00:26:09 mm-home1 [<c0144919>] unlink_file_vma+0x27/0x3a
Jan 26 00:26:09 mm-home1 [<c0141b73>] free_pgtables+0x46/0x84
Jan 26 00:26:09 mm-home1 [<c0146395>] exit_mmap+0x8b/0xff
Jan 26 00:26:09 mm-home1 [<c0116add>] mmput+0x21/0x7a
Jan 26 00:26:09 mm-home1 [<c011ae5a>] do_exit+0x174/0x379
Jan 26 00:26:09 mm-home1 [<c011b120>] sys_exit_group+0x0/0x11
Jan 26 00:26:09 mm-home1 [<c01028b1>] syscall_call+0x7/0xb
Jan 26 00:26:11 mm-home1 kdm[14992]: X server for display :0 terminated 
unexpectedly
Jan 26 00:26:11 mm-home1 kdm[14992]: Unable to fire up local display :0; 
disabling.
------------------------------------------------------------


------------------------------------------------------------
### lspci -vv output ###
------------------------------------------------------------
mm-home1 linux # lspci -vv
00:00.0 Host bridge: Intel Corporation 82865G/PE/P DRAM 
Controller/Host-Hub Interface (rev 02)
         Subsystem: ASUSTeK Computer Inc. P5P800-MX Mainboard
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
         Latency: 0
         Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
         Capabilities: [e4] Vendor Specific Information
         Capabilities: [a0] AGP version 3.0
                 Status: RQ=32 Iso- ArqSz=2 Cal=2 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                 Command: RQ=1 ArqSz=0 Cal=2 SBA+ AGP+ GART64- 64bit- 
FW+ Rate=x8

00:01.0 PCI bridge: Intel Corporation 82865G/PE/P PCI to AGP Controller 
(rev 02) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
         Memory behind bridge: fa900000-fe9fffff
         Prefetchable memory behind bridge: bff00000-dfefffff
         Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
         BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB 
UHCI Controller #1 (rev 02) (prog-if 00 [UHCI])
         Subsystem: ASUSTeK Computer Inc. P5P800-MX Mainboard
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 19
         Region 4: I/O ports at eec0 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB 
UHCI Controller #2 (rev 02) (prog-if 00 [UHCI])
         Subsystem: ASUSTeK Computer Inc. P5P800-MX Mainboard
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin B routed to IRQ 20
         Region 4: I/O ports at ef00 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB 
UHCI Controller #3 (rev 02) (prog-if 00 [UHCI])
         Subsystem: ASUSTeK Computer Inc. P5P800-MX Mainboard
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin C routed to IRQ 17
         Region 4: I/O ports at ef20 [size=32]

00:1d.3 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB 
UHCI Controller #4 (rev 02) (prog-if 00 [UHCI])
         Subsystem: ASUSTeK Computer Inc. P5P800-MX Mainboard
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 19
         Region 4: I/O ports at ef40 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2 
EHCI Controller (rev 02) (prog-if 20 [EHCI])
         Subsystem: ASUSTeK Computer Inc. P5P800-MX Mainboard
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin D routed to IRQ 18
         Region 0: Memory at febff800 (32-bit, non-prefetchable) [size=1K]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev c2) (prog-if 
00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
         I/O behind bridge: 0000d000-0000dfff
         Memory behind bridge: fea00000-feafffff
         Prefetchable memory behind bridge: 88000000-880fffff
         Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- <SERR- <PERR-
         BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation 82801EB/ER (ICH5/ICH5R) LPC 
Interface Bridge (rev 02)
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE 
Controller (rev 02) (prog-if 8a [Master SecP PriP])
         Subsystem: ASUSTeK Computer Inc. P5P800-MX Mainboard
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 17
         Region 0: I/O ports at <unassigned>
         Region 1: I/O ports at <unassigned>
         Region 2: I/O ports at <unassigned>
         Region 3: I/O ports at <unassigned>
         Region 4: I/O ports at fc00 [size=16]
         Region 5: Memory at 88100000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corporation 82801EB/ER (ICH5/ICH5R) SMBus 
Controller (rev 02)
         Subsystem: ASUSTeK Computer Inc. P4P800 Mainboard
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin B routed to IRQ 10
         Region 4: I/O ports at 0400 [size=32]

01:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce 
6600/GeForce 6600 GT] (rev a2) (prog-if 00 [VGA])
         Subsystem: XFX Pine Group Inc. Unknown device 2165
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 248 (1250ns min, 250ns max)
         Interrupt: pin A routed to IRQ 19
         Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
         Region 1: Memory at c0000000 (32-bit, prefetchable) [size=256M]
         Region 2: Memory at fc000000 (32-bit, non-prefetchable) [size=16M]
         [virtual] Expansion ROM at fe9e0000 [disabled] [size=128K]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [44] AGP version 3.0
                 Status: RQ=256 Iso- ArqSz=0 Cal=3 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
                 Command: RQ=32 ArqSz=2 Cal=0 SBA+ AGP+ GART64- 64bit- 
FW+ Rate=x8

02:05.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001 
Gigabit Ethernet Controller (rev 13)
         Subsystem: ASUSTeK Computer Inc. Marvell 88E8001 Gigabit 
Ethernet Controller (Asus)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (5750ns min, 7750ns max), Cache Line Size 04
         Interrupt: pin A routed to IRQ 16
         Region 0: Memory at feafc000 (32-bit, non-prefetchable) [size=16K]
         Region 1: I/O ports at d800 [size=256]
         Expansion ROM at 88000000 [disabled] [size=128K]
         Capabilities: [48] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
         Capabilities: [50] Vital Product Data

02:0a.0 FireWire (IEEE 1394): Texas Instruments TSB12LV26 IEEE-1394 
Controller (Link) (prog-if 10 [OHCI])
         Subsystem: Accton Technology Corporation Unknown device 1394
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (500ns min, 1000ns max), Cache Line Size 04
         Interrupt: pin A routed to IRQ 16
         Region 0: Memory at feafb800 (32-bit, non-prefetchable) [size=2K]
         Region 1: Memory at feaf4000 (32-bit, non-prefetchable) [size=16K]
         Capabilities: [44] Power Management version 1
                 Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a)
         Subsystem: Creative Labs Unknown device 8066
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (500ns min, 5000ns max)
         Interrupt: pin A routed to IRQ 18
         Region 0: I/O ports at df80 [size=32]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0b.1 Input device controller: Creative Labs SB Live! MIDI/Game Port 
(rev 0a)
         Subsystem: Creative Labs Gameport Joystick
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Region 0: I/O ports at dff0 [size=8]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0c.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] 
(rev 30)
         Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (2500ns min, 2500ns max), Cache Line Size 04
         Interrupt: pin A routed to IRQ 21
         Region 0: I/O ports at dc00 [size=128]
         Region 1: Memory at feafb400 (32-bit, non-prefetchable) [size=128]
         Expansion ROM at 88020000 [disabled] [size=128K]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
------------------------------------------------------------
### END ###
------------------------------------------------------------

