Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311121AbSD0I2z>; Sat, 27 Apr 2002 04:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311885AbSD0I2y>; Sat, 27 Apr 2002 04:28:54 -0400
Received: from yikes.tolna.net ([193.227.196.2]:29382 "EHLO Yikes.tolna.net")
	by vger.kernel.org with ESMTP id <S311121AbSD0I2x>;
	Sat, 27 Apr 2002 04:28:53 -0400
Date: Sat, 27 Apr 2002 10:28:39 +0200
From: Peter Gervai <grin@tolna.net>
To: linux-kernel@vger.kernel.org
Subject: bug in 2.4.18 (xfs tree),  kernel BUG at page_alloc.c:82!
Message-ID: <20020427082838.GG16901@Yikes.Tolna.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

using 2.4.18-xfs (if you feel bad because it's not the original tree, ignore
the rest of the email, thank you) and running mutt with ~300MB changing
mailbox, which causes it to re-read the box, and do the mail sorting in
memory once every 10-60 seconds. oops came every 10 seconds sometimes, 10-20
minutes the other times. loadavg is below 1.

mutt is using 17MB virtual and ~14MB resident memory out of:

             total       used       free     shared    buffers     cached
Mem:        255308     253048       2260          0      59364      63480
-/+ buffers/cache:     130204     125104
Swap:       305224     152612     152612

ksymoops 2.4.5 on i686 2.4.18-xfs.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-xfs/ (default)
     -m /boot/System.map-2.4.18-xfs (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Apr 27 10:11:00 Yikes kernel:  kernel BUG at page_alloc.c:82!
Apr 27 10:11:00 Yikes kernel: invalid operand: 0000
Apr 27 10:11:00 Yikes kernel: CPU:    0
Apr 27 10:11:00 Yikes kernel: EIP:    0010:[__free_pages_ok+66/688]    Tainted: P 
Apr 27 10:11:00 Yikes kernel: EFLAGS: 00010286
Apr 27 10:11:00 Yikes kernel: eax: 0000001f   ebx: 00000000   ecx: c02a39a0   edx: 0017b743
Apr 27 10:11:00 Yikes kernel: esi: c10f7e40   edi: 00000008   ebp: 00000000   esp: c6c31e80
Apr 27 10:11:00 Yikes kernel: ds: 0018   es: 0018   ss: 0018
Apr 27 10:11:00 Yikes kernel: Process mutt (pid: 2715, stackpage=c6c31000)
Apr 27 10:11:00 Yikes kernel: Stack: c025b638 00000052 00000000 00000001 00000008 00000001 c147503c 00000000 
Apr 27 10:11:00 Yikes kernel:        00000001 00000008 00000001 c012bf1b c0122828 000d1300 00000000 c74d51b0 
Apr 27 10:11:00 Yikes kernel:        00000d11 c0122876 000d1300 4006caac ccb38b00 00000000 ccbbc9c0 c0122b42 
Apr 27 10:11:00 Yikes kernel: Call Trace: [__free_pages+27/32] [swapin_readahead+40/80] [do_swap_page+38/224] [handle_mm_fault+98/176] [do_page_fault+355/1172] 
Apr 27 10:11:00 Yikes kernel: Code: 0f 0b 83 c4 08 89 f0 2b 05 ec 2c 30 c0 c1 f8 06 3b 05 e0 2c 
Using defaults from ksymoops -t elf32-i386 -a i386


>>ecx; c02a39a0 <console_sem+0/14>
>>edx; 0017b743 Before first symbol
>>esi; c10f7e40 <_end+dcc084/105b2244>
>>esp; c6c31e80 <_end+69060c4/105b2244>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 08                  add    $0x8,%esp
Code;  00000005 Before first symbol
   5:   89 f0                     mov    %esi,%eax
Code;  00000007 Before first symbol
   7:   2b 05 ec 2c 30 c0         sub    0xc0302cec,%eax
Code;  0000000d Before first symbol
   d:   c1 f8 06                  sar    $0x6,%eax
Code;  00000010 Before first symbol
  10:   3b 05 e0 2c 00 00         cmp    0x2ce0,%eax

