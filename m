Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268344AbUIWJ20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268344AbUIWJ20 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 05:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268345AbUIWJ20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 05:28:26 -0400
Received: from dirk.hostexchange.net.au ([203.89.208.131]:24582 "EHLO
	dirk.hostexchange.net.au") by vger.kernel.org with ESMTP
	id S268344AbUIWJ17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 05:27:59 -0400
Message-ID: <1095931675.4152971b97f03@webmail.hostexchange.net.au>
Date: Thu, 23 Sep 2004 19:27:55 +1000
From: James Pell <jpell@smktech.com.au>
To: linux-kernel@vger.kernel.org
Subject: YAOHR: Yet Another Oops Help Request (2.4.24)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Sent-Via: HostExchange Webmail
X-Originating-IP: 203.41.15.168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Got an odd Oops prob and just want some advice as to whether it's a 
kernel/module problem or hardware. I think I've read all the relevant FAQ's and 
done the right things, so hopefully I got this right (apologies if I've missed 
something important):

System:

Athlon 2500XP (Barton core), VIA KT600 chipset, Linux 2.4.24, software RAID1 
(MD). lspci, Oops and ksymoops info follows, run on same machine running the 
same kernel/modules that the problem oops happened on:

----------------------------
$ lspci
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3189 (rev 80)
00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b198
00:08.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+] (rev 44)
00:0d.0 Ethernet controller: 3Com Corporation: Unknown device 9300 (rev 31)
00:10.0 USB Controller: VIA Technologies, Inc. UHCI USB (rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. UHCI USB (rev 80)
00:10.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc.: Unknown device 3104 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3177
00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
----------------------------


----------------------------
Sep 22 03:50:01 hostname kernel:  <1>Unable to handle kernel paging request at 
virtual address 54654a33
Sep 22 03:50:01 hostname kernel: 54654a33
Sep 22 03:50:01 hostname kernel: *pde = 00000000
Sep 22 03:50:01 hostname kernel: Oops: 0000
Sep 22 03:50:01 hostname kernel: CPU:    0
Sep 22 03:50:01 hostname kernel: EIP:    0010:[<54654a33>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Sep 22 03:50:01 hostname kernel: EFLAGS: 00010286
Sep 22 03:50:01 hostname kernel: eax: 54654a33   ebx: d77539c0   ecx: 
df20f148   edx: dcd5eb88
Sep 22 03:50:01 hostname kernel: esi: c58d0000   edi: c58d1f8c   ebp: 
dcd5eb80   esp: c58d1ef8
Sep 22 03:50:01 hostname kernel: ds: 0018   es: 0018   ss: 0018
Sep 22 03:50:01 hostname kernel: Process sendmail (pid: 6276, 
stackpage=c58d1000)
Sep 22 03:50:01 hostname kernel: Stack: c013b28a d77539c0 c58d1f8c dcd5eb80 
c58d1f8c cc7dd000 00000000 00000001
Sep 22 03:50:01 hostname kernel:        00000001 00000001 cc7dd012 d77539c0 
cc7dd005 0000000d dc98062a c013b3fa
Sep 22 03:50:01 hostname kernel:        c013b57b 00000001 cc7dd000 c58d1f8c 
c013b964 00000901 cc7dd000 00000000
Sep 22 03:50:01 hostname kernel: Call Trace:    [<c013b28a>] [<c013b3fa>] 
[<c013b57b>] [<c013b964>] [<c010d22d>]
Sep 22 03:50:01 hostname kernel:   [<c013111b>] [<c0131476>] [<c0108823>]
Sep 22 03:50:01 hostname kernel: Code:  Bad EIP value.


>>EIP; 54654a33 Before first symbol   <=====

>>eax; 54654a33 Before first symbol
>>ebx; d77539c0 <_end+1738e984/20655fc4>
>>ecx; df20f148 <_end+1ee4a10c/20655fc4>
>>edx; dcd5eb88 <_end+1c999b4c/20655fc4>
>>esi; c58d0000 <_end+550afc4/20655fc4>
>>edi; c58d1f8c <_end+550cf50/20655fc4>
>>ebp; dcd5eb80 <_end+1c999b44/20655fc4>
>>esp; c58d1ef8 <_end+550cebc/20655fc4>

Trace; c013b28a <link_path_walk+70a/860>
Trace; c013b3fa <path_walk+1a/20>
Trace; c013b57b <path_lookup+1b/30>
Trace; c013b964 <open_namei+74/570>
Trace; c010d22d <old_mmap+ed/130>
Trace; c013111b <filp_open+3b/60>
Trace; c0131476 <sys_open+36/90>
Trace; c0108823 <system_call+33/38>

---------
Sep 22 20:52:36 hostname kernel:  <1>Unable to handle kernel paging request at 
virtual address e29faf60
Sep 22 20:52:36 hostname kernel: c0142f45
Sep 22 20:52:36 hostname kernel: *pde = 00000000
Sep 22 20:52:36 hostname kernel: Oops: 0002
Sep 22 20:52:36 hostname kernel: CPU:    0
Sep 22 20:52:36 hostname kernel: EIP:    0010:[<c0142f45>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Sep 22 20:52:36 hostname kernel: EFLAGS: 00010246
Sep 22 20:52:36 hostname kernel: eax: de82cc60   ebx: de61aa58   ecx: 
de61aa60   edx: e29faf60
Sep 22 20:52:36 hostname kernel: esi: de61aa40   edi: dd9dc900   ebp: 
00000001   esp: d508be14
Sep 22 20:52:36 hostname kernel: ds: 0018   es: 0018   ss: 0018
Sep 22 20:52:36 hostname kernel: Process imapd (pid: 11387, stackpage=d508b000)
Sep 22 20:52:36 hostname kernel: Stack: 00000000 c111f82c 00000007 ffffffff 
c014329b 00000010 c012ad2a 00000006
Sep 22 20:52:36 hostname kernel:        000001d2 00000020 000001d2 c032401c 
c032401c d508a000 00004094 000001d2
Sep 22 20:52:36 hostname kernel:        c032401c c012af9f d508be88 0000003c 
000001d2 00000020 c012b010 d508be88
Sep 22 20:52:36 hostname kernel: Call Trace:    [<c014329b>] [<c012ad2a>] 
[<c012af9f>] [<c012b010>] [<c012baad>]
Sep 22 20:52:36 hostname kernel:   [<c012bdb2>] [<c0159cc0>] [<c012ba66>] 
[<c012432a>] [<c01249d5>] [<c0124bf2>]
Sep 22 20:52:36 hostname kernel:   [<c0125233>] [<c0125110>] [<c01319c6>] 
[<c0108823>]
Sep 22 20:52:36 hostname kernel: Code: 89 02 c7 46 20 00 00 00 00 c7 41 04 00 
00 00 00 8b 7b f0 85


>>EIP; c0142f45 <prune_dcache+85/150>   <=====

>>eax; de82cc60 <_end+1e467c24/20655fc4>
>>ebx; de61aa58 <_end+1e255a1c/20655fc4>
>>ecx; de61aa60 <_end+1e255a24/20655fc4>
>>edx; e29faf60 <END_OF_CODE+1fd3a01/????>
>>esi; de61aa40 <_end+1e255a04/20655fc4>
>>edi; dd9dc900 <_end+1d6178c4/20655fc4>
>>esp; d508be14 <_end+14cc6dd8/20655fc4>

Trace; c014329b <shrink_dcache_memory+1b/40>
Trace; c012ad2a <shrink_cache+28a/370>
Trace; c012af9f <shrink_caches+2f/40>
Trace; c012b010 <try_to_free_pages_zone+60/f0>
Trace; c012baad <balance_classzone+3d/1c0>
Trace; c012bdb2 <__alloc_pages+182/290>
Trace; c0159cc0 <ext3_get_block+0/70>
Trace; c012ba66 <_alloc_pages+16/20>
Trace; c012432a <page_cache_read+6a/c0>
Trace; c01249d5 <generic_file_readahead+105/140>
Trace; c0124bf2 <do_generic_file_read+1b2/440>
Trace; c0125233 <generic_file_read+93/190>
Trace; c0125110 <file_read_actor+0/90>
Trace; c01319c6 <sys_read+96/f0>
Trace; c0108823 <system_call+33/38>

Code;  c0142f45 <prune_dcache+85/150>
00000000 <_EIP>:
Code;  c0142f45 <prune_dcache+85/150>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c0142f47 <prune_dcache+87/150>
   2:   c7 46 20 00 00 00 00      movl   $0x0,0x20(%esi)
Code;  c0142f4e <prune_dcache+8e/150>
   9:   c7 41 04 00 00 00 00      movl   $0x0,0x4(%ecx)
Code;  c0142f55 <prune_dcache+95/150>
  10:   8b 7b f0                  mov    0xfffffff0(%ebx),%edi
Code;  c0142f58 <prune_dcache+98/150>
  13:   85 00                     test   %eax,(%eax)

---------
Sep 22 20:52:35 hostname kernel: Unable to handle kernel paging request at 
virtual address e29faf60
Sep 22 20:52:35 hostname kernel: c0142f45
Sep 22 20:52:35 hostname kernel: *pde = 00000000
Sep 22 20:52:35 hostname kernel: Oops: 0002
Sep 22 20:52:35 hostname kernel: CPU:    0
Sep 22 20:52:35 hostname kernel: EIP:    0010:[<c0142f45>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Sep 22 20:52:35 hostname kernel: EFLAGS: 00010246
Sep 22 20:52:35 hostname kernel: eax: de61aa60   ebx: de61a3d8   ecx: 
de61a3e0   edx: e29faf60
Sep 22 20:52:35 hostname kernel: esi: de61a3c0   edi: d657b2c0   ebp: 
00000012   esp: c1599f34
Sep 22 20:52:35 hostname kernel: ds: 0018   es: 0018   ss: 0018
Sep 22 20:52:35 hostname kernel: Process kswapd (pid: 4, stackpage=c1599000)
Sep 22 20:52:35 hostname kernel: Stack: 00000000 c12ed3b4 0000001e ffffffff 
c014329b 00000014 c012ad2a 00000006
Sep 22 20:52:35 hostname kernel:        000001d0 00000020 000001d0 c032401c 
c032401c c1598000 0000431a 000001d0
Sep 22 20:52:35 hostname kernel:        c032401c c012af9f c1599fa8 0000003c 
000001d0 00000020 c012b010 c1599fa8
Sep 22 20:52:35 hostname kernel: Call Trace:    [<c014329b>] [<c012ad2a>] 
[<c012af9f>] [<c012b010>] [<c012b1aa>]
Sep 22 20:52:35 hostname kernel:   [<c012b216>] [<c012b34d>] [<c01070d8>]
Sep 22 20:52:35 hostname kernel: Code: 89 02 c7 46 20 00 00 00 00 c7 41 04 00 
00 00 00 8b 7b f0 85


>>EIP; c0142f45 <prune_dcache+85/150>   <=====

>>eax; de61aa60 <_end+1e255a24/20655fc4>
>>ebx; de61a3d8 <_end+1e25539c/20655fc4>
>>ecx; de61a3e0 <_end+1e2553a4/20655fc4>
>>edx; e29faf60 <END_OF_CODE+1fd3a01/????>
>>esi; de61a3c0 <_end+1e255384/20655fc4>
>>edi; d657b2c0 <_end+161b6284/20655fc4>
>>esp; c1599f34 <_end+11d4ef8/20655fc4>

Trace; c014329b <shrink_dcache_memory+1b/40>
Trace; c012ad2a <shrink_cache+28a/370>
Trace; c012af9f <shrink_caches+2f/40>
Trace; c012b010 <try_to_free_pages_zone+60/f0>
Trace; c012b1aa <kswapd_balance_pgdat+4a/a0>
Trace; c012b216 <kswapd_balance+16/30>
Trace; c012b34d <kswapd+9d/c0>
Trace; c01070d8 <arch_kernel_thread+28/40>

Code;  c0142f45 <prune_dcache+85/150>
00000000 <_EIP>:
Code;  c0142f45 <prune_dcache+85/150>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c0142f47 <prune_dcache+87/150>
   2:   c7 46 20 00 00 00 00      movl   $0x0,0x20(%esi)
Code;  c0142f4e <prune_dcache+8e/150>
   9:   c7 41 04 00 00 00 00      movl   $0x0,0x4(%ecx)
Code;  c0142f55 <prune_dcache+95/150>
  10:   8b 7b f0                  mov    0xfffffff0(%ebx),%edi
Code;  c0142f58 <prune_dcache+98/150>
  13:   85 00                     test   %eax,(%eax)
-----------
Sep 22 20:52:36 hostname kernel:  <1>Unable to handle kernel paging request at 
virtual address e29faf60
Sep 22 20:52:36 hostname kernel: c0142f45
Sep 22 20:52:36 hostname kernel: *pde = 00000000
Sep 22 20:52:36 hostname kernel: Oops: 0002
Sep 22 20:52:36 hostname kernel: CPU:    0
Sep 22 20:52:36 hostname kernel: EIP:    0010:[<c0142f45>]    Not tainted
Sep 22 20:52:36 hostname kernel: EFLAGS: 00010246
Sep 22 20:52:36 hostname kernel: eax: de82cc60   ebx: de61aa58   ecx: 
de61aa60   edx: e29faf60
Sep 22 20:52:36 hostname kernel: esi: de61aa40   edi: dd9dc900   ebp: 
00000001   esp: d508be14
Sep 22 20:52:36 hostname kernel: ds: 0018   es: 0018   ss: 0018
Sep 22 20:52:36 hostname kernel: Process imapd (pid: 11387, stackpage=d508b000)
Sep 22 20:52:36 hostname kernel: Stack: 00000000 c111f82c 00000007 ffffffff 
c014329b 00000010 c012ad2a 00000006
Sep 22 20:52:36 hostname kernel:        000001d2 00000020 000001d2 c032401c 
c032401c d508a000 00004094 000001d2
Sep 22 20:52:36 hostname kernel:        c032401c c012af9f d508be88 0000003c 
000001d2 00000020 c012b010 d508be88
Sep 22 20:52:36 hostname kernel: Call Trace:    [<c014329b>] [<c012ad2a>] 
[<c012af9f>] [<c012b010>] [<c012baad>]
Sep 22 20:52:36 hostname kernel:   [<c012bdb2>] [<c0159cc0>] [<c012ba66>] 
[<c012432a>] [<c01249d5>] [<c0124bf2>]
Sep 22 20:52:36 hostname kernel:   [<c0125233>] [<c0125110>] [<c01319c6>] 
[<c0108823>]
Sep 22 20:52:36 hostname kernel: Code: 89 02 c7 46 20 00 00 00 00 c7 41 04 00 
00 00 00 8b 7b f0 85


>>EIP; c0142f45 <prune_dcache+85/150>   <=====

>>eax; de82cc60 <_end+1e467c24/20655fc4>
>>ebx; de61aa58 <_end+1e255a1c/20655fc4>
>>ecx; de61aa60 <_end+1e255a24/20655fc4>
>>edx; e29faf60 <END_OF_CODE+1fd3a01/????>
>>esi; de61aa40 <_end+1e255a04/20655fc4>
>>edi; dd9dc900 <_end+1d6178c4/20655fc4>
>>esp; d508be14 <_end+14cc6dd8/20655fc4>

Trace; c014329b <shrink_dcache_memory+1b/40>
Trace; c012ad2a <shrink_cache+28a/370>
Trace; c012af9f <shrink_caches+2f/40>
Trace; c012b010 <try_to_free_pages_zone+60/f0>
Trace; c012baad <balance_classzone+3d/1c0>
Trace; c012bdb2 <__alloc_pages+182/290>
Trace; c0159cc0 <ext3_get_block+0/70>
Trace; c012ba66 <_alloc_pages+16/20>
Trace; c012432a <page_cache_read+6a/c0>
Trace; c01249d5 <generic_file_readahead+105/140>
Trace; c0124bf2 <do_generic_file_read+1b2/440>
Trace; c0125233 <generic_file_read+93/190>
Trace; c0125110 <file_read_actor+0/90>
Trace; c01319c6 <sys_read+96/f0>
Trace; c0108823 <system_call+33/38>

Code;  c0142f45 <prune_dcache+85/150>
00000000 <_EIP>:
Code;  c0142f45 <prune_dcache+85/150>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c0142f47 <prune_dcache+87/150>
   2:   c7 46 20 00 00 00 00      movl   $0x0,0x20(%esi)
Code;  c0142f4e <prune_dcache+8e/150>
   9:   c7 41 04 00 00 00 00      movl   $0x0,0x4(%ecx)
Code;  c0142f55 <prune_dcache+95/150>
  10:   8b 7b f0                  mov    0xfffffff0(%ebx),%edi
Code;  c0142f58 <prune_dcache+98/150>
  13:   85 00                     test   %eax,(%eax)

---------
Sep 22 03:49:42 hostname kernel: Unable to handle kernel paging request at 
virtual address 2e326528
Sep 22 03:49:42 hostname kernel: c013b230
Sep 22 03:49:42 hostname kernel: *pde = 00000000
Sep 22 03:49:42 hostname kernel: Oops: 0000
Sep 22 03:49:42 hostname kernel: CPU:    0
Sep 22 03:49:42 hostname kernel: EIP:    0010:[<c013b230>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Sep 22 03:49:42 hostname kernel: EFLAGS: 00010206
Sep 22 03:49:42 hostname kernel: eax: 2e326500   ebx: d77539c0   ecx: 
00000000   edx: 00000001
Sep 22 03:49:42 hostname kernel: esi: 00000000   edi: d954bf8c   ebp: 
dcd5eb80   esp: d954bf08
Sep 22 03:49:42 hostname kernel: ds: 0018   es: 0018   ss: 0018
Sep 22 03:49:42 hostname kernel: Process in.qpopper (pid: 6263, 
stackpage=d954b000)
Sep 22 03:49:42 hostname kernel: Stack: d954bf8c c36e4000 00000000 00000001 
00000001 00000001 c36e4012 d77539c0
Sep 22 03:49:42 hostname kernel:        c36e4005 0000000d dc98062a c013b3fa 
c013b57b 00000001 c36e4000 d954bf8c
Sep 22 03:49:42 hostname kernel:        c013b964 00000000 c36e4000 00000000 
bffff064 dae6e960 00000000 00000004
Sep 22 03:49:42 hostname kernel: Call Trace:    [<c013b3fa>] [<c013b57b>] 
[<c013b964>] [<c010d22d>] [<c013111b>]
Sep 22 03:49:42 hostname kernel:   [<c0131476>] [<c0108823>]
Sep 22 03:49:42 hostname kernel: Code: 83 78 28 00 0f 84 87 00 00 00 be 00 e0 
ff ff 21 e6 83 be 54


>>EIP; c013b230 <link_path_walk+6b0/860>   <=====

>>eax; 2e326500 Before first symbol
>>ebx; d77539c0 <_end+1738e984/20655fc4>
>>edi; d954bf8c <_end+19186f50/20655fc4>
>>ebp; dcd5eb80 <_end+1c999b44/20655fc4>
>>esp; d954bf08 <_end+19186ecc/20655fc4>

Trace; c013b3fa <path_walk+1a/20>
Trace; c013b57b <path_lookup+1b/30>
Trace; c013b964 <open_namei+74/570>
Trace; c010d22d <old_mmap+ed/130>
Trace; c013111b <filp_open+3b/60>
Trace; c0131476 <sys_open+36/90>
Trace; c0108823 <system_call+33/38>

Code;  c013b230 <link_path_walk+6b0/860>
00000000 <_EIP>:
Code;  c013b230 <link_path_walk+6b0/860>   <=====
   0:   83 78 28 00               cmpl   $0x0,0x28(%eax)   <=====
Code;  c013b234 <link_path_walk+6b4/860>
   4:   0f 84 87 00 00 00         je     91 <_EIP+0x91> c013b2c1 
<link_path_walk+741/860>
Code;  c013b23a <link_path_walk+6ba/860>
   a:   be 00 e0 ff ff            mov    $0xffffe000,%esi
Code;  c013b23f <link_path_walk+6bf/860>
   f:   21 e6                     and    %esp,%esi
Code;  c013b241 <link_path_walk+6c1/860>
  11:   83 be 54 00 00 00 00      cmpl   $0x0,0x54(%esi)

----------------------------

At time of problems, the machine had been running flawlessly for around 60 days.

To me, this looks a bit like some sort of disk error, but syslog shows no ideX 
errors at all. I guess my question is: do I need to replace a bit of software 
(newer kernel) or hardware? 

I suspected RAM issues, so replaced the memory (ok so far), but still not 
feeling confident, and it's a horrible feeling knowing that a production 
machine may not be stable at anymore.

Any help would be greatly appreciated.

Cheers,

  James.

