Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264897AbUGGEji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264897AbUGGEji (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 00:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264896AbUGGEji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 00:39:38 -0400
Received: from o-254-174.hosts.cablelink.de ([217.69.254.174]:18699 "EHLO
	little.homeunix.net") by vger.kernel.org with ESMTP id S264897AbUGGEjY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 00:39:24 -0400
From: Matthias Wolle <Matthias.Wolle@gmx.de>
Reply-To: Matthias Wolle <Matthias.Wolle@gmx.de>
Organization: privat
Subject: kernel oops 2.4.25-grsec slab.c/kswapd
Date: Wed, 7 Jul 2004 06:39:21 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407070639.22679.Matthias.Wolle@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 

[please CC I'm not subscribed]

ksymoops 2.4.5 on i586 2.4.25-grsec.  Options used
     -V (default)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.25-grsec/ (specified)
     -m /boot/System.map-2.4.25-grsec (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Jul  7 01:00:12 little kernel: kernel BUG at slab.c:1605!
Jul  7 01:00:12 little kernel: invalid operand: 0000
Jul  7 01:00:12 little kernel: CPU:    0
Jul  7 01:00:12 little kernel: EIP:    0010:[kfree+123/176]    Not tainted
Jul  7 01:00:12 little kernel: EFLAGS: 00010086
Jul  7 01:00:12 little kernel: eax: 0000001d   ebx: 0000367c   ecx: 00000000   edx: c38c0000
Jul  7 01:00:12 little kernel: esi: c013d6e4   edi: 00000286   ebp: 00000851   esp: c10c3f4c
Jul  7 01:00:12 little kernel: ds: 0018   es: 0018   ss: 0018
Jul  7 01:00:12 little kernel: Process kswapd (pid: 4, stackpage=c10c3000)
Jul  7 01:00:12 little kernel: Stack: c031d128 c013d6e4 c093c4f8 c017d688 c09967c4 c01dfde7 c013d6e4 0000003c 
Jul  7 01:00:12 little kernel:        000001d0 00000011 c0102b18 c01e00b5 000014aa c01c6dd5 00000006 000001d0 
Jul  7 01:00:12 little kernel:        00000000 00000000 c0102b18 00000001 c10c2000 00000000 c01c6f47 c0102a40 
Jul  7 01:00:12 little kernel: Call Trace:    [prune_dcache+295/320] [shrink_dcache_memory+37/64] [try_to_free_pages_zone+101/176] [kswapd_balance_pgdat+87/160] [kswapd_balance+22/48]
Jul  7 01:00:12 little kernel: Code: 0f 0b 45 06 f9 d0 31 c0 58 5a 8b 15 10 b8 12 c0 eb d0 8d 76 
Using defaults from ksymoops -t elf32-i386 -a i386


>>ebx; 0000367c Before first symbol
>>edx; c38c0000 <END_OF_CODE+3579920/????>
>>esi; c013d6e4 <pts_termios+364/400>
>>ebp; 00000851 Before first symbol
>>esp; c10c3f4c <END_OF_CODE+d7d86c/????>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   45                        inc    %ebp
Code;  00000003 Before first symbol
   3:   06                        push   %es
Code;  00000004 Before first symbol
   4:   f9                        stc    
Code;  00000005 Before first symbol
   5:   d0                        (bad)  
Code;  00000006 Before first symbol
   6:   31 c0                     xor    %eax,%eax
Code;  00000008 Before first symbol
   8:   58                        pop    %eax
Code;  00000009 Before first symbol
   9:   5a                        pop    %edx
Code;  0000000a Before first symbol
   a:   8b 15 10 b8 12 c0         mov    0xc012b810,%edx
Code;  00000010 Before first symbol
  10:   eb d0                     jmp    ffffffe2 <_EIP+0xffffffe2> ffffffe2 <END_OF_CODE+3fcb9902/????>
Code;  00000012 Before first symbol
  12:   8d 76 00                  lea    0x0(%esi),%esi

Hardware:
00:00.0 Host bridge: Intel Corp. 430HX - 82439HX TXC [Triton II] (rev 01)
00:07.0 ISA bridge: Intel Corp. 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
00:07.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]
00:09.0 Ethernet controller: Surecom Technology NE-34 (rev 01)
00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
00:0c.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2064W [Millennium] (rev 01)

Intel Pentium with F0 0F bug - workaround enabled.
CPU: Intel Pentium 75 - 200 stepping 0c
RAM: 64MB
CPU: 166MHz

Distribution: Debian woody (3.0)
Compiler: gcc 3.3.3 
grsecurity: Version 1.9.14

Additional informatio:
Server runs with kernel 2.4.25-grsec  3 months without any problems.
kernel bug did not killed the machine only kswapd:
kswapd <defunct> 

reproducibility: not tested

greets 
Matthias

-- 
public-key
http://little.homeunix.net/publickey/publickey.txt

