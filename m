Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbVB0Oej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVB0Oej (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 09:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbVB0Oej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 09:34:39 -0500
Received: from elektron.ikp.physik.tu-darmstadt.de ([130.83.24.72]:38409 "EHLO
	elektron.ikp.physik.tu-darmstadt.de") by vger.kernel.org with ESMTP
	id S261396AbVB0OeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 09:34:05 -0500
From: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16929.55887.378342.684289@hertz.ikp.physik.tu-darmstadt.de>
Date: Sun, 27 Feb 2005 15:33:51 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] partitions/msdos.c
In-Reply-To: <Pine.LNX.4.58.0502261703140.25732@ppc970.osdl.org>
References: <20050226213459.GA21137@apps.cwi.nl>
	<16928.62091.346922.744462@hertz.ikp.physik.tu-darmstadt.de>
	<Pine.LNX.4.58.0502261424430.25732@ppc970.osdl.org>
	<20050226225203.GA25217@apps.cwi.nl>
	<Pine.LNX.4.58.0502261510030.25732@ppc970.osdl.org>
	<20050226234053.GA14236@apps.cwi.nl>
	<Pine.LNX.4.58.0502261546380.25732@ppc970.osdl.org>
	<16929.6319.149849.305237@hertz.ikp.physik.tu-darmstadt.de>
	<Pine.LNX.4.58.0502261703140.25732@ppc970.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Linus" == Linus Torvalds <torvalds@osdl.org> writes:

    Linus> On Sun, 27 Feb 2005, Uwe Bonnes wrote:
    >>  on a Suse 9.2 System with Suse Hotplug, the phantom partition was
    >> somehow recognized as Reiserfs, and then the Hotplug mechanism trying
    >> to mount the bogus partition as a Reiser Filesystem ended in an
    >> Oops...

    Linus> Heh. That oops would be interesting in itself, since it implies
    Linus> that reiserfs is not doing very well on the sanity-checking
    Linus> front.

    Linus> But yes, point taken.

I have to admit, I saw the oops only with a glimpse of the eye, trying to do
other tasks at that moment about a week ago. The oops also left no trace in
the syslog. As syslog is on a reiserfs partition, perhaps reiserfs refused
no write anything after the oops. Trying to reproduce by mounting the bogus
sda4 partition of the usb stick on two different setups, now reiserfs
clearly refuses to mount it. Perhaps the oops was unrelated. 

Find appended an oops happening yesterday, related to reiserfs too. Probably
totally useless, as run on a custom Suse kernel. A reiserfsck after the oops
corrected some errors, perhaps introduced by the oops one week earlier. I
don't understand what to do about the missing ksyms..

B.t.w.: While I have you attention, can I point you to 
http://www.ussg.iu.edu/hypermail/linux/kernel/0410.1/1246.html
where I reported a Linux missbehaviour and a possible patch. I tried to get
the attention of several kernel developpers, to no avail so long ...

Cheers
-- 
Uwe Bonnes                bon@elektron.ikp.physik.tu-darmstadt.de

Institut fuer Kernphysik  Schlossgartenstrasse 9  64289 Darmstadt
--------- Tel. 06151 162516 -------- Fax. 06151 164321 ----------
==undecoded excerpt from the syslog===
Feb 26 18:47:40 r50 kernel: Unable to handle kernel paging request at virtual address 8a5e65b8
Feb 26 18:47:40 r50 kernel:  printing eip:
Feb 26 18:47:40 r50 kernel: c01d1482
Feb 26 18:47:40 r50 kernel: *pde = 00000000
Feb 26 18:47:40 r50 kernel: Oops: 0000 [#1]
Feb 26 18:47:40 r50 kernel: Modules linked in: usb_storage nvram usbserial parport_pc lp parport cpufreq_userspace speedstep_centrino freq_table thermal processor fan button battery ac edd snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc ipv6 pcmcia joydev sg st sd_mod sr_mod scsi_mod ide_cd cdrom subfs nls_utf8 ntfs i2c_i801 i2c_core cinergyT2 dvb_core e1000 ehci_hcd hw_random uhci_hcd ohci1394 ieee1394 yenta_socket rsrc_nonstatic pcmcia_core intel_agp agpgart evdev dm_mod usbcore reiserfs
Feb 26 18:47:40 r50 kernel: CPU:    0
Feb 26 18:47:40 r50 kernel: EIP:    0060:[<c01d1482>]    Tainted: G     U VLI
Feb 26 18:47:40 r50 kernel: EFLAGS: 00010202   (2.6.11-rc4-bk2) 
Feb 26 18:47:40 r50 kernel: EIP is at memcpy+0x12/0x30
Feb 26 18:47:40 r50 kernel: eax: 00000004   ebx: df47b058   ecx: 00000004   edx: 00000010
Feb 26 18:47:40 r50 kernel: esi: 8a5e65b8   edi: df47b058   ebp: c35d7b34   esp: c35d7af4
Feb 26 18:47:40 r50 kernel: ds: 007b   es: 007b   ss: 0068
Feb 26 18:47:40 r50 kernel: Process xauth (pid: 30301, threadinfo=c35d6000 task=c73d5aa0)
Feb 26 18:47:40 r50 kernel: Stack: dfb3c000 df451458 c35d7c94 e0a5acf4 7aaaaa5a c35d7c94 df6a9ad8 e0a70707 
Feb 26 18:47:40 r50 kernel:        df6a9ad8 7aaaaa5a 00000004 df451458 c35d7c94 df6a9ad8 df451458 00000005 
Feb 26 18:47:41 r50 kernel:        c35d7c94 c15cf424 df451458 00000004 c35d7ea8 00000027 00000001 c35d7c94 
Feb 26 18:47:41 r50 kernel: Call Trace:
Feb 26 18:47:41 r50 kernel:  [<e0a5acf4>] replace_key+0x34/0x70 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a70707>] internal_shift_left+0xa7/0xd0 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a70a9a>] balance_internal_when_delete+0x1ca/0x220 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a7114d>] balance_internal+0x5bd/0x800 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<c02f846e>] io_schedule+0xe/0x20
Feb 26 18:47:41 r50 kernel:  [<c0152da9>] bh_lru_install+0x89/0xb0
Feb 26 18:47:41 r50 kernel:  [<c013dc08>] mark_page_accessed+0x28/0x30
Feb 26 18:47:41 r50 kernel:  [<e0a67f3b>] dc_check_balance_internal+0x37b/0x390 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a5ae57>] do_balance+0xc7/0xf0 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a68b1c>] fix_nodes+0x31c/0x360 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a7456e>] reiserfs_cut_from_item+0x32e/0x4e0 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a74a83>] reiserfs_do_truncate+0x2e3/0x540 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a73da8>] reiserfs_delete_object+0x28/0x60 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a5d768>] reiserfs_delete_inode+0x68/0xe0 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<c013e4d9>] truncate_inode_pages+0x9/0x10
Feb 26 18:47:41 r50 kernel:  [<e0a5d700>] reiserfs_delete_inode+0x0/0xe0 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<c01678d4>] generic_delete_inode+0xa4/0x130
Feb 26 18:47:41 r50 kernel:  [<c0167add>] iput+0x4d/0x70
Feb 26 18:47:41 r50 kernel:  [<c015ebfa>] sys_unlink+0xba/0x130
Feb 26 18:47:41 r50 kernel:  [<c014602d>] do_munmap+0xcd/0x100
Feb 26 18:47:41 r50 kernel:  [<c0102c49>] sysenter_past_esp+0x52/0x79
Feb 26 18:47:41 r50 kernel: Code: e0 ff ff 21 e2 3b 42 18 73 06 8b 50 fd 31 c0 c3 31 d2 b8 f2 ff ff ff c3 90 57 56 53 89 c3 89 c8 89 d6 c1 e8 02 89 ca 89 df 89 c1 <f3> a5 f6 c2 02 74 02 66 a5 f6 c2 01 74 01 a4 89 d8 5b 5e 5f c3 
Feb 26 18:47:41 r50 kernel:  Badness in do_exit at kernel/exit.c:790
Feb 26 18:47:41 r50 kernel:  [<c011c0ae>] do_exit+0x2de/0x2f0
Feb 26 18:47:41 r50 kernel:  [<c010448e>] die+0x12e/0x130
Feb 26 18:47:41 r50 kernel:  [<c0114e05>] do_page_fault+0x395/0x588
Feb 26 18:47:41 r50 kernel:  [<c01d1482>] memcpy+0x12/0x30
Feb 26 18:47:41 r50 kernel:  [<e0a765f4>] get_cnode+0x14/0x70 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a7a2a2>] journal_mark_dirty+0x102/0x230 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a6e473>] leaf_copy_items_entirely+0x1d3/0x240 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a6eb43>] leaf_copy_items+0xf3/0x110 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a6ed52>] leaf_move_items+0x62/0x70 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<c0114a70>] do_page_fault+0x0/0x588
Feb 26 18:47:41 r50 kernel:  [<c0103dbb>] error_code+0x2b/0x30
Feb 26 18:47:41 r50 kernel:  [<c01d1482>] memcpy+0x12/0x30
Feb 26 18:47:41 r50 kernel:  [<e0a5acf4>] replace_key+0x34/0x70 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a70707>] internal_shift_left+0xa7/0xd0 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a70a9a>] balance_internal_when_delete+0x1ca/0x220 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a7114d>] balance_internal+0x5bd/0x800 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<c02f846e>] io_schedule+0xe/0x20
Feb 26 18:47:41 r50 kernel:  [<c0152da9>] bh_lru_install+0x89/0xb0
Feb 26 18:47:41 r50 kernel:  [<c013dc08>] mark_page_accessed+0x28/0x30
Feb 26 18:47:41 r50 kernel:  [<e0a67f3b>] dc_check_balance_internal+0x37b/0x390 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a5ae57>] do_balance+0xc7/0xf0 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a68b1c>] fix_nodes+0x31c/0x360 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a7456e>] reiserfs_cut_from_item+0x32e/0x4e0 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a74a83>] reiserfs_do_truncate+0x2e3/0x540 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a73da8>] reiserfs_delete_object+0x28/0x60 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a5d768>] reiserfs_delete_inode+0x68/0xe0 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<c013e4d9>] truncate_inode_pages+0x9/0x10
Feb 26 18:47:41 r50 kernel:  [<e0a5d700>] reiserfs_delete_inode+0x0/0xe0 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<c01678d4>] generic_delete_inode+0xa4/0x130
Feb 26 18:47:41 r50 kernel:  [<c0167add>] iput+0x4d/0x70
Feb 26 18:47:41 r50 kernel:  [<c015ebfa>] sys_unlink+0xba/0x130
Feb 26 18:47:41 r50 kernel:  [<c014602d>] do_munmap+0xcd/0x100
Feb 26 18:47:41 r50 kernel:  [<c0102c49>] sysenter_past_esp+0x52/0x79
Feb 26 18:47:41 r50 kernel: ReiserFS: warning: is_internal: free space seems wrong: level=2, nr_items=169, free_space=16 rdkey 
Feb 26 18:47:41 r50 kernel: ReiserFS: hda5: warning: vs-5150: search_by_key: invalid format found in block 8212. Fsck?
Feb 26 18:47:41 r50 kernel: ReiserFS: hda5: warning: vs-13050: reiserfs_update_sd: i/o failure occurred trying to update [147 150 0x0 SD] stat data
Feb 26 18:47:41 r50 kernel: ReiserFS: warning: is_internal: free space seems wrong: level=2, nr_items=169, free_space=16 rdkey 
Feb 26 18:47:41 r50 kernel: ReiserFS: hda5: warning: vs-5150: search_by_key: invalid format found in block 8212. Fsck?
Feb 26 18:47:41 r50 kernel: ReiserFS: hda5: warning: vs-13050: reiserfs_update_sd: i/o failure occurred trying to update [147 149 0x0 SD] stat data
Feb 26 18:47:41 r50 kernel: ReiserFS: warning: is_internal: free space seems wrong: level=2, nr_items=169, free_space=16 rdkey 
Feb 26 18:47:41 r50 kernel: ReiserFS: hda5: warning: vs-5150: search_by_key: invalid format found in block 8212. Fsck?
Feb 26 18:47:41 r50 kernel: ReiserFS: hda5: warning: vs-13050: reiserfs_update_sd: i/o failure occurred trying to update [147 146 0x0 SD] stat data
Feb 26 18:47:42 r50 kernel: ReiserFS: warning: is_internal: free space seems wrong: level=2, nr_items=169, free_space=16 rdkey 
Feb 26 18:47:42 r50 kernel: ReiserFS: hda5: warning: vs-5150: search_by_key: invalid format found in block 8212. Fsck?
Feb 26 18:47:42 r50 kernel: ReiserFS: hda5: warning: vs-13050: reiserfs_update_sd: i/o failure occurred trying to update [147 146 0x0 SD] stat data
Feb 26 18:47:43 r50 kernel: ReiserFS: warning: is_internal: free space seems wrong: level=2, nr_items=169, free_space=16 rdkey 
Feb 26 18:47:43 r50 kernel: ReiserFS: hda5: warning: vs-5150: search_by_key: invalid format found in block 8212. Fsck?
Feb 26 18:47:43 r50 kernel: ReiserFS: hda5: warning: vs-13050: reiserfs_update_sd: i/o failure occurred trying to update [147 146 0x0 SD] stat data
Feb 26 18:47:44 r50 kernel: ReiserFS: warning: is_internal: free space seems wrong: level=2, nr_items=169, free_space=16 rdkey 
Feb 26 18:47:44 r50 kernel: ReiserFS: hda5: warning: vs-5150: search_by_key: invalid format found in block 8212. Fsck?
Feb 26 18:47:44 r50 kernel: ReiserFS: hda5: warning: vs-13050: reiserfs_update_sd: i/o failure occurred trying to update [147 146 0x0 SD] stat data
=== ksymoops decoded ===
ksymoops 2.4.9 on i686 2.6.11-rc4-bk2.  Options used
     -V (default)
     -k /proc/kallsyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.11-rc4-bk2/ (default)
     -m /boot/System.map-2.6.11-rc4-bk2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (read_ksyms): no kernel symbols in ksyms, is /proc/kallsyms a valid ksyms file?
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Feb 26 18:47:40 r50 kernel: Unable to handle kernel paging request at virtual address 8a5e65b8
Feb 26 18:47:40 r50 kernel: c01d1482
Feb 26 18:47:40 r50 kernel: *pde = 00000000
Feb 26 18:47:40 r50 kernel: Oops: 0000 [#1]
Feb 26 18:47:40 r50 kernel: CPU:    0
Feb 26 18:47:40 r50 kernel: EIP:    0060:[<c01d1482>]    Tainted: G     U VLI
Using defaults from ksymoops -t elf32-i386 -a i386
Feb 26 18:47:40 r50 kernel: EFLAGS: 00010202   (2.6.11-rc4-bk2) 
Feb 26 18:47:40 r50 kernel: eax: 00000004   ebx: df47b058   ecx: 00000004   edx: 00000010
Feb 26 18:47:40 r50 kernel: esi: 8a5e65b8   edi: df47b058   ebp: c35d7b34   esp: c35d7af4
Feb 26 18:47:40 r50 kernel: ds: 007b   es: 007b   ss: 0068
Feb 26 18:47:40 r50 kernel: Stack: dfb3c000 df451458 c35d7c94 e0a5acf4 7aaaaa5a c35d7c94 df6a9ad8 e0a70707 
Feb 26 18:47:40 r50 kernel:        df6a9ad8 7aaaaa5a 00000004 df451458 c35d7c94 df6a9ad8 df451458 00000005 
Feb 26 18:47:41 r50 kernel:        c35d7c94 c15cf424 df451458 00000004 c35d7ea8 00000027 00000001 c35d7c94 
Feb 26 18:47:41 r50 kernel: Call Trace:
Feb 26 18:47:41 r50 kernel:  [<e0a5acf4>] replace_key+0x34/0x70 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a70707>] internal_shift_left+0xa7/0xd0 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a70a9a>] balance_internal_when_delete+0x1ca/0x220 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a7114d>] balance_internal+0x5bd/0x800 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<c02f846e>] io_schedule+0xe/0x20
Feb 26 18:47:41 r50 kernel:  [<c0152da9>] bh_lru_install+0x89/0xb0
Feb 26 18:47:41 r50 kernel:  [<c013dc08>] mark_page_accessed+0x28/0x30
Feb 26 18:47:41 r50 kernel:  [<e0a67f3b>] dc_check_balance_internal+0x37b/0x390 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a5ae57>] do_balance+0xc7/0xf0 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a68b1c>] fix_nodes+0x31c/0x360 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a7456e>] reiserfs_cut_from_item+0x32e/0x4e0 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a74a83>] reiserfs_do_truncate+0x2e3/0x540 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a73da8>] reiserfs_delete_object+0x28/0x60 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a5d768>] reiserfs_delete_inode+0x68/0xe0 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<c013e4d9>] truncate_inode_pages+0x9/0x10
Feb 26 18:47:41 r50 kernel:  [<e0a5d700>] reiserfs_delete_inode+0x0/0xe0 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<c01678d4>] generic_delete_inode+0xa4/0x130
Feb 26 18:47:41 r50 kernel:  [<c0167add>] iput+0x4d/0x70
Feb 26 18:47:41 r50 kernel:  [<c015ebfa>] sys_unlink+0xba/0x130
Feb 26 18:47:41 r50 kernel:  [<c014602d>] do_munmap+0xcd/0x100
Feb 26 18:47:41 r50 kernel:  [<c0102c49>] sysenter_past_esp+0x52/0x79
Feb 26 18:47:41 r50 kernel: Code: e0 ff ff 21 e2 3b 42 18 73 06 8b 50 fd 31 c0 c3 31 d2 b8 f2 ff ff ff c3 90 57 56 53 89 c3 89 c8 89 d6 c1 e8 02 89 ca 89 df 89 c1 <f3> a5 f6 c2 02 74 02 66 a5 f6 c2 01 74 01 a4 89 d8 5b 5e 5f c3 


