Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbVAJAoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbVAJAoL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 19:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVAJAoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 19:44:10 -0500
Received: from dsl-kpogw5jd0.dial.inet.fi ([80.223.105.208]:24515 "EHLO
	safari.iki.fi") by vger.kernel.org with ESMTP id S262056AbVAJAnK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 19:43:10 -0500
Date: Mon, 10 Jan 2005 02:43:07 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.10-ac8 oops in cache_alloc_refill
Message-ID: <20050110004307.GA10288@m.safari.iki.fi>
Mail-Followup-To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.9 (patched to death) worked nicely for the last 15 days,
then I thought I could try if VM+USB had improved in 2.6.10.
I did basically "make oldconfig" and added a couple of patches...
(akpm-vmscan-update-total_scanned, ipt_ECN fix, readpage-vs-invalidate_fix,
invalidate_inode_pages2_mmap_coherency, exec-shield from Fedora,
vmscan-count_writeback_pages_in_nr_scanned, various cond_resched fixes by Ingo,
sched fixes/tunings from yesterday's bk, perfctr-2.7.8).

Linux safari.finland.fbi 2.6.10-ac8 #8 Mon Jan 10 00:23:40 EET 2005 i686 i686 i386 GNU/Linux
 
Gnu C                  3.4.3
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12
mount                  2.12
module-init-tools      3.1-pre5
e2fsprogs              1.35
jfsutils               1.1.7
reiserfsprogs          3.6.19
reiser4progs           line
xfsprogs               2.3.9
pcmcia-cs              3.2.7
quota-tools            3.12.
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Procps                 3.2.4
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1

This is Celeron UP, no preempt, 8k stacks,
and memtest runs without errors, I don't get MCEs
and microcode is updated to the latest one. 
http://safari.iki.fi/config-2.6.10-ac8.txt
http://safari.iki.fi/lspci-2.6.10-ac8.txt

I am now running kernel with CONFIG_DEBUG_SLAB=y and I also
applied linux-2.6.10-periodic-slab-debug.patch, hopefully
it catches something.

Jan  9 22:52:00 safari kernel: Unable to handle kernel paging request at virtual address 1400000c
Jan  9 22:52:00 safari kernel:  printing eip:
Jan  9 22:52:00 safari kernel: c01441b3
Jan  9 22:52:00 safari kernel: *pde = 00000000
Jan  9 22:52:00 safari kernel: Oops: 0002 [#1]
Jan  9 22:52:00 safari kernel: Modules linked in: nls_iso8859_1 nls_cp437 vfat
	fat ipt_multiport ohci_hcd binfmt_misc sch_hfsc sch_htb sch_sfq cls_fw cls_u32
	cls_route sch_ingress sch_red sch_tbf sch_teql sch_prio sch_gred cls_rsvp
	cls_rsvp6 cls_tcindex sch_cbq sch_dsmark xfs loop snd_seq_oss
	snd_seq_midi_event snd_seq lp parport_pc parport tuner tvaudio w83781d msp3400
	bttv i2c_sensor video_buf i2c_algo_bit i2c_piix4 v4l2_common btcx_risc
	videodev i2c_core ipt_owner usb_storage ipt_length ipt_connlimit ipt_TARPIT
	dm_mod ipt_ECN uhci_hcd snd_ens1371 snd_rawmidi snd_seq_device snd_ac97_codec
	snd_pcm_oss ipt_REJECT snd_mixer_oss ip6t_LOG ipt_LOG ipt_limit snd_pcm
	ipt_state ip6table_mangle ip6table_filter snd_timer ip6_tables snd soundcore
	iptable_filter iptable_mangle iptable_nat ip_conntrack snd_page_alloc
	ip_tables gameport irlan irda crc_ccitt 8139too mii floppy
Jan  9 22:52:00 safari kernel: CPU:    0
Jan  9 22:52:00 safari kernel: EIP:    0060:[<c01441b3>]    Not tainted VLI
Jan  9 22:52:00 safari kernel: EFLAGS: 00010012   (2.6.10-ac8) 
Jan  9 22:52:00 safari kernel: EIP is at cache_alloc_refill+0xe3/0x200
Jan  9 22:52:00 safari kernel: eax: 14000008   ebx: cfc9e480   ecx: c7195000   edx: c13148ec
Jan  9 22:52:00 safari kernel: esi: 00000002   edi: c13148ec   ebp: cd137ce0   esp: cd137cb8
Jan  9 22:52:00 safari kernel: ds: 007b   es: 007b   ss: 0068
Jan  9 22:52:00 safari kernel: Process squid (pid: 27369, threadinfo=cd136000 task=cdbb89e0)
Jan  9 22:52:00 safari kernel: Stack: 00000003 00000000 00000000 c9edf018 cfc9e490 c13148ec c13148f4 00000282 
Jan  9 22:52:00 safari kernel:        000000d0 c13148e0 cd137cfc c01444d8 c13148e0 000000d0 ce1bf800 c01ac080 
Jan  9 22:52:00 safari kernel:        cd137d68 cd137d0c c01ac09c c13148e0 000000d0 cd137d28 c0171d1e ce1bf800 
Jan  9 22:52:00 safari kernel: Call Trace:
Jan  9 22:52:00 safari kernel:  [<c0103edf>] show_stack+0x7f/0xa0
Jan  9 22:52:00 safari kernel:  [<c0104076>] show_registers+0x156/0x1d0
Jan  9 22:52:00 safari kernel:  [<c0104278>] die+0xc8/0x150
Jan  9 22:52:00 safari kernel:  [<c0115b12>] do_page_fault+0x4a2/0x6d9
Jan  9 22:52:00 safari kernel:  [<c0103b7f>] error_code+0x2b/0x30
Jan  9 22:52:00 safari kernel:  [<c01444d8>] kmem_cache_alloc+0x68/0x70
Jan  9 22:52:00 safari kernel:  [<c01ac09c>] reiserfs_alloc_inode+0x1c/0x30
Jan  9 22:52:00 safari kernel:  [<c0171d1e>] alloc_inode+0x1e/0x1a0
Jan  9 22:52:00 safari kernel:  [<c017285d>] get_new_inode+0x1d/0x120
Jan  9 22:52:00 safari kernel:  [<c01a1385>] reiserfs_iget+0x45/0xc0
Jan  9 22:52:00 safari kernel:  [<c019bafc>] reiserfs_lookup+0xec/0x160
Jan  9 22:52:00 safari kernel:  [<c016624c>] real_lookup+0xcc/0xf0
Jan  9 22:52:00 safari kernel:  [<c01664bc>] do_lookup+0x8c/0xa0
Jan  9 22:52:00 safari kernel:  [<c0166b8d>] link_path_walk+0x6bd/0xcf0
Jan  9 22:52:00 safari kernel:  [<c0167418>] path_lookup+0x78/0x170
Jan  9 22:52:00 safari kernel:  [<c0167cfe>] open_namei+0x8e/0x680
Jan  9 22:52:00 safari kernel:  [<c015829a>] filp_open+0x3a/0x60
Jan  9 22:52:00 safari kernel:  [<c0158636>] sys_open+0x46/0xa0
Jan  9 22:52:00 safari kernel:  [<c0103123>] syscall_call+0x7/0xb
Jan  9 22:52:00 safari kernel: Code: ff 03 8b 51 10 0f b7 41 14 42 89 51 10 8b 7d e4 0f b7 04 47 66 89 41 14 8b 45 08 3b 50 3c 73 06 4e 83 fe ff 75 c2 8b 51 04 8b 01 <89> 50 04 89 02 66 83 79 14 ff c7 01 00 01 10 00 c7 41 04 00 02 



Jan  9 22:53:56 safari kernel:  <1>Unable to handle kernel paging request at virtual address 1400000c
Jan  9 22:53:56 safari kernel:  printing eip:
Jan  9 22:53:56 safari kernel: c01441b3
Jan  9 22:53:56 safari kernel: *pde = 00000000
Jan  9 22:53:56 safari kernel: Oops: 0002 [#4]
Jan  9 22:53:56 safari kernel: Modules linked in: x 
Jan  9 22:53:56 safari kernel: CPU:    0
Jan  9 22:53:56 safari kernel: EIP:    0060:[<c01441b3>]    Not tainted VLI
Jan  9 22:53:56 safari kernel: EFLAGS: 00010012   (2.6.10-ac8) 
Jan  9 22:53:56 safari kernel: EIP is at cache_alloc_refill+0xe3/0x200
Jan  9 22:53:56 safari kernel: eax: 14000008   ebx: cfc9e480   ecx: c7195000   edx: c13148ec
Jan  9 22:53:56 safari kernel: esi: 00000010   edi: c13148ec   ebp: ccdc9e28   esp: ccdc9e00
Jan  9 22:53:56 safari kernel: ds: 007b   es: 007b   ss: 0068
Jan  9 22:53:56 safari kernel: Process qmail-queue (pid: 2054, threadinfo=ccdc8000 task=ca4700a0)
Jan  9 22:53:56 safari kernel: Stack: c059ab04 ccdc9e30 ccdc9e94 00000000 cfc9e490 c13148ec c13148f4 00000286 
Jan  9 22:53:56 safari kernel:        000000d0 c13148e0 ccdc9e44 c01444d8 c13148e0 000000d0 00000003 c01ac080 
Jan  9 22:53:56 safari kernel:        cb2aebfc ccdc9e54 c01ac09c c13148e0 000000d0 ccdc9e70 c0171d1e ce1bfa00 
Jan  9 22:53:56 safari kernel: Call Trace:
Jan  9 22:53:56 safari kernel:  [<c0103edf>] show_stack+0x7f/0xa0
Jan  9 22:53:56 safari kernel:  [<c0104076>] show_registers+0x156/0x1d0
Jan  9 22:53:56 safari kernel:  [<c0104278>] die+0xc8/0x150
Jan  9 22:53:56 safari kernel:  [<c0115b12>] do_page_fault+0x4a2/0x6d9
Jan  9 22:53:56 safari kernel:  [<c0103b7f>] error_code+0x2b/0x30
Jan  9 22:53:56 safari kernel:  [<c01444d8>] kmem_cache_alloc+0x68/0x70
Jan  9 22:53:56 safari kernel:  [<c01ac09c>] reiserfs_alloc_inode+0x1c/0x30
Jan  9 22:53:56 safari kernel:  [<c0171d1e>] alloc_inode+0x1e/0x1a0
Jan  9 22:53:56 safari kernel:  [<c01727da>] new_inode+0x1a/0x60
Jan  9 22:53:56 safari kernel:  [<c019c280>] reiserfs_create+0x20/0x280
Jan  9 22:53:56 safari kernel:  [<c016795f>] vfs_create+0xcf/0x140
Jan  9 22:53:56 safari kernel:  [<c0167d51>] open_namei+0xe1/0x680
Jan  9 22:53:56 safari kernel:  [<c015829a>] filp_open+0x3a/0x60
Jan  9 22:53:56 safari kernel:  [<c0158636>] sys_open+0x46/0xa0
Jan  9 22:53:56 safari kernel:  [<c0103123>] syscall_call+0x7/0xb
Jan  9 22:53:56 safari kernel: Code: ff 03 8b 51 10 0f b7 41 14 42 89 51 10 8b 7d e4 0f b7 04 47 66 89 41 14 8b 45 08 3b 50 3c 73 06 4e 83 fe ff 75 c2 8b 51 04 8b 01 <89> 50 04 89 02 66 83 79 14 ff c7 01 00 01 10 00 c7 41 04 00 02 



Jan  9 23:00:52 safari kernel:  <3>Debug: sleeping function called from invalid context at mm/rmap.c:86
Jan  9 23:00:52 safari kernel: in_atomic():0, irqs_disabled():1
Jan  9 23:00:52 safari kernel:  [<c0103f1e>] dump_stack+0x1e/0x20
Jan  9 23:00:52 safari kernel:  [<c011ba45>] __might_sleep+0x95/0xb0
Jan  9 23:00:52 safari kernel:  [<c014f127>] anon_vma_prepare+0x27/0xa0
Jan  9 23:00:52 safari kernel:  [<c014cf04>] expand_stack+0x14/0x110
Jan  9 23:00:52 safari kernel:  [<c01157ee>] do_page_fault+0x17e/0x6d9
Jan  9 23:00:52 safari kernel:  [<c0103b7f>] error_code+0x2b/0x30
Jan  9 23:00:52 safari kernel:  [<c01444d8>] kmem_cache_alloc+0x68/0x70
Jan  9 23:00:52 safari kernel:  [<c01ac09c>] reiserfs_alloc_inode+0x1c/0x30
Jan  9 23:00:52 safari kernel:  [<c0171d1e>] alloc_inode+0x1e/0x1a0
Jan  9 23:00:52 safari kernel:  [<c017285d>] get_new_inode+0x1d/0x120
Jan  9 23:00:52 safari kernel:  [<c01a1385>] reiserfs_iget+0x45/0xc0
Jan  9 23:00:52 safari kernel:  [<c019bafc>] reiserfs_lookup+0xec/0x160
Jan  9 23:00:52 safari kernel:  [<c016624c>] real_lookup+0xcc/0xf0
Jan  9 23:00:52 safari kernel:  [<c01664bc>] do_lookup+0x8c/0xa0
Jan  9 23:00:52 safari kernel:  [<c0166b8d>] link_path_walk+0x6bd/0xcf0
Jan  9 23:00:52 safari kernel:  [<c0167418>] path_lookup+0x78/0x170
Jan  9 23:00:52 safari kernel:  [<c0167cfe>] open_namei+0x8e/0x680
Jan  9 23:00:52 safari kernel:  [<c015829a>] filp_open+0x3a/0x60
Jan  9 23:00:52 safari kernel:  [<c0158636>] sys_open+0x46/0xa0
Jan  9 23:00:52 safari kernel:  [<c0103123>] syscall_call+0x7/0xb
Jan  9 23:00:52 safari kernel: Unable to handle kernel paging request at virtual address 1400000c
Jan  9 23:00:52 safari kernel:  printing eip:
Jan  9 23:00:52 safari kernel: c01441b3
Jan  9 23:00:52 safari kernel: *pde = 00000000
Jan  9 23:00:52 safari kernel: Oops: 0002 [#8]
Jan  9 23:00:52 safari kernel: Modules linked in: x 
Jan  9 23:00:52 safari kernel: CPU:    0
Jan  9 23:00:52 safari kernel: EIP:    0060:[<c01441b3>]    Not tainted VLI
Jan  9 23:00:52 safari kernel: EFLAGS: 00010012   (2.6.10-ac8) 
Jan  9 23:00:52 safari kernel: EIP is at cache_alloc_refill+0xe3/0x200
Jan  9 23:00:52 safari kernel: eax: 14000008   ebx: cfc9e480   ecx: c7195000   edx: c13148ec
Jan  9 23:00:52 safari kernel: esi: 00000010   edi: c13148ec   ebp: cbe6bce0   esp: cbe6bcb8
Jan  9 23:00:52 safari kernel: ds: 007b   es: 007b   ss: 0068
Jan  9 23:00:52 safari kernel: Process screen (pid: 12991, threadinfo=cbe6a000 task=c3434040)
Jan  9 23:00:52 safari kernel: Stack: 000000a9 000000c8 00000177 c85a2f18 cfc9e490 c13148ec c13148f4 00000282 
Jan  9 23:00:52 safari kernel:        000000d0 c13148e0 cbe6bcfc c01444d8 c13148e0 000000d0 ce1bfa00 c01ac080 
Jan  9 23:00:52 safari kernel:        cbe6bd68 cbe6bd0c c01ac09c c13148e0 000000d0 cbe6bd28 c0171d1e ce1bfa00 
Jan  9 23:00:52 safari kernel: Call Trace:
Jan  9 23:00:52 safari kernel:  [<c0103edf>] show_stack+0x7f/0xa0
Jan  9 23:00:52 safari kernel:  [<c0104076>] show_registers+0x156/0x1d0
Jan  9 23:00:52 safari kernel:  [<c0104278>] die+0xc8/0x150
Jan  9 23:00:52 safari kernel:  [<c0115b12>] do_page_fault+0x4a2/0x6d9
Jan  9 23:00:52 safari kernel:  [<c0103b7f>] error_code+0x2b/0x30
Jan  9 23:00:52 safari kernel:  [<c01444d8>] kmem_cache_alloc+0x68/0x70
Jan  9 23:00:52 safari kernel:  [<c01ac09c>] reiserfs_alloc_inode+0x1c/0x30
Jan  9 23:00:52 safari kernel:  [<c0171d1e>] alloc_inode+0x1e/0x1a0
Jan  9 23:00:52 safari kernel:  [<c017285d>] get_new_inode+0x1d/0x120
Jan  9 23:00:52 safari kernel:  [<c01a1385>] reiserfs_iget+0x45/0xc0
Jan  9 23:00:52 safari kernel:  [<c019bafc>] reiserfs_lookup+0xec/0x160
Jan  9 23:00:52 safari kernel:  [<c016624c>] real_lookup+0xcc/0xf0
Jan  9 23:00:52 safari kernel:  [<c01664bc>] do_lookup+0x8c/0xa0
Jan  9 23:00:52 safari kernel:  [<c0166b8d>] link_path_walk+0x6bd/0xcf0
Jan  9 23:00:52 safari kernel:  [<c0167418>] path_lookup+0x78/0x170
Jan  9 23:00:52 safari kernel:  [<c0167cfe>] open_namei+0x8e/0x680
Jan  9 23:00:52 safari kernel:  [<c015829a>] filp_open+0x3a/0x60
Jan  9 23:00:52 safari kernel:  [<c0158636>] sys_open+0x46/0xa0
Jan  9 23:00:52 safari kernel:  [<c0103123>] syscall_call+0x7/0xb
Jan  9 23:00:52 safari kernel: Code: ff 03 8b 51 10 0f b7 41 14 42 89 51 10 8b 7d e4 0f b7 04 47 66 89 41 14 8b 45 08 3b 50 3c 73 06 4e 83 fe ff 75 c2 8b 51 04 8b 01 <89> 50 04 89 02 66 83 79 14 ff c7 01 00 01 10 00 c7 41 04 00 02 

dozens of similar traces not included here...

-- 

