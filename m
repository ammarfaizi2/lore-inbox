Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317422AbSGIVau>; Tue, 9 Jul 2002 17:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317423AbSGIVat>; Tue, 9 Jul 2002 17:30:49 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:2777 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317422AbSGIVar> convert rfc822-to-8bit; Tue, 9 Jul 2002 17:30:47 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <mcp@linux-systeme.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Subject: htree directory indexing 2.4.18-2 BUG with highmem and also high i/o
Date: Tue, 9 Jul 2002 23:33:01 +0200
X-Mailer: KMail [version 1.4]
Organization: Linux-Systeme GmbH
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200207092333.01130.mcp@linux-systeme.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

I've found a bug with htree directory indexing patch and
highmem enabled (64GB). This is with 2.4.18 and htree patch
2.4.18-2. Oops appears if accessing an ext2 partition with ls
or doing "who/w" in the directory of the ext2 partition.

Without the patch all works fine.


ksymoops 2.4.5 on i686 2.4.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /boot/System.map-2.4.18 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Jul  9 22:47:56 ml570 kernel: Unable to handle kernel NULL pointer dereference 
at virtual address 00000006
Jul  9 22:47:56 ml570 kernel: c019e190
Jul  9 22:47:56 ml570 kernel: *pde = 2a535001
Jul  9 22:47:56 ml570 kernel: Oops: 0000
Jul  9 22:47:56 ml570 kernel: CPU:    1
Jul  9 22:47:56 ml570 kernel: EIP:    0010:[ext2_find_entry+564/836]    Not 
tainted
Jul  9 22:47:56 ml570 kernel: EFLAGS: 00010293
Jul  9 22:47:56 ml570 kernel: eax: 00000400   ebx: 00000000   ecx: d3129900   
edx: 000003f8
Jul  9 22:47:56 ml570 kernel: esi: 00000000   edi: ea080900   ebp: d3133ea4   
esp: d3133e5c
Jul  9 22:47:56 ml570 kernel: ds: 0018   es: 0018   ss: 0018
Jul  9 22:47:56 ml570 kernel: Process w (pid: 371, stackpage=d3133000)
Jul  9 22:47:56 ml570 kernel: Stack: ea080900 00000000 ea080900 d3129900 
c0139535 d3132000 00000000 00000400 
Jul  9 22:47:56 ml570 kernel:        0000000a 00000003 ea080960 00000400 
d31cc500 c01336da e0656b80 001c8000 
Jul  9 22:47:56 ml570 kernel:        00000000 00000246 e925e100 c019e2eb 
e925e100 ea080900 d3133ec0 ea080900 
Jul  9 22:47:56 ml570 kernel: Call Trace: [filemap_nopage+241/524] 
[do_no_page+182/940] [ext2_inode_by_name+27/128] 
Warning (Oops_read): Code line not seen, dumping what data is available

>>ecx; d3129900 <[iptable_nat].bss.end+1a4a6d/8ba16d>
>>edi; ea080900 <END_OF_CODE+1648fb41/????>
>>ebp; d3133ea4 <[iptable_nat].bss.end+1af011/8ba16d>
>>esp; d3133e5c <[iptable_nat].bss.end+1aefc9/8ba16d>

Jul  9 22:47:56 ml570 kernel: Code: 0f b6 43 06 39 45 dc 75 1a 83 3b 00 74 15 
8b 75 e0 8b 4d dc 
Using defaults from ksymoops -t elf32-i386 -a i386


Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f b6 43 06               movzbl 0x6(%ebx),%eax
Code;  00000004 Before first symbol
   4:   39 45 dc                  cmp    %eax,0xffffffdc(%ebp)
Code;  00000007 Before first symbol
   7:   75 1a                     jne    23 <_EIP+0x23> 00000023 Before first 
symbol
Code;  00000009 Before first symbol
   9:   83 3b 00                  cmpl   $0x0,(%ebx)
Code;  0000000c Before first symbol
   c:   74 15                     je     23 <_EIP+0x23> 00000023 Before first 
symbol
Code;  0000000e Before first symbol
   e:   8b 75 e0                  mov    0xffffffe0(%ebp),%esi
Code;  00000011 Before first symbol
  11:   8b 4d dc                  mov    0xffffffdc(%ebp),%ecx

-- 
Kind regards,
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/408B2D54947750EC
Fingerprint: 8602 69E0 A9C2 A509 8661 2B0B 408B 2D54 9477 50EC
Key available at www.keyserver.net. Encrypted e-mail preferred.