>>EIP; c01d1482 <memcpy+12/30>   <=====

>>ebx; df47b058 <pg0+1f035058/3fbb8400>
>>edi; df47b058 <pg0+1f035058/3fbb8400>
>>ebp; c35d7b34 <pg0+3191b34/3fbb8400>
>>esp; c35d7af4 <pg0+3191af4/3fbb8400>

Trace; e0a5acf4 <pg0+20614cf4/3fbb8400>
Trace; e0a70707 <pg0+2062a707/3fbb8400>
Trace; e0a70a9a <pg0+2062aa9a/3fbb8400>
Trace; e0a7114d <pg0+2062b14d/3fbb8400>
Trace; c02f846e <io_schedule+e/20>
Trace; c0152da9 <bh_lru_install+89/b0>
Trace; c013dc08 <mark_page_accessed+28/30>
Trace; e0a67f3b <pg0+20621f3b/3fbb8400>
Trace; e0a5ae57 <pg0+20614e57/3fbb8400>
Trace; e0a68b1c <pg0+20622b1c/3fbb8400>
Trace; e0a7456e <pg0+2062e56e/3fbb8400>
Trace; e0a74a83 <pg0+2062ea83/3fbb8400>
Trace; e0a73da8 <pg0+2062dda8/3fbb8400>
Trace; e0a5d768 <pg0+20617768/3fbb8400>
Trace; c013e4d9 <truncate_inode_pages+9/10>
Trace; e0a5d700 <pg0+20617700/3fbb8400>
Trace; c01678d4 <generic_delete_inode+a4/130>
Trace; c0167add <iput+4d/70>
Trace; c015ebfa <sys_unlink+ba/130>
Trace; c014602d <do_munmap+cd/100>
Trace; c0102c49 <sysenter_past_esp+52/79>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c01d1457 <__get_user_4+7/17>
00000000 <_EIP>:
Code;  c01d1457 <__get_user_4+7/17>
   0:   e0 ff                     loopne 1 <_EIP+0x1>
