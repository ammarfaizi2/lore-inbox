Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264211AbRFFWiE>; Wed, 6 Jun 2001 18:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264215AbRFFWhy>; Wed, 6 Jun 2001 18:37:54 -0400
Received: from oceanic.wsisiz.edu.pl ([213.135.44.33]:33337 "HELO
	oceanic.wsisiz.edu.pl") by vger.kernel.org with SMTP
	id <S264211AbRFFWhl>; Wed, 6 Jun 2001 18:37:41 -0400
Date: Thu, 7 Jun 2001 00:37:29 +0200 (CEST)
From: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
To: <linux-kernel@vger.kernel.org>
Cc: <alan@lxorguk.ukuu.org.uk>
Subject: 2.4.5-ac7 oops  kswapd
Message-ID: <Pine.LNX.4.33.0106070026450.28272-100000@oceanic.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On my 2.4.5-ac7 SMP regularly I get something like this. Always on kswapd
(pid 3) process.

oceanic:~$ free
             total       used       free     shared    buffers     cached
Mem:       1028488    1024392       4096         52     181064     668876
-/+ buffers/cache:     174452     854036
Swap:       527016      38368     488648

If it was fixed on ac9 - sorry.


ksymoops 2.4.0 on i686 2.4.5-ac7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.5-ac7/ (default)
     -m /lib/modules/2.4.5-ac7/System.map (specified)

Jun  6 14:45:02 oceanic kernel: invalid operand: 0000
Jun  6 14:45:02 oceanic kernel: CPU:    1
Jun  6 14:45:02 oceanic kernel: EIP:    0010:[<c01496c2>]
Using defaults from ksymoops -t elf32-i386 -a i386
Jun  6 14:45:02 oceanic kernel: EFLAGS: 00010206
Jun  6 14:45:02 oceanic kernel: eax: 000003a5   ebx: ea182220   ecx: d7fbf608 edx: c29d89c8
Jun  6 14:45:02 oceanic kernel: esi: ea182220   edi: ea182220   ebp: 00000596 esp: c2129f3c
Jun  6 14:45:02 oceanic kernel: ds: 0018   es: 0018   ss: 0018
Jun  6 14:45:02 oceanic kernel: Process kswapd (pid: 3, stackpage=c2129000)
Jun  6 14:45:02 oceanic kernel: Stack: eaff17c0 d487b240 c014787c ea182220 ea182220 c02a28a0 c014a1d4 ea182220
Jun  6 14:45:02 oceanic kernel:        d1091de0 d1091dc0 c0147c49 ea182220 ea182220 00000000 00000001 c13b1080
Jun  6 14:45:02 oceanic kernel:        00000000 00000007 c012d326 00000001 00000004 00000004 000002ff 00000000
Jun  6 14:45:02 oceanic kernel: Call Trace: [<c014787c>] [<c014a1d4>]
[<c0147c49>] [<c012d326>] [<c0147fd1>]
Jun  6 14:45:02 oceanic kernel:    [<c012d6e7>] [<c012d78b>] [<c0105000>]
[<c0105000>] [<c0105536>] [<c012d720>]
Jun  6 14:45:02 oceanic kernel: Code: 0f 0b 8b 86 f8 00 00 00 a9 10 00 00 00 75 02 0f 0b a9 20 00

>>EIP; c01496c2 <clear_inode+22/110>   <=====
Trace; c014787c <dput+1c/150>
Trace; c014a1d4 <iput+144/150>
Trace; c0147c49 <prune_dcache+c9/160>
Trace; c012d326 <page_launder+676/6c0>
Trace; c0147fd1 <shrink_dcache_memory+21/40>
Trace; c012d6e7 <do_try_to_free_pages+27/60>
Trace; c012d78b <kswapd+6b/f0>
Trace; c0105000 <prepare_namespace+0/10>
Trace; c0105000 <prepare_namespace+0/10>
Trace; c0105536 <kernel_thread+26/30>
Trace; c012d720 <kswapd+0/f0>
Code;  c01496c2 <clear_inode+22/110>
00000000 <_EIP>:
Code;  c01496c2 <clear_inode+22/110>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01496c4 <clear_inode+24/110>
   2:   8b 86 f8 00 00 00         mov    0xf8(%esi),%eax
Code;  c01496ca <clear_inode+2a/110>
   8:   a9 10 00 00 00            test   $0x10,%eax
Code;  c01496cf <clear_inode+2f/110>
   d:   75 02                     jne    11 <_EIP+0x11> c01496d3 <clear_inode+33/110>
Code;  c01496d1 <clear_inode+31/110>
   f:   0f 0b                     ud2a
Code;  c01496d3 <clear_inode+33/110>
  11:   a9 20 00 00 00            test   $0x20,%eax



-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl

