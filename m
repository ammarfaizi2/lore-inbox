Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbVHLMtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbVHLMtP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 08:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbVHLMtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 08:49:15 -0400
Received: from wigwam.ethz.ch ([129.132.189.109]:60886 "EHLO wigwam.lugs.ch")
	by vger.kernel.org with ESMTP id S1751041AbVHLMtO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 08:49:14 -0400
Date: Fri, 12 Aug 2005 14:46:28 +0200 (CEST)
From: Beat Rubischon <rubischon@phys.ethz.ch>
To: linux-kernel@vger.kernel.org
Subject: Oops in NFS client's call_decode()
Message-ID: <Pine.LNX.4.58L.0508121411570.2031@wigwam.lugs.ch>
X-URL: http://www.phys.ethz.ch/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

"wiggis" is our mailserver, is using NFS from several FreeBSD
fileservers. From time to time, usually all one to ten days, we
have an Oops while Postfix's local trys to fstat64() the user's
~/.forward. After that, errors in every part of the system occurs
and a crash follows in 10-20 hours.

Kernel is vanilla 2.4.31 running on a Debian Woody. Computer was
replaced by a complete different hardware - same effect.

The servers are running FreeBSD 4.11-RELEASE-p11 and
5.4-RELEASE-p6.

Output of ksymoops:

---8<---
ksymoops 2.4.5 on i686 2.4.31.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.31/ (default)
     -m /boot/System.map (specified)

