Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276058AbRI1OCy>; Fri, 28 Sep 2001 10:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276059AbRI1OCp>; Fri, 28 Sep 2001 10:02:45 -0400
Received: from smtp7.us.dell.com ([143.166.224.233]:23053 "EHLO
	smtp7.us.dell.com") by vger.kernel.org with ESMTP
	id <S276058AbRI1OCh>; Fri, 28 Sep 2001 10:02:37 -0400
Date: Fri, 28 Sep 2001 09:02:18 -0500 (CDT)
From: Robert Macaulay <robert_macaulay@dell.com>
X-X-Sender: <robert@ping.us.dell.com>
Reply-To: Robert Macaulay <robert_macaulay@dell.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Craig Kulesa <ckulesa@as.arizona.edu>, <linux-kernel@vger.kernel.org>,
        Bob Matthews <bmatthews@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: LILO causes segmentation fault and panic [was Re: highmem deadlock
 fix]
In-Reply-To: <20010928042417.J14277@athlon.random>
Message-ID: <Pine.LNX.4.33.0109280859280.30080-100000@ping.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure if this is 100% related to the latest patch, but after we had our 
0-order allocation failures, I ran lilo to switch to a new kernel, and it 
paniced. Its never done this before, so it might be related.

Robert

ksymoops 2.4.3 on i686 2.4.10-aaStuff.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.10-aaStuff/ (default)
     -m linux-2.4.10/System.map (specified)

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base 
says c01
cf820, System.map says c015a2b0.  Ignoring ksyms_base entry
invalid operand: 0000
CPU:    3
EIP:    0010:[<c012fb27>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: cc403648   ebx: cc403638   ecx: 000003f0   edx: 00000000
esi: cc403638   edi: 000003f0   ebp: 00000246   esp: e3659ea0
ds: 0018   es: 0018   ss: 0018
Process lilo (pid: 6666, stackpage=e3659000)
Stack: 00000000 e3658000 e3658000 00001a0b c024d6bb c011bec6 00001a0b 
cc403638
       cc403640 cc403638 00000246 c0130191 cc403638 000003f0 e3658000 
00001a0b
       c024d6bb 00001a0b c0340018 ea03f400 fffffff4 c03415a0 00000000 
f89166b6
Call Trace: [<c011bec6>] [<c0130191>] [<f89166b6>] [<c0193332>] 
[<c0141936>]
   [<c0138656>] [<c014ce9c>] [<c013855d>] [<c014481e>] [<c0138894>] 
[<c010710b>
Code: 0f 0b f7 c7 00 10 00 00 0f 85 10 02 00 00 b8 00 e0 ff ff 21

>>EIP; c012fb26 <kmem_cache_grow+16/240>   <=====
Trace; c011bec6 <sys_waitpid+16/20>
Trace; c0130190 <kmalloc+150/180>
Trace; f89166b6 <[ide-cd]ide_cdrom_open+36/80>
Trace; c0193332 <ide_open+d2/100>
Trace; c0141936 <blkdev_open+76/d0>
Trace; c0138656 <dentry_open+e6/190>
Trace; c014ce9c <dput+1c/160>
Trace; c013855c <filp_open+4c/60>
Trace; c014481e <getname+5e/a0>
Trace; c0138894 <sys_open+34/c0>
Trace; c010710a <system_call+32/38>
Code;  c012fb26 <kmem_cache_grow+16/240>
00000000 <_EIP>:
Code;  c012fb26 <kmem_cache_grow+16/240>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012fb28 <kmem_cache_grow+18/240>
   2:   f7 c7 00 10 00 00         test   $0x1000,%edi
Code;  c012fb2e <kmem_cache_grow+1e/240>
   8:   0f 85 10 02 00 00         jne    21e <_EIP+0x21e> c012fd44 
<kmem_cache_g
row+234/240>
Code;  c012fb34 <kmem_cache_grow+24/240>
   e:   b8 00 e0 ff ff            mov    $0xffffe000,%eax
Code;  c012fb38 <kmem_cache_grow+28/240>
  13:   21 00                     and    %eax,(%eax)


1 warning issued.  Results may not be reliable.


