Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317385AbSGOIV4>; Mon, 15 Jul 2002 04:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317386AbSGOIVz>; Mon, 15 Jul 2002 04:21:55 -0400
Received: from cs180154.pp.htv.fi ([213.243.180.154]:32640 "EHLO
	devil.pp.htv.fi") by vger.kernel.org with ESMTP id <S317385AbSGOIVu>;
	Mon, 15 Jul 2002 04:21:50 -0400
Message-ID: <3D3286CA.7070004@welho.com>
Date: Mon, 15 Jul 2002 11:24:42 +0300
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
Reply-To: Mika.Liljeberg@welho.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Fwd: kernel BUG at page_alloc.c:207!]
Content-Type: multipart/mixed;
 boundary="------------010409020603010709020800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010409020603010709020800
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

[ And the same thing in ISO-8859-1 encoding... :-| ]

I caught two instances of the above BUG() in rmque() after [decoded
oopses attached]. The kernel is 2.4.17, untainted but with a few patches
(low-latency, o1, elevator, lkcd). I've got a full kernel crash dump
from the second instance in case it is needed.

I'm currently running 2.4.18 and just the lkcd patch in order to see if
the problem recurs.

	MikaL


--------------010409020603010709020800
Content-Type: text/plain;
 name="crash.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="crash.txt"

ksymoops 2.4.5 on i686 2.4.17o1-ll-elv-lkcd.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17o1-ll-elv-lkcd/ (default)
     -m /boot/System.map-2.4.17o1-ll-elv-lkcd (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Jul 14 20:50:46 devil kernel: kernel BUG at page_alloc.c:207!
Jul 14 20:50:46 devil kernel: invalid operand: 0000
Jul 14 20:50:46 devil kernel: CPU:    0
Jul 14 20:50:47 devil kernel: EIP:    0010:[rmqueue+642/788]    Not tainted
Jul 14 20:50:47 devil kernel: EFLAGS: 00013286
Jul 14 20:50:47 devil kernel: eax: 00000020   ebx: 00000000   ecx: 0111b4b3   edx: 00005c45
Jul 14 20:50:47 devil kernel: esi: c0333328   edi: c13d0204   ebp: 00000000   esp: d66b3e3c
Jul 14 20:50:47 devil kernel: ds: 0018   es: 0018   ss: 0018
Jul 14 20:50:47 devil kernel: Process XFree86 (pid: 441, stackpage=d66b3000)
Jul 14 20:50:47 devil kernel: Stack: c02cba2b 000000cf c0333488 000001ff d7d96210 00000000 0000d5ad 00003282 
Jul 14 20:50:47 devil kernel:        c0333334 00000000 c033330c c013908f 000001d2 4357b000 d7d96210 d7d96210 
Jul 14 20:50:47 devil kernel:        c033330c c0333484 000001d2 ffffffef c0138e0e 00104000 c012c233 4357b000 
Jul 14 20:50:47 devil kernel: Call Trace: [__alloc_pages+51/356] [_alloc_pages+22/24] [do_anonymous_page+131/444] [do_no_page+54/584] [handle_mm_fault+157/408] 
Jul 14 20:50:48 devil kernel: Code: 0f 0b 83 c4 08 90 8d 74 26 00 8b 47 18 a8 80 74 19 68 d1 00 
Using defaults from ksymoops -t elf32-i386 -a i386


>>ecx; 0111b4b3 Before first symbol
>>edx; 00005c45 Before first symbol
>>esi; c0333328 <contig_page_data+c8/340>
>>edi; c13d0204 <END_OF_CODE+fa7f00/????>
>>esp; d66b3e3c <END_OF_CODE+1628bb38/????>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 08                  add    $0x8,%esp
Code;  00000005 Before first symbol
   5:   90                        nop    
Code;  00000006 Before first symbol
   6:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  0000000a Before first symbol
   a:   8b 47 18                  mov    0x18(%edi),%eax
Code;  0000000d Before first symbol
   d:   a8 80                     test   $0x80,%al
Code;  0000000f Before first symbol
   f:   74 19                     je     2a <_EIP+0x2a> 0000002a Before first symbol
Code;  00000011 Before first symbol
  11:   68 d1 00 00 00            push   $0xd1

Jul 14 20:53:09 devil kernel: kernel BUG at page_alloc.c:207!
Jul 14 20:53:09 devil kernel: invalid operand: 0000
Jul 14 20:53:09 devil kernel: CPU:    0
Jul 14 20:53:09 devil kernel: EIP:    0010:[rmqueue+642/788]    Not tainted
Jul 14 20:53:09 devil kernel: EFLAGS: 00013286
Jul 14 20:53:09 devil kernel: eax: 00000020   ebx: 00000000   ecx: 0111b4b3   edx: 000066c8
Jul 14 20:53:09 devil kernel: esi: c0333328   edi: c13d01c0   ebp: 00000000   esp: c2d67e3c
Jul 14 20:53:09 devil kernel: ds: 0018   es: 0018   ss: 0018
Jul 14 20:53:09 devil kernel: Process XFree86 (pid: 11493, stackpage=c2d67000)
Jul 14 20:53:09 devil kernel: Stack: c02cba2b 000000cf c0333488 000001ff d7d96a30 00000000 0000d5ac 00003282 
Jul 14 20:53:09 devil kernel:        c0333328 00000000 c033330c c013908f 000001d2 41c14000 d7d96a30 d7d96a30 
Jul 14 20:53:09 devil kernel:        c033330c c0333484 000001d2 000152ce c0138e0e 00104000 c012c233 41c14000 
Jul 14 20:53:09 devil kernel: Call Trace: [__alloc_pages+51/356] [_alloc_pages+22/24] [do_anonymous_page+131/444] [do_no_page+54/584] [handle_mm_fault+157/408] 
Jul 14 20:53:10 devil kernel: Code: 0f 0b 83 c4 08 90 8d 74 26 00 8b 47 18 a8 80 74 19 68 d1 00 


>>ecx; 0111b4b3 Before first symbol
>>edx; 000066c8 Before first symbol
>>esi; c0333328 <contig_page_data+c8/340>
>>edi; c13d01c0 <END_OF_CODE+fa7ebc/????>
>>esp; c2d67e3c <END_OF_CODE+293fb38/????>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 08                  add    $0x8,%esp
Code;  00000005 Before first symbol
   5:   90                        nop    
Code;  00000006 Before first symbol
   6:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  0000000a Before first symbol
   a:   8b 47 18                  mov    0x18(%edi),%eax
Code;  0000000d Before first symbol
   d:   a8 80                     test   $0x80,%al
Code;  0000000f Before first symbol
   f:   74 19                     je     2a <_EIP+0x2a> 0000002a Before first symbol
Code;  00000011 Before first symbol
  11:   68 d1 00 00 00            push   $0xd1

Jul 14 20:54:49 devil kernel: Kernel command line: BOOT_IMAGE=New ro root=307 video=matrox:sgram,vesa:261,maxclk:210,fh:100000,fv:85,fastfont:65536 parport=auto ide0=autotune ide1=autotune hdb=scsi apm=power-off,smp-power-off,debug acpi=on devfs=nomount nmi_watchdog=1
Jul 14 20:54:49 devil kernel: activating NMI Watchdog ... done.
Jul 14 20:54:49 devil kernel: testing NMI watchdog ... OK.
Jul 14 20:54:49 devil kernel: cpu: 0, clocks: 997387, slice: 332462
Jul 14 20:54:49 devil kernel: cpu: 1, clocks: 997387, slice: 332462

2 warnings issued.  Results may not be reliable.

--------------010409020603010709020800--

