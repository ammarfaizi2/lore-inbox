Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264857AbUGMLGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264857AbUGMLGU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 07:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264890AbUGMLGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 07:06:20 -0400
Received: from adonis.kotinet.com ([212.50.211.55]:2483 "EHLO
	adonis.kotinet.com") by vger.kernel.org with ESMTP id S264857AbUGMLFD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 07:05:03 -0400
Date: Tue, 13 Jul 2004 14:04:37 +0300
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.7-bk20 / slab: Internal list corruption detected in cache 'proc_inode_cache'
Message-ID: <20040713110437.GA4571@m.safari.iki.fi>
Mail-Followup-To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi.

my 2.4 --> 2.6 upgrade has been a rough ride...  at max two days uptime
with 2.6.7+ kernels.  but finally I got Oops logged.

Jul 13 12:17:44 safari kernel: slab: Internal list corruption detected in cache 'proc_inode_cache'(10), slabp c06b60e0(335546376). Hexdump:
Jul 13 12:17:44 safari kernel: 
Jul 13 12:17:44 safari kernel: 000: a0 f0 2d cc e8 43 fd cf f8 03 00 18 08 2c 96 00
Jul 13 12:17:44 safari kernel: 010: 08 08 00 14 00 30 96 00
Jul 13 12:17:44 safari kernel: ------------[ cut here ]------------
Jul 13 12:17:44 safari kernel: kernel BUG at mm/slab.c:1882!
Jul 13 12:17:44 safari kernel: invalid operand: 0000 [#1]
Jul 13 12:17:44 safari kernel: PREEMPT SMP 
Jul 13 12:17:44 safari kernel: Modules linked in: nls_utf8 ip6t_LOG
  ip6table_filter ip6_tables iptable_raw iptable_mangle iptable_filter sch_hfsc
  sch_htb sch_sfq cls_fw cls_u32 cls_route sch_ingress sch_red sch_tbf sch_teql
  sch_prio sch_gred cls_rsvp cls_rsvp6 cls_tcindex sch_cbq sch_dsmark ipt_ttl
  ipt_tos ipt_tcpmss ipt_state ipt_recent ipt_pkttype ipt_physdev ipt_owner
  ipt_multiport ipt_mark ipt_mac ipt_limit ipt_length ipt_iprange ipt_helper
  ipt_esp ipt_ecn ipt_dscp ipt_conntrack ipt_connlimit ipt_ah ipt_addrtype
  ipt_ULOG ipt_TOS ipt_TCPMSS ipt_TARPIT ipt_SAME ipt_REJECT ipt_REDIRECT
  ipt_NOTRACK ipt_NETMAP ipt_MASQUERADE iptable_nat ip_conntrack ipt_MARK
  ipt_LOG ipt_ECN ipt_DSCP ipt_CLASSIFY ip_tables xfs appletalk ax25 ipx p8022
  psnap llc md5 ipv6 bsd_comp ppp_async ppp_deflate zlib_deflate ppp_generic
  slhc snd_seq_midi snd_seq_oss snd_seq_midi_event snd_seq lp parport_pc parport
  mga w83781d i2c_sensor i2c_piix4 tuner tvaudio msp3400 bttv video_buf
  i2c_algo_bit v4l2_common btcx_risc i2c_core videodev
Jul 13 12:17:44 safari kernel: snd_pc_oss snd_mixer_oss snd_ens1371 snd_rawmidi
  snd_seq_device snd_pcm snd_page_alloc snd_timer snd_ac97_codec snd gameport
  soundcore uhci_hcd ohci_hcd irlan irda crc16 8139too mii loop dm_mod
Jul 13 12:17:44 safari kernel: CPU:    0
Jul 13 12:17:44 safari kernel: EIP:    0060:[<c0155e63>]    Not tainted
Jul 13 12:17:44 safari kernel: EFLAGS: 00010082   (2.6.7-bk20) 
Jul 13 12:17:44 safari kernel: EIP is at check_slabp+0xc3/0xf0
Jul 13 12:17:44 safari kernel: eax: 00000001   ebx: 00000018   ecx: c0427558   edx: 00000000
Jul 13 12:17:44 safari kernel: esi: c06b60e0   edi: cffd43c0   ebp: c943cdc0   esp: c943cda0
Jul 13 12:17:44 safari kernel: ds: 007b   es: 007b   ss: 0068
Jul 13 12:17:44 safari kernel: Process ps (pid: 16411, threadinfo=c943c000 task=cec4e7d0)
Jul 13 12:17:44 safari kernel: Stack: c03f269b 00000000 0000000a c06b60e0 14000808 cffd43c0 c06b60e0 00000004 
Jul 13 12:17:44 safari kernel:        c943cdf0 c0155f46 c0aa50d8 00000001 cffc104c cffd43e8 cffd4420 cffc103c 
Jul 13 12:17:44 safari kernel:        000000d0 cffd43c0 000000d0 00000246 c943ce08 c015669f c015466b c042c8b0 
Jul 13 12:17:44 safari kernel: Call Trace:
Jul 13 12:17:44 safari kernel:  [<c010781a>] show_stack+0x7a/0x90
Jul 13 12:17:44 safari kernel:  [<c01079a7>] show_registers+0x157/0x1c0
Jul 13 12:17:44 safari kernel:  [<c0107b76>] die+0xb6/0x190
Jul 13 12:17:44 safari kernel:  [<c0107f46>] do_invalid_op+0x86/0xa0
Jul 13 12:17:44 safari kernel:  [<c01074c1>] error_code+0x2d/0x38
Jul 13 12:17:44 safari kernel:  [<c0155f46>] cache_alloc_refill+0xb6/0x310
Jul 13 12:17:44 safari kernel:  [<c015669f>] kmem_cache_alloc+0x8f/0xa0
Jul 13 12:17:44 safari kernel:  [<c01a9863>] proc_alloc_inode+0x13/0x60
Jul 13 12:17:44 safari kernel:  [<c018d40c>] alloc_inode+0x1c/0x190
Jul 13 12:17:44 safari kernel:  [<c018e043>] new_inode+0x13/0xc0
Jul 13 12:17:44 safari kernel:  [<c01ab902>] proc_pid_make_inode+0x12/0xe0
Jul 13 12:17:44 safari kernel:  [<c01ac312>] proc_pident_lookup+0xb2/0x2a0
Jul 13 12:17:44 safari kernel:  [<c017f91e>] real_lookup+0xce/0x100
Jul 13 12:17:44 safari kernel:  [<c017fc25>] do_lookup+0x75/0x80
Jul 13 12:17:44 safari kernel:  [<c0180145>] link_path_walk+0x515/0x7b0
Jul 13 12:17:44 safari kernel:  [<c0180a60>] path_lookup+0xc0/0x230
Jul 13 12:17:44 safari kernel:  [<c0181389>] open_namei+0x89/0x490
Jul 13 12:17:44 safari kernel:  [<c016ec59>] filp_open+0x29/0x50
Jul 13 12:17:44 safari kernel:  [<c016f1ad>] sys_open+0x4d/0xb0
Jul 13 12:17:44 safari kernel:  [<c0106a13>] syscall_call+0x7/0xb
Jul 13 12:17:44 safari kernel: Code: 0f 0b 5a 07 c5 ab 3d c0 83 c4 14 5b 5e 5f 5d c3 8b 4e 10 e9 
Jul 13 12:17:44 safari kernel:  <6>note: ps[16411] exited with preempt_count 1
Jul 13 12:17:44 safari kernel: Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
Jul 13 12:17:44 safari kernel: in_atomic():1, irqs_disabled():0
Jul 13 12:17:44 safari kernel:  [<c0107847>] dump_stack+0x17/0x20
Jul 13 12:17:44 safari kernel:  [<c0125711>] __might_sleep+0xd1/0x1b0
Jul 13 12:17:44 safari kernel:  [<c012b7ff>] do_exit+0xaf/0x5f0
Jul 13 12:17:44 safari kernel:  [<c0107c43>] die+0x183/0x190
Jul 13 12:17:44 safari kernel:  [<c0107f46>] do_invalid_op+0x86/0xa0
Jul 13 12:17:44 safari kernel:  [<c01074c1>] error_code+0x2d/0x38
Jul 13 12:17:44 safari kernel:  [<c0155f46>] cache_alloc_refill+0xb6/0x310
Jul 13 12:17:44 safari kernel:  [<c015669f>] kmem_cache_alloc+0x8f/0xa0
Jul 13 12:17:44 safari kernel:  [<c01a9863>] proc_alloc_inode+0x13/0x60
Jul 13 12:17:44 safari kernel:  [<c018d40c>] alloc_inode+0x1c/0x190
Jul 13 12:17:44 safari kernel:  [<c018e043>] new_inode+0x13/0xc0
Jul 13 12:17:44 safari kernel:  [<c01ab902>] proc_pid_make_inode+0x12/0xe0
Jul 13 12:17:44 safari kernel:  [<c01ac312>] proc_pident_lookup+0xb2/0x2a0
Jul 13 12:17:44 safari kernel:  [<c017f91e>] real_lookup+0xce/0x100
Jul 13 12:17:44 safari kernel:  [<c017fc25>] do_lookup+0x75/0x80
Jul 13 12:17:44 safari kernel:  [<c0180145>] link_path_walk+0x515/0x7b0
Jul 13 12:17:44 safari kernel:  [<c0180a60>] path_lookup+0xc0/0x230
Jul 13 12:17:44 safari kernel:  [<c0181389>] open_namei+0x89/0x490
Jul 13 12:17:44 safari kernel:  [<c016ec59>] filp_open+0x29/0x50
Jul 13 12:17:44 safari kernel:  [<c016f1ad>] sys_open+0x4d/0xb0
Jul 13 12:17:44 safari kernel:  [<c0106a13>] syscall_call+0x7/0xb
Jul 13 12:17:44 safari kernel: bad: scheduling while atomic!
Jul 13 12:17:44 safari kernel:  [<c0107847>] dump_stack+0x17/0x20
Jul 13 12:17:44 safari kernel:  [<c03bec16>] schedule+0x8b6/0x900
Jul 13 12:17:44 safari kernel:  [<c015d424>] unmap_vmas+0x244/0x280
Jul 13 12:17:44 safari kernel:  [<c01620df>] exit_mmap+0x9f/0x1d0
Jul 13 12:17:44 safari kernel:  [<c0126197>] mmput+0x77/0xb0
Jul 13 12:17:44 safari kernel:  [<c012b8bc>] do_exit+0x16c/0x5f0
Jul 13 12:17:44 safari kernel:  [<c0107c43>] die+0x183/0x190
Jul 13 12:17:44 safari kernel:  [<c0107f46>] do_invalid_op+0x86/0xa0
Jul 13 12:17:44 safari kernel:  [<c01074c1>] error_code+0x2d/0x38
Jul 13 12:17:44 safari kernel:  [<c0155f46>] cache_alloc_refill+0xb6/0x310
Jul 13 12:17:44 safari kernel:  [<c015669f>] kmem_cache_alloc+0x8f/0xa0
Jul 13 12:17:44 safari kernel:  [<c01a9863>] proc_alloc_inode+0x13/0x60
Jul 13 12:17:44 safari kernel:  [<c018d40c>] alloc_inode+0x1c/0x190
Jul 13 12:17:44 safari kernel:  [<c018e043>] new_inode+0x13/0xc0
Jul 13 12:17:44 safari kernel:  [<c01ab902>] proc_pid_make_inode+0x12/0xe0
Jul 13 12:17:44 safari kernel:  [<c01ac312>] proc_pident_lookup+0xb2/0x2a0
Jul 13 12:17:44 safari kernel:  [<c017f91e>] real_lookup+0xce/0x100
Jul 13 12:17:44 safari kernel:  [<c017fc25>] do_lookup+0x75/0x80
Jul 13 12:17:44 safari kernel:  [<c0180145>] link_path_walk+0x515/0x7b0
Jul 13 12:17:44 safari kernel:  [<c0180a60>] path_lookup+0xc0/0x230
Jul 13 12:17:44 safari kernel:  [<c0181389>] open_namei+0x89/0x490
Jul 13 12:17:44 safari kernel:  [<c016ec59>] filp_open+0x29/0x50
Jul 13 12:17:44 safari kernel:  [<c016f1ad>] sys_open+0x4d/0xb0
Jul 13 12:17:44 safari kernel:  [<c0106a13>] syscall_call+0x7/0xb
Jul 13 12:21:04 safari kernel: klogd 1.4.1, log source = /proc/kmsg started.


funny thing about that 335546376 is that when I used 2.6.7-bk18,
I was copying /proc/slabinfo every 15 seconds to a safe place...
when I got a crash, latest slabinfo (just prior to the crash) contained these:
radix_tree_node   335549427   5614    276   14    1 : tunables   54   27    0 : slabdata    401    401      0
proc_inode_cache    2195   2208    320   12    1 : tunables   54   27    0 : slabdata    184    184      0
kernel message little time before crash was
Jul  7 12:07:25 safari kernel: slab: cache radix_tree_node error: free_objects accounting error

335549427 is 0x140013f3 , hmm, where did the "extra" 0x14000000 come from in
these two cases...

I don't know is proc related to this bug, since sometimes the kernel crashes
when I start e.g. mozilla or some other program which does not even read
files at /proc.


in 2.6.7-bk20 I have these patches applied
redhat fedora kernel-2.6.7-1.469.src.rpm
  linux-2.4.0-nonintconfig.patch
  linux-2.4.0-test11-vidfail.patch
  linux-2.6.0-compile.patch
  linux-2.6.0-devmem.patch
  linux-2.6.0-exec-shield.patch
  linux-2.6.0-sleepon.patch
  linux-2.6.4-stackusage.patch
  linux-2.6.7-i8x0-drm.patch 
  linux-2.6.7-mlock.patch
  linux-2.6.7-rpclookup-oops.patch 

patch-o-matic-ng-20040605
  * TARPIT
  * connlimit
    realm
    CLASSIFY
    IPMARK
    NETMAP
    TTL
    nth
    owner-socketlookup
    CONNMARK

(* = in use)

perfctr-2.6.8, patch-2.6.7

Linux safari.finland.fbi 2.6.7-bk20 #5 SMP Sun Jul 11 02:06:44 EEST 2004 i686 i686 i386 GNU/Linux
 
Gnu C                  3.4.1
Gnu make               3.80
binutils               2.15.90.0.3
util-linux             2.12
mount                  2.12
module-init-tools      3.0-pre10
e2fsprogs              1.35
jfsutils               1.0.24
xfsprogs               2.3.9
pcmcia-cs              3.2.7
quota-tools            3.11.
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Procps                 3.2.1
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         ip6t_LOG ip6table_filter ip6_tables iptable_raw
  iptable_mangle iptable_filter sch_hfsc sch_htb sch_sfq cls_fw cls_u32 cls_route
  sch_ingress sch_red sch_tbf sch_teql sch_prio sch_gred cls_rsvp cls_rsvp6
  cls_tcindex sch_cbq sch_dsmark ipt_ttl ipt_tos ipt_tcpmss ipt_state ipt_recent
  ipt_pkttype ipt_physdev ipt_owner ipt_multiport ipt_mark ipt_mac ipt_limit
  ipt_length ipt_iprange ipt_helper ipt_esp ipt_ecn ipt_dscp ipt_conntrack
  ipt_connlimit ipt_ah ipt_addrtype ipt_ULOG ipt_TOS ipt_TCPMSS ipt_TARPIT
  ipt_SAME ipt_REJECT ipt_REDIRECT ipt_NOTRACK ipt_NETMAP ipt_MASQUERADE
  iptable_nat ip_conntrack ipt_MARK ipt_LOG ipt_ECN ipt_DSCP ipt_CLASSIFY
  ip_tables xfs appletalk ax25 ipx p8022 psnap llc md5 ipv6 bsd_comp ppp_async
  ppp_deflate zlib_deflate ppp_generic slhc snd_seq_midi snd_seq_oss
  snd_seq_midi_event snd_seq lp parport_pc parport w83781d mga i2c_sensor
  i2c_piix4 tuner tvaudio msp3400 bttv video_buf i2c_algo_bit v4l2_common
  btcx_risc i2c_core videodev snd_pcm_oss snd_mixer_oss snd_ens1371 snd_rawmidi
  snd_seq_device snd_pcm snd_page_alloc snd_timer snd_ac97_codec snd gameport
  soundcore uhci_hcd ohci_hcd irlan irda crc16 8139too mii loop dm_mod


/proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 0
cpu MHz         : 367.639
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat pse36 mmx fxsr
bogomips        : 722.94

(microcode updated to revision 0xa (latest one))

.config is basically (!) the same as in fedora and  I don't know is
it relevant to this bug report
http://safari.iki.fi/config-2.6.7-bk20.txt
(it that's not reachable, it's because I'm crashing&rebooting)

-- 