Unable to handle kernel paging request at virtual address ffa4a000
c0172089
*pde = 00002063
Oops: 0002
CPU:    0
EIP:    0010:[<c0172089>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010292
eax: 00000ffc   ebx: f7050408   ecx: ffa49000   edx: dd0a0000
esi: 0000001c   edi: f7050464   ebp: f70503d0   esp: e18f9d94
ds: 0018   es: 0018   ss: 0018
Process local (pid: 19425, stackpage=e18f9000)
Stack: e18f9e1c f7050428 c02502f2 f70503d0 c8f9da38 00000000 e18f8000 e18f9ddc
       e18f9e84 e18f9e1c c0171fe4 c025310a e18f9e1c e18f9e1c fffffff5 e18f9e1c
       f6f5d080 e18f8000 00000000 e18f8000 00000000 00000000 c0253364 e18f9e1c
Call Trace:    [<c02502f2>] [<c0171fe4>] [<c025310a>] [<c0253364>] [<c024f8cd>]
  [<c0252810>] [<c0172e0f>] [<c017452c>] [<c0124f44>] [<c017457b>] [<c0174510>]
  [<c017467e>] [<c0139b39>] [<c013a056>] [<c013a1c7>] [<c013a3f6>] [<c013703d>]
  [<c0106b63>]
Code: c6 44 08 04 00 8b 43 10 8b 10 a1 88 22 31 c0 f7 d8 39 05 84


>>EIP; c0172089 <nfs_xdr_readlinkres+a5/e0>   <=====

>>eax; 00000ffc Before first symbol
>>ebx; f7050408 <_end+36d08e4c/388cca44>
>>ecx; ffa49000 <END_OF_CODE+6dc5eb1/????>
>>edx; dd0a0000 <_end+1cd58a44/388cca44>
>>edi; f7050464 <_end+36d08ea8/388cca44>
>>ebp; f70503d0 <_end+36d08e14/388cca44>
>>esp; e18f9d94 <_end+215b27d8/388cca44>

Trace; c02502f2 <call_decode+162/1a4>
Trace; c0171fe4 <nfs_xdr_readlinkres+0/e0>
Trace; c025310a <__rpc_execute+a2/2a8>
Trace; c0253364 <rpc_execute+54/70>
Trace; c024f8cd <rpc_call_sync+7d/a4>
Trace; c0252810 <rpc_run_timer+0/5c>
Trace; c0172e0f <nfs_proc_readlink+83/ac>
Trace; c017452c <nfs_symlink_filler+1c/54>
Trace; c0124f44 <read_cache_page+8c/120>
Trace; c017457b <nfs_getlink+17/80>
Trace; c0174510 <nfs_symlink_filler+0/54>
Trace; c017467e <nfs_follow_link+22/74>
Trace; c0139b39 <link_path_walk+3a1/8a4>
Trace; c013a056 <path_walk+1a/1c>
Trace; c013a1c7 <path_lookup+1b/24>
Trace; c013a3f6 <__user_walk+26/40>
Trace; c013703d <sys_lstat64+19/70>
Trace; c0106b63 <system_call+33/38>

Code;  c0172089 <nfs_xdr_readlinkres+a5/e0>
00000000 <_EIP>:
Code;  c0172089 <nfs_xdr_readlinkres+a5/e0>   <=====
   0:   c6 44 08 04 00            movb   $0x0,0x4(%eax,%ecx,1)   <=====
Code;  c017208e <nfs_xdr_readlinkres+aa/e0>
   5:   8b 43 10                  mov    0x10(%ebx),%eax
Code;  c0172091 <nfs_xdr_readlinkres+ad/e0>
   8:   8b 10                     mov    (%eax),%edx
Code;  c0172093 <nfs_xdr_readlinkres+af/e0>
   a:   a1 88 22 31 c0            mov    0xc0312288,%eax
Code;  c0172098 <nfs_xdr_readlinkres+b4/e0>
   f:   f7 d8                     neg    %eax
Code;  c017209a <nfs_xdr_readlinkres+b6/e0>
  11:   39 05 84 00 00 00         cmp    %eax,0x84
---8<---

Disassemble of call_decode:
---8<---
0xc0250190 <call_decode>:       sub    $0x4,%esp
0xc0250193 <call_decode+3>:     push   %ebp
0xc0250194 <call_decode+4>:     push   %edi
0xc0250195 <call_decode+5>:     push   %esi
0xc0250196 <call_decode+6>:     push   %ebx
0xc0250197 <call_decode+7>:     mov    0x18(%esp,1),%ebx
0xc025019b <call_decode+11>:    mov    0x14(%ebx),%esi
0xc025019e <call_decode+14>:    mov    0x18(%ebx),%ebp
0xc02501a1 <call_decode+17>:    mov    0x8(%esi),%edx
0xc02501a4 <call_decode+20>:    mov    0x24(%ebx),%eax
0xc02501a7 <call_decode+23>:    lea    (%eax,%eax,2),%eax
0xc02501aa <call_decode+26>:    mov    0x8(%edx,%eax,8),%eax
0xc02501ae <call_decode+30>:    mov    %eax,0x10(%esp,1)
0xc02501b2 <call_decode+34>:    testb  $0x2,0xc03475a0
0xc02501b9 <call_decode+41>:    je     0xc02501d4 <call_decode+68>
0xc02501bb <call_decode+43>:    mov    0x1c(%ebx),%eax
0xc02501be <call_decode+46>:    push   %eax
0xc02501bf <call_decode+47>:    movzwl 0x80(%ebx),%eax
0xc02501c6 <call_decode+54>:    push   %eax
0xc02501c7 <call_decode+55>:    push   $0xc029f280
0xc02501cc <call_decode+60>:    call   0xc0113ae8 <printk>
0xc02501d1 <call_decode+65>:    add    $0xc,%esp
0xc02501d4 <call_decode+68>:    testb  $0x4,0x20(%esi)
0xc02501d8 <call_decode+72>:    je     0xc02501f9 <call_decode+105>
0xc02501da <call_decode+74>:    testb  $0x20,0x78(%ebx)
0xc02501de <call_decode+78>:    je     0xc02501f9 <call_decode+105>
0xc02501e0 <call_decode+80>:    mov    0x10(%esi),%eax
0xc02501e3 <call_decode+83>:    push   %eax
0xc02501e4 <call_decode+84>:    mov    0x14(%esi),%eax
0xc02501e7 <call_decode+87>:    push   %eax
0xc02501e8 <call_decode+88>:    push   $0xc029f2a2
0xc02501ed <call_decode+93>:    call   0xc0113ae8 <printk>
0xc02501f2 <call_decode+98>:    andb   $0xdf,0x78(%ebx)
0xc02501f6 <call_decode+102>:   add    $0xc,%esp
0xc02501f9 <call_decode+105>:   mov    0x1c(%ebx),%eax
0xc02501fc <call_decode+108>:   cmp    $0xb,%eax
0xc02501ff <call_decode+111>:   jg     0xc0250245 <call_decode+181>
0xc0250201 <call_decode+113>:   testb  $0x1,0x20(%esi)
0xc0250205 <call_decode+117>:   jne    0xc0250220 <call_decode+144>
0xc0250207 <call_decode+119>:   movl   $0xc024ff34,0x44(%ebx)
0xc025020e <call_decode+126>:   mov    0x1c(%esi),%eax
0xc0250211 <call_decode+129>:   incl   0x1c(%eax)
0xc0250214 <call_decode+132>:   jmp    0xc0250320 <call_decode+400>
0xc0250219 <call_decode+137>:   lea    0x0(%esi,1),%esi
0xc0250220 <call_decode+144>:   push   %eax
0xc0250221 <call_decode+145>:   mov    0x14(%esi),%eax
0xc0250224 <call_decode+148>:   push   %eax
0xc0250225 <call_decode+149>:   push   $0xc029f2c0
0xc025022a <call_decode+154>:   call   0xc0113ae8 <printk>
0xc025022f <call_decode+159>:   add    $0xc,%esp
0xc0250232 <call_decode+162>:   movl   $0xfffffffb,0x1c(%ebx)
0xc0250239 <call_decode+169>:   movl   $0x0,0x44(%ebx)
0xc0250240 <call_decode+176>:   jmp    0xc025032e <call_decode+414>
0xc0250245 <call_decode+181>:   lea    0x38(%ebp),%esi
0xc0250248 <call_decode+184>:   lea    0x74(%ebp),%edi
0xc025024b <call_decode+187>:   mov    $0x20,%ecx
0xc0250250 <call_decode+192>:   cld
0xc0250251 <call_decode+193>:   test   $0x0,%al
0xc0250253 <call_decode+195>:   repz cmpsb %es:(%edi),%ds:(%esi)
0xc0250255 <call_decode+197>:   je     0xc0250269 <call_decode+217>
0xc0250257 <call_decode+199>:   push   $0xc029f2ec
0xc025025c <call_decode+204>:   push   $0xc029f300
...
---8<---

Please CC myself as I'm not a regular list reader.

Beat Rubischon

-- 
Beat Rubischon				<rubischon@phys.ethz.ch>
Informatiksupport			phone:  +41 44 633 41 89
Departement Physik, ETH Zuerich		mobile: +41 79 347 27 03
