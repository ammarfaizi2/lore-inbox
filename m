Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261652AbSI0Mur>; Fri, 27 Sep 2002 08:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261668AbSI0Muq>; Fri, 27 Sep 2002 08:50:46 -0400
Received: from hazard.jcu.cz ([160.217.1.6]:63111 "EHLO hazard.jcu.cz")
	by vger.kernel.org with ESMTP id <S261652AbSI0Mul>;
	Fri, 27 Sep 2002 08:50:41 -0400
Date: Fri, 27 Sep 2002 14:55:58 +0200
From: Jan Marek <linux@hazard.jcu.cz>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: PROBLEM: Oops while modprobe and possible memory leak...
Message-ID: <20020927125558.GA505@hazard.jcu.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo l-k,

I've had problem while burn CD. Then:

rmmod sg
rmmod sr_mod
rmmod ide-scsi
modprobe ide-scsi

and while I try command 'modprobe sg', I've got this oops:

ksymoops 2.4.6 on i686 2.5.38.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.38/ (default)
     -m /boot/System.map-2.5.38 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel NULL pointer dereference at virtual address 00000000
c01af30c
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c01af30c>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: cb29d49c   edx: 00000000
esi: 00000000   edi: c35e2000   ebp: c35e2000   esp: c35e3ec8
ds: 0068   es: 0068   ss: 0068
Stack: cfeaf138 00000000 d0905434 00000000 00000000 d09123bc d090543c d09123a8
       d090b000 c01ae6ee d0905420 d09123a8 c01ae670 c01af8da d09123a8 00000000
       00000001 00000001 d090dd61 d09123a8 ffffffea c0120cdf d090b060 08089240
Call Trace: [<d0905434>] [<d09123bc>] [<d090543c>] [<d09123a8>] [<c01ae6ee>]
   [<d0905420>] [<d09123a8>] [<c01ae670>] [<c01af8da>] [<d09123a8>] [<d090dd61>]
   [<d09123a8>] [<c0120cdf>] [<d090b060>] [<d0912320>] [<d090b060>] [<c0107a7b>]
Code: 8b 03 0f 18 00 3b 5c 24 08 75 89 c6 05 d0 68 31 c0 01 b8 00


>>EIP; c01af30c <bus_for_each_dev+cc/140>   <=====

>>ecx; cb29d49c <_end+ae965a0/104d2164>
>>edi; c35e2000 <_end+31db104/104d2164>
>>ebp; c35e2000 <_end+31db104/104d2164>
>>esp; c35e3ec8 <_end+31dcfcc/104d2164>

Trace; d0905434 <[ide-scsi].bss.end+1245/1e71>
Trace; d09123bc <.bss.end+4e51/????>
Trace; d090543c <[ide-scsi].bss.end+124d/1e71>
Trace; d09123a8 <.bss.end+4e3d/????>
Trace; c01ae6ee <driver_attach+1e/30>
Trace; d0905420 <[ide-scsi].bss.end+1231/1e71>
Trace; d09123a8 <.bss.end+4e3d/????>
Trace; c01ae670 <do_driver_attach+0/60>
Trace; c01af8da <driver_register+9a/d0>
Trace; d09123a8 <.bss.end+4e3d/????>
Trace; d090dd61 <.bss.end+7f6/????>
Trace; d09123a8 <.bss.end+4e3d/????>
Trace; c0120cdf <sys_init_module+4ef/640>
Trace; d090b060 <[sg]sg_proc_debug_read+70/90>
Trace; d0912320 <.bss.end+4db5/????>
Trace; d090b060 <[sg]sg_proc_debug_read+70/90>
Trace; c0107a7b <syscall_call+7/b>

Code;  c01af30c <bus_for_each_dev+cc/140>
00000000 <_EIP>:
Code;  c01af30c <bus_for_each_dev+cc/140>   <=====
   0:   8b 03                     mov    (%ebx),%eax   <=====
Code;  c01af30e <bus_for_each_dev+ce/140>
   2:   0f 18 00                  prefetchnta (%eax)
Code;  c01af311 <bus_for_each_dev+d1/140>
   5:   3b 5c 24 08               cmp    0x8(%esp,1),%ebx
Code;  c01af315 <bus_for_each_dev+d5/140>
   9:   75 89                     jne    ffffff94 <_EIP+0xffffff94> c01af2a0 <bus_for_each_dev+60/140>
Code;  c01af317 <bus_for_each_dev+d7/140>
   b:   c6 05 d0 68 31 c0 01      movb   $0x1,0xc03168d0
Code;  c01af31e <bus_for_each_dev+de/140>
  12:   b8 00 00 00 00            mov    $0x0,%eax


1 warning issued.  Results may not be reliable.

The second problem I have with memory: kernel consuming memory w/o
released it, I think. When I boot computer, my /proc/meminfo is this:

MemTotal:       255328 kB
MemFree:        102100 kB
MemShared:           0 kB
Buffers:          8164 kB
Cached:          28664 kB
SwapCached:          0 kB
Active:          15608 kB
Inactive:        60792 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       255328 kB
LowFree:        102100 kB
SwapTotal:      498952 kB
SwapFree:       498952 kB
Dirty:             104 kB
Writeback:         580 kB
Mapped:          46396 kB
Slab:            12832 kB
Committed_AS:    96956 kB
PageTables:        528 kB
ReverseMaps:     18060
HugePages:          15
Available:          15
Size:             4096 kB

But before I rebooted, I had about 64MB on the swap with the same
running programs??? I'm sorry, I have not /proc/meminfo before my reboot
:-(.

Sincerely
Jan Marek
-- 
Ing. Jan Marek
University of South Bohemia
Academic Computer Centre
Phone: +420-38-7772080
