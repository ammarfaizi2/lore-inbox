Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266181AbUJLMaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266181AbUJLMaN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 08:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266186AbUJLMaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 08:30:13 -0400
Received: from dsl-kpogw5jd0.dial.inet.fi ([80.223.105.208]:1768 "EHLO
	safari.iki.fi") by vger.kernel.org with ESMTP id S266181AbUJLM3w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 08:29:52 -0400
Date: Tue, 12 Oct 2004 15:29:50 +0300
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.9-rc4 Oops in s_show / prune_dcache
Message-ID: <20041012122950.GA24892@m.safari.iki.fi>
Mail-Followup-To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i386 UP, gcc-2.95.3 -- I ran ss and it blew up.
This is what the kernel had to say.

Unable to handle kernel paging request at virtual address 14000008
 printing eip:
c013e798
*pde = 00000000
Oops: 0000 [#1]
Modules linked in: ip6t_LOG ip6table_filter sch_hfsc cls_fw cls_route
	sch_ingress sch_red sch_tbf sch_teql sch_prio sch_gred cls_rsvp cls_tcindex
	cls_rsvp6 sch_cbq sch_dsmark ipt_ttl ipt_tos ipt_tcpmss ipt_sctp ipt_pkttype
	ipt_recent ipt_physdev ipt_nth ipt_mark ipt_mac ipt_iprange ipt_helper ipt_esp
	ipt_ecn ipt_dscp ipt_conntrack ipt_ah ipt_addrtype ipt_ULOG ipt_TTL ipt_TOS
	ipt_TCPMSS ipt_SAME ipt_REDIRECT ipt_NOTRACK ipt_NETMAP ipt_MASQUERADE ipt_MARK
	ipt_IPMARK ipt_DSCP ipt_CLASSIFY xfs ipv6 loop snd_seq_midi snd_seq_oss
	snd_seq_midi_event snd_seq parport_pc lp parport mga w83781d i2c_sensor
	i2c_piix4 tuner tvaudio msp3400 bttv video_buf i2c_algo_bit v4l2_common
	btcx_risc i2c_core videodev ohci_hcd dm_mod ipt_length ipt_connlimit ipt_TARPIT
	ipt_ECN ipt_state ipt_multiport ipt_owner uhci_hcd cls_u32 sch_sfq sch_htb
	snd_pcm_oss ipt_REJECT ipt_LOG ipt_limit iptable_raw iptable_mangle iptable_nat
	ip_conntrack ip6_tables snd_ens1371 iptable_filter ip_tables snd_mixer_oss
	snd_rawmidi snd_seq_device snd_pcm snd_timer snd_page_alloc snd_ac97_codec snd
	soundcore gameport irlan irda crc_ccitt 8139too mii floppy
CPU:    0
EIP:    0060:[<c013e798>]    Not tainted VLI
EFLAGS: 00210006   (2.6.9-rc4) 
EIP is at s_show+0x54/0x1b4
eax: c0368f15   ebx: c0368f15   ecx: 14000008   edx: 0000000a
esi: c132c860   edi: c132c874   ebp: ce5d8f2c   esp: ce5d8f00
ds: 007b   es: 007b   ss: 0068
Process ss (pid: 20558, threadinfo=ce5d8000 task=c3787450)
Stack: c053da20 c132c860 00000000 c037f356 00000000 c132c7fc c132c7fc 00000008 
       00000000 000008b2 000056f4 ce5d8f6c c0169dba c053da20 c132c860 00000000 
       cf4fea60 ce5d8fb0 c053da38 ce5d8f64 000002ed c053da38 0000000e 00000035 
Call Trace:
 [<c0106c47>] show_stack+0x7b/0x88
 [<c0106d7e>] show_registers+0x10a/0x17c
 [<c0106f33>] die+0xbf/0x138
 [<c0116f53>] do_page_fault+0x40b/0x578
 [<c01068cd>] error_code+0x2d/0x38
 [<c0169dba>] seq_read+0x18a/0x27c
 [<c014f687>] vfs_read+0xbb/0xf4
 [<c014f8ac>] sys_read+0x3c/0x68
 [<c0105e7f>] syscall_call+0x7/0xb
Code: 8d 74 26 00 8d 46 14 39 c1 74 2a 8b 56 3c 89 c7 8d 76 00 b8 15 8f 36 c0 85 db 0f 45 c3 39 51 10 0f 45 d8 01 55 fc ff 45 f8 8b 09 <8b> 01 8d 74 26 00 39 f9 75 de 8b 4e 0c 8b 01 8d 74 26 00 8b 56 

sysrq-t

ss            D C05056A8     0 14538  20724               19489 (NOTLB)
ce5d8ed8 00200082 00200246 c05056a8 ce5d8efc ce5d8f3c c3787450 00000000 
       ca032060 00001239 8e97ca15 000027d8 cf5ba340 c3787450 c37875b0 ce5d8f04 
       c0350f7e 00000000 00000000 c053da20 c3787450 00000001 c3787450 c011b6ec 
Call Trace:
 [<c0350f7e>] Letext+0x6e/0xcc
 [<c03510d3>] __down_failed+0xb/0x14
 [<c013eb4d>] .text.lock.slab+0x7d/0xa0
 [<c0169d83>] seq_read+0x153/0x27c
 [<c014f687>] vfs_read+0xbb/0xf4
 [<c014f8ac>] sys_read+0x3c/0x68
 [<c0105e7f>] syscall_call+0x7/0xb

short time after this I started command "mutt linux-kernel", but it
segfaulted and I got these:

Unable to handle kernel paging request at virtual address 1400000c
 printing eip:
c0164070
*pde = 00000000
Oops: 0000 [#4]
Modules linked in: x 
CPU:    0
EIP:    0060:[<c0164070>]    Not tainted VLI
EFLAGS: 00210217   (2.6.9-rc4) 
EIP is at prune_dcache+0x10/0x160
eax: 00000000   ebx: 00000082   ecx: 14000008   edx: cec9da00
esi: 00000000   edi: 00000080   ebp: c0590d84   esp: c0590d78
ds: 007b   es: 007b   ss: 0068
Process mutt (pid: 14156, threadinfo=c0590000 task=c061afb0)
Stack: 00000082 00000000 c127ea40 c0590d90 c01644cd 00000080 c0590dc0 c013f9f2 
       00000080 000000d2 00000009 c04082c4 c0590e68 000ca580 00000000 0000c3c0 
       00000010 00000000 c0590e1c c01408d6 00000020 000000d2 0000c3bf c04082c4 
Call Trace:
 [<c0106c47>] show_stack+0x7b/0x88
 [<c0106d7e>] show_registers+0x10a/0x17c
 [<c0106f33>] die+0xbf/0x138
 [<c0116f53>] do_page_fault+0x40b/0x578
 [<c01068cd>] error_code+0x2d/0x38
 [<c01644cd>] shrink_dcache_memory+0x1d/0x44
 [<c013f9f2>] shrink_slab+0x122/0x168
 [<c01408d6>] try_to_free_pages+0xb2/0x15c
 [<c013a392>] __alloc_pages+0x1ee/0x308
 [<c014318b>] do_anonymous_page+0x4b/0x100
 [<c014328d>] do_no_page+0x4d/0x210
 [<c0143577>] handle_mm_fault+0x7b/0x114
 [<c0116d15>] do_page_fault+0x1cd/0x578
 [<c01068cd>] error_code+0x2d/0x38
Code: 56 e8 dd fc ff ff 83 c4 04 eb 9c 8b 09 39 f9 75 9c 8d 65 f4 5b 5e 5f 89 ec 5d c3 55 89 e5 57 56 53 8b 7d 08 e9 13 01 00 00 89 f6 <8b> 51 04 8b 01 89 50 04 89 02 89 09 89 49 04 a1 70 94 40 c0 8d 

...

Unable to handle kernel paging request at virtual address 1400000c
 printing eip:
c0164070
*pde = 00000000
Oops: 0000 [#5]
Modules linked in: x 
CPU:    0
EIP:    0060:[<c0164070>]    Not tainted VLI
EFLAGS: 00210217   (2.6.9-rc4) 
EIP is at prune_dcache+0x10/0x160
eax: 00000000   ebx: 00000080   ecx: 14000008   edx: cbfe7000
esi: 00000000   edi: 00000080   ebp: cbfe7ddc   esp: cbfe7dd0
ds: 007b   es: 007b   ss: 0068
Process silc (pid: 23126, threadinfo=cbfe7000 task=c570c5b0)
Stack: 00000080 00000000 c127ea40 cbfe7de8 c01644cd 00000080 cbfe7e18 c013f9f2 
       00000080 000000d0 00000008 c04082a4 cbfe7ec0 000ca580 00000000 0000c3c7 
       00000010 00000000 cbfe7e74 c01408d6 00000020 000000d0 0000c3c6 c04082a4 
Call Trace:
 [<c0106c47>] show_stack+0x7b/0x88
 [<c0106d7e>] show_registers+0x10a/0x17c
 [<c0106f33>] die+0xbf/0x138
 [<c0116f53>] do_page_fault+0x40b/0x578
 [<c01068cd>] error_code+0x2d/0x38
 [<c01644cd>] shrink_dcache_memory+0x1d/0x44
 [<c013f9f2>] shrink_slab+0x122/0x168
 [<c01408d6>] try_to_free_pages+0xb2/0x15c
 [<c013a392>] __alloc_pages+0x1ee/0x308
 [<c013a4cc>] __get_free_pages+0x20/0x40
 [<c015ff87>] __pollwait+0x2f/0x9c
 [<c0271ba2>] normal_poll+0x26/0x13a
 [<c026de7c>] tty_poll+0x98/0xb4
 [<c0160924>] do_pollfd+0x50/0x94
 [<c01609bf>] do_poll+0x57/0xb8
 [<c0160b2a>] sys_poll+0x10a/0x1af
 [<c0105e7f>] syscall_call+0x7/0xb
Code: 56 e8 dd fc ff ff 83 c4 04 eb 9c 8b 09 39 f9 75 9c 8d 65 f4 5b 5e 5f 89 ec 5d c3 55 89 e5 57 56 53 8b 7d 08 e9 13 01 00 00 89 f6 <8b> 51 04 8b 01 89 50 04 89 02 89 09 89 49 04 a1 70 94 40 c0 8d 



http://safari.iki.fi/config-2.6.9-rc4-20041011-1.txt
I have also exec-shield from fedora (which does not work -- mappings do not 
work and paxtest fails for all) and voluntary-preemption from fedora
(kernel-2.6.8-1.603), plus perfctr-2.7.5.1 patch-kernel-2.6.9-rc2 and
some netfilter patch-o-matic-ng modules.

if someone knows what must be done to make exec-shield work, please tell.
is the 4g4g patch also needed?

(gdb) disass prune_dcache
Dump of assembler code for function prune_dcache:
0xc0164060 <prune_dcache+0>:    push   %ebp
0xc0164061 <prune_dcache+1>:    mov    %esp,%ebp
0xc0164063 <prune_dcache+3>:    push   %edi
0xc0164064 <prune_dcache+4>:    push   %esi
0xc0164065 <prune_dcache+5>:    push   %ebx
0xc0164066 <prune_dcache+6>:    mov    0x8(%ebp),%edi
0xc0164069 <prune_dcache+9>:    jmp    0xc0164181 <prune_dcache+289>
0xc016406e <prune_dcache+14>:   mov    %esi,%esi
0xc0164070 <prune_dcache+16>:   mov    0x4(%ecx),%edx        *** SPLASH!!! ***
0xc0164073 <prune_dcache+19>:   mov    (%ecx),%eax
0xc0164075 <prune_dcache+21>:   mov    %edx,0x4(%eax)
0xc0164078 <prune_dcache+24>:   mov    %eax,(%edx)
0xc016407a <prune_dcache+26>:   mov    %ecx,(%ecx)
0xc016407c <prune_dcache+28>:   mov    %ecx,0x4(%ecx)
0xc016407f <prune_dcache+31>:   mov    0xc0409470,%eax
0xc0164084 <prune_dcache+36>:   lea    0x0(%esi),%esi
0xc0164088 <prune_dcache+40>:   decl   0xc0409478
0xc016408e <prune_dcache+46>:   lea    0xffffffdc(%ecx),%ebx
0xc0164091 <prune_dcache+49>:   mov    0xffffffdc(%ecx),%eax
0xc0164094 <prune_dcache+52>:   test   %eax,%eax
0xc0164096 <prune_dcache+54>:   jne    0xc0164180 <prune_dcache+288>
0xc016409c <prune_dcache+60>:   mov    0xffffffe0(%ecx),%eax
0xc016409f <prune_dcache+63>:   test   $0x8,%al
0xc01640a1 <prune_dcache+65>:   je     0xc01640d0 <prune_dcache+112>
0xc01640a3 <prune_dcache+67>:   and    $0xf7,%al
0xc01640a5 <prune_dcache+69>:   mov    %eax,0xffffffe0(%ecx)
0xc01640a8 <prune_dcache+72>:   mov    0xc040946c,%eax
0xc01640ad <prune_dcache+77>:   mov    %ecx,0x4(%eax)
0xc01640b0 <prune_dcache+80>:   mov    %eax,0x24(%ebx)
0xc01640b3 <prune_dcache+83>:   movl   $0xc040946c,0x4(%ecx)
0xc01640ba <prune_dcache+90>:   mov    %ecx,0xc040946c
0xc01640c0 <prune_dcache+96>:   incl   0xc0409478
0xc01640c6 <prune_dcache+102>:  jmp    0xc0164180 <prune_dcache+288>
0xc01640cb <prune_dcache+107>:  nop    
0xc01640cc <prune_dcache+108>:  lea    0x0(%esi),%esi
0xc01640d0 <prune_dcache+112>:  test   $0x10,%al
0xc01640d2 <prune_dcache+114>:  jne    0xc01640f2 <prune_dcache+146>
0xc01640d4 <prune_dcache+116>:  or     $0x10,%al
0xc01640d6 <prune_dcache+118>:  mov    %eax,0xffffffe0(%ecx)
0xc01640d9 <prune_dcache+121>:  mov    0x64(%ebx),%edx
0xc01640dc <prune_dcache+124>:  lea    0x40(%ecx),%eax
0xc01640df <prune_dcache+127>:  mov    0x4(%eax),%ecx
0xc01640e2 <prune_dcache+130>:  mov    %edx,(%ecx)
0xc01640e4 <prune_dcache+132>:  test   %edx,%edx
0xc01640e6 <prune_dcache+134>:  je     0xc01640eb <prune_dcache+139>
0xc01640e8 <prune_dcache+136>:  mov    %ecx,0x4(%edx)
0xc01640eb <prune_dcache+139>:  movl   $0x200200,0x4(%eax)
0xc01640f2 <prune_dcache+146>:  lea    0x2c(%ebx),%ecx
0xc01640f5 <prune_dcache+149>:  mov    0x4(%ecx),%edx
0xc01640f8 <prune_dcache+152>:  mov    0x2c(%ebx),%eax
0xc01640fb <prune_dcache+155>:  mov    %edx,0x4(%eax)
0xc01640fe <prune_dcache+158>:  mov    %eax,(%edx)
0xc0164100 <prune_dcache+160>:  movl   $0x100100,0x2c(%ebx)
0xc0164107 <prune_dcache+167>:  movl   $0x200200,0x4(%ecx)
0xc016410e <prune_dcache+174>:  decl   0xc0409474
0xc0164114 <prune_dcache+180>:  mov    0xc(%ebx),%esi
0xc0164117 <prune_dcache+183>:  test   %esi,%esi
0xc0164119 <prune_dcache+185>:  je     0xc0164160 <prune_dcache+256>
0xc016411b <prune_dcache+187>:  movl   $0x0,0xc(%ebx)
0xc0164122 <prune_dcache+194>:  lea    0x3c(%ebx),%eax
0xc0164125 <prune_dcache+197>:  mov    0x4(%eax),%ecx
0xc0164128 <prune_dcache+200>:  mov    0x3c(%ebx),%edx
0xc016412b <prune_dcache+203>:  mov    %ecx,0x4(%edx)
0xc016412e <prune_dcache+206>:  mov    %edx,(%ecx)
0xc0164130 <prune_dcache+208>:  mov    %eax,0x3c(%ebx)
0xc0164133 <prune_dcache+211>:  mov    %eax,0x4(%eax)
0xc0164136 <prune_dcache+214>:  mov    0x48(%ebx),%eax
0xc0164139 <prune_dcache+217>:  test   %eax,%eax
0xc016413b <prune_dcache+219>:  je     0xc0164150 <prune_dcache+240>
0xc016413d <prune_dcache+221>:  mov    0x14(%eax),%eax
0xc0164140 <prune_dcache+224>:  test   %eax,%eax
0xc0164142 <prune_dcache+226>:  je     0xc0164150 <prune_dcache+240>
0xc0164144 <prune_dcache+228>:  push   %esi
0xc0164145 <prune_dcache+229>:  push   %ebx
0xc0164146 <prune_dcache+230>:  call   *%eax
0xc0164148 <prune_dcache+232>:  add    $0x8,%esp
0xc016414b <prune_dcache+235>:  jmp    0xc0164160 <prune_dcache+256>
0xc016414d <prune_dcache+237>:  lea    0x0(%esi),%esi
0xc0164150 <prune_dcache+240>:  push   %esi
0xc0164151 <prune_dcache+241>:  call   0xc01663bc <iput>
0xc0164156 <prune_dcache+246>:  add    $0x4,%esp
0xc0164159 <prune_dcache+249>:  lea    0x0(%esi),%esi
0xc0164160 <prune_dcache+256>:  mov    0x10(%ebx),%esi
0xc0164163 <prune_dcache+259>:  push   %ebx
0xc0164164 <prune_dcache+260>:  call   0xc0163ce0 <d_free>
0xc0164169 <prune_dcache+265>:  add    $0x4,%esp
0xc016416c <prune_dcache+268>:  cmp    %ebx,%esi
0xc016416e <prune_dcache+270>:  je     0xc0164180 <prune_dcache+288>
0xc0164170 <prune_dcache+272>:  push   %esi
0xc0164171 <prune_dcache+273>:  call   0xc0163d28 <dput>
0xc0164176 <prune_dcache+278>:  add    $0x4,%esp
0xc0164179 <prune_dcache+281>:  lea    0x0(%esi),%esi
0xc0164180 <prune_dcache+288>:  dec    %edi
0xc0164181 <prune_dcache+289>:  test   %edi,%edi
0xc0164183 <prune_dcache+291>:  je     0xc01641b5 <prune_dcache+341>
0xc0164185 <prune_dcache+293>:  push   $0x1
0xc0164187 <prune_dcache+295>:  push   $0x3e5
0xc016418c <prune_dcache+300>:  push   $0xc036cbae
0xc0164191 <prune_dcache+305>:  call   0xc011c234 <__might_sleep>
0xc0164196 <prune_dcache+310>:  push   $0xc0409460
0xc016419b <prune_dcache+315>:  call   0xc0351808 <__cond_resched_lock>
0xc01641a0 <prune_dcache+320>:  mov    0xc0409470,%ecx
0xc01641a6 <prune_dcache+326>:  add    $0x10,%esp
0xc01641a9 <prune_dcache+329>:  cmp    $0xc040946c,%ecx
0xc01641af <prune_dcache+335>:  jne    0xc0164070 <prune_dcache+16>
0xc01641b5 <prune_dcache+341>:  lea    0xfffffff4(%ebp),%esp
0xc01641b8 <prune_dcache+344>:  pop    %ebx
0xc01641b9 <prune_dcache+345>:  pop    %esi
0xc01641ba <prune_dcache+346>:  pop    %edi
0xc01641bb <prune_dcache+347>:  mov    %ebp,%esp
0xc01641bd <prune_dcache+349>:  pop    %ebp
0xc01641be <prune_dcache+350>:  ret    

(gdb) print dentry_unused
$1 = {next = 0xc040946c, prev = 0xc040946c}
(gdb) x 0xc0409470
0xc0409470 <dentry_unused+4>:   0xc040946c

-- 