Code;  c01d1459 <__get_user_4+9/17>
   2:   ff 21                     jmp    *(%ecx)
Code;  c01d145b <__get_user_4+b/17>
   4:   e2 3b                     loop   41 <_EIP+0x41>
Code;  c01d145d <__get_user_4+d/17>
   6:   42                        inc    %edx
Code;  c01d145e <__get_user_4+e/17>
   7:   18 73 06                  sbb    %dh,0x6(%ebx)
Code;  c01d1461 <__get_user_4+11/17>
   a:   8b 50 fd                  mov    0xfffffffd(%eax),%edx
Code;  c01d1464 <__get_user_4+14/17>
   d:   31 c0                     xor    %eax,%eax
Code;  c01d1466 <__get_user_4+16/17>
   f:   c3                        ret    
Code;  c01d1467 <bad_get_user+0/9>
  10:   31 d2                     xor    %edx,%edx
Code;  c01d1469 <bad_get_user+2/9>
  12:   b8 f2 ff ff ff            mov    $0xfffffff2,%eax
Code;  c01d146e <bad_get_user+7/9>
  17:   c3                        ret    
Code;  c01d146f <bad_get_user+8/9>
  18:   90                        nop    
Code;  c01d1470 <memcpy+0/30>
  19:   57                        push   %edi
Code;  c01d1471 <memcpy+1/30>
  1a:   56                        push   %esi
Code;  c01d1472 <memcpy+2/30>
  1b:   53                        push   %ebx
Code;  c01d1473 <memcpy+3/30>
  1c:   89 c3                     mov    %eax,%ebx
Code;  c01d1475 <memcpy+5/30>
  1e:   89 c8                     mov    %ecx,%eax
Code;  c01d1477 <memcpy+7/30>
  20:   89 d6                     mov    %edx,%esi
Code;  c01d1479 <memcpy+9/30>
  22:   c1 e8 02                  shr    $0x2,%eax
Code;  c01d147c <memcpy+c/30>
  25:   89 ca                     mov    %ecx,%edx
Code;  c01d147e <memcpy+e/30>
  27:   89 df                     mov    %ebx,%edi
Code;  c01d1480 <memcpy+10/30>
  29:   89 c1                     mov    %eax,%ecx

This decode from eip onwards should be reliable

Code;  c01d1482 <memcpy+12/30>
00000000 <_EIP>:
Code;  c01d1482 <memcpy+12/30>   <=====
   0:   f3 a5                     repz movsl %ds:(%esi),%es:(%edi)   <=====
Code;  c01d1484 <memcpy+14/30>
   2:   f6 c2 02                  test   $0x2,%dl
Code;  c01d1487 <memcpy+17/30>
   5:   74 02                     je     9 <_EIP+0x9>
Code;  c01d1489 <memcpy+19/30>
   7:   66 a5                     movsw  %ds:(%esi),%es:(%edi)
Code;  c01d148b <memcpy+1b/30>
   9:   f6 c2 01                  test   $0x1,%dl
Code;  c01d148e <memcpy+1e/30>
   c:   74 01                     je     f <_EIP+0xf>
Code;  c01d1490 <memcpy+20/30>
   e:   a4                        movsb  %ds:(%esi),%es:(%edi)
Code;  c01d1491 <memcpy+21/30>
   f:   89 d8                     mov    %ebx,%eax
Code;  c01d1493 <memcpy+23/30>
  11:   5b                        pop    %ebx
Code;  c01d1494 <memcpy+24/30>
  12:   5e                        pop    %esi
Code;  c01d1495 <memcpy+25/30>
  13:   5f                        pop    %edi
Code;  c01d1496 <memcpy+26/30>
  14:   c3                        ret    

Feb 26 18:47:41 r50 kernel:  [<c011c0ae>] do_exit+0x2de/0x2f0
Feb 26 18:47:41 r50 kernel:  [<c010448e>] die+0x12e/0x130
Feb 26 18:47:41 r50 kernel:  [<c0114e05>] do_page_fault+0x395/0x588
Feb 26 18:47:41 r50 kernel:  [<c01d1482>] memcpy+0x12/0x30
Feb 26 18:47:41 r50 kernel:  [<e0a765f4>] get_cnode+0x14/0x70 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a7a2a2>] journal_mark_dirty+0x102/0x230 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a6e473>] leaf_copy_items_entirely+0x1d3/0x240 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a6eb43>] leaf_copy_items+0xf3/0x110 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a6ed52>] leaf_move_items+0x62/0x70 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<c0114a70>] do_page_fault+0x0/0x588
Feb 26 18:47:41 r50 kernel:  [<c0103dbb>] error_code+0x2b/0x30
Feb 26 18:47:41 r50 kernel:  [<c01d1482>] memcpy+0x12/0x30
Feb 26 18:47:41 r50 kernel:  [<e0a5acf4>] replace_key+0x34/0x70 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a70707>] internal_shift_left+0xa7/0xd0 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a70a9a>] balance_internal_when_delete+0x1ca/0x220 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a7114d>] balance_internal+0x5bd/0x800 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<c02f846e>] io_schedule+0xe/0x20
Feb 26 18:47:41 r50 kernel:  [<c0152da9>] bh_lru_install+0x89/0xb0
Feb 26 18:47:41 r50 kernel:  [<c013dc08>] mark_page_accessed+0x28/0x30
Feb 26 18:47:41 r50 kernel:  [<e0a67f3b>] dc_check_balance_internal+0x37b/0x390 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a5ae57>] do_balance+0xc7/0xf0 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a68b1c>] fix_nodes+0x31c/0x360 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a7456e>] reiserfs_cut_from_item+0x32e/0x4e0 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a74a83>] reiserfs_do_truncate+0x2e3/0x540 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a73da8>] reiserfs_delete_object+0x28/0x60 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<e0a5d768>] reiserfs_delete_inode+0x68/0xe0 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<c013e4d9>] truncate_inode_pages+0x9/0x10
Feb 26 18:47:41 r50 kernel:  [<e0a5d700>] reiserfs_delete_inode+0x0/0xe0 [reiserfs]
Feb 26 18:47:41 r50 kernel:  [<c01678d4>] generic_delete_inode+0xa4/0x130
Feb 26 18:47:41 r50 kernel:  [<c0167add>] iput+0x4d/0x70
Feb 26 18:47:41 r50 kernel:  [<c015ebfa>] sys_unlink+0xba/0x130
Feb 26 18:47:41 r50 kernel:  [<c014602d>] do_munmap+0xcd/0x100
Feb 26 18:47:41 r50 kernel:  [<c0102c49>] sysenter_past_esp+0x52/0x79

2 warnings issued.  Results may not be reliable.
