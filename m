Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264567AbRFMHsY>; Wed, 13 Jun 2001 03:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264568AbRFMHsO>; Wed, 13 Jun 2001 03:48:14 -0400
Received: from [195.6.125.97] ([195.6.125.97]:61189 "EHLO looping.sycomore.fr")
	by vger.kernel.org with ESMTP id <S264567AbRFMHsJ>;
	Wed, 13 Jun 2001 03:48:09 -0400
Date: Wed, 13 Jun 2001 09:48:13 +0200
From: sebastien person <sebastien.person@sycomore.fr>
To: liste noyau linux <linux-kernel@vger.kernel.org>
Subject: [newbee] Oops
Message-Id: <20010613094813.6a5fec0e.sebastien.person@sycomore.fr>
X-Mailer: Sylpheed version 0.4.66 (GTK+ 1.2.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While testing my module I've meet the following Oops

kernel BUG at slab.c:1095!
invalid operand: 0000
CPU:	0
EIP:	0010:[<c012a4eb>]
EFLAGS:	00010282
eax: 0000001b	ebx: c1227570	ecx: c728c000	edx: c02575a4
esi: c1227570	edi: 00000007	abp: c026fe0c	esp: c026fd84
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c026f000)
Stack: c020dd1b c020ddbb 00000447 c026fdec c026fddc ffffffff c02b6dd7
c026fe20
       0000000a c01ff1b9 c1227570 00000007 0000002a c026fe0c c012a78b
c1227570
       00000007 00000286 c02575a4 00000001 00000286 c723b960 000006dc
c88bb858
Call Trace: [<c020dd1b>] [<c020ddbb>] [<c01ff1b9>] [<c012a78b>]
[<c88bb858>] [<c
011610e>] [<c88bb7f8>]
       [<c01c29ca>] [<c01bbd2e>] [<c01e4f2d>] [<c01e501c>] [<c01e52ce>]
[<c88ba6
de>] [<c016fbae>] [<c01bc26a>]
       [<c0119c7c>] [<c0119b86>] [<c0119a8b>] [<c010a4bf>] [<c0107240>]
[<c01072
40>] [<c01090c4>] [<c0107240>]
       [<c0107240>] [<c0100018>] [<c0107263>] [<c01072e2>] [<c0105000>]
[<c01001
91>]

Code: 0f 0b 83 c4 0c 89 7c 24 04 b8 03 00 00 00 83 64 24 04 07 c7
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

That fully block my box. I tried to use ksymoops :

[root@yprelot /root]# ksymoops -m /root/Oops 
ksymoops 2.4.0 on i686 2.4.2-2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.2-2/ (default)
     -m /root/Oops (specified)

Warning (read_system_map): no kernel symbols in System.map, is /root/Oops
a valid System.map file?
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore
says c882e1a0, /lib/modules/2.4.2-2/kernel/drivers/usb/usbcore.o says
c882dcc0.  Ignoring /lib/modules/2.4.2-2/kernel/drivers/usb/usbcore.o
entry
Reading Oops report from the terminal

[root@yprelot /root]# ksymoops < Oops        
ksymoops 2.4.0 on i686 2.4.2-2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.2-2/ (default)
     -m /boot/System.map-2.4.2-2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring
ksyms_base entry
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base
says c01af860, System.map says c0153510.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore
says c882e1a0, /lib/modules/2.4.2-2/kernel/drivers/usb/usbcore.o says
c882dcc0.  Ignoring /lib/modules/2.4.2-2/kernel/drivers/usb/usbcore.o
entry
kernel BUG at slab.c:1095!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012a4eb>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 0000001b   ebx: c1227570     ecx: c728c000       edx: c02575a4
esi: c1227570   edi: 00000007     abp: c026fe0c       esp: c026fd84
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c026f000)
Stack: c020dd1b c020ddbb 00000447 c026fdec c026fddc ffffffff c02b6dd7
c026fe20
       0000000a c01ff1b9 c1227570 00000007 0000002a c026fe0c c012a78b
c1227570
       00000007 00000286 c02575a4 00000001 00000286 c723b960 000006dc
c88bb858
Call Trace: [<c020dd1b>] [<c020ddbb>] [<c01ff1b9>] [<c012a78b>]
[<c88bb858>] [<c
011610e>] [<c88bb7f8>]
       [<c01c29ca>] [<c01bbd2e>] [<c01e4f2d>] [<c01e501c>] [<c01e52ce>]
[<c88ba6
       [<c0119c7c>] [<c0119b86>] [<c0119a8b>] [<c010a4bf>] [<c0107240>]
[<c01072
       [<c0107240>] [<c0100018>] [<c0107263>] [<c01072e2>] [<c0105000>]
[<c01001
Code: 0f 0b 83 c4 0c 89 7c 24 04 b8 03 00 00 00 83 64 24 04 07 c7

>>EIP; c012a4eb <kmem_cache_grow+6b/240>   <=====
Trace; c020dd1b <error_table+5b43/b698>
Trace; c020ddbb <error_table+5be3/b698>
Trace; c01ff1b9 <vsprintf+349/380>
Trace; c012a78b <kmalloc+6b/a0>
Trace; c88bb858 <END_OF_CODE+1ba99/????>
Code;  c012a4eb <kmem_cache_grow+6b/240>
00000000 <_EIP>:
Code;  c012a4eb <kmem_cache_grow+6b/240>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012a4ed <kmem_cache_grow+6d/240>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c012a4f0 <kmem_cache_grow+70/240>
   5:   89 7c 24 04               mov    %edi,0x4(%esp,1)
Code;  c012a4f4 <kmem_cache_grow+74/240>
   9:   b8 03 00 00 00            mov    $0x3,%eax
Code;  c012a4f9 <kmem_cache_grow+79/240>
   e:   83 64 24 04 07            andl   $0x7,0x4(%esp,1)
Code;  c012a4fe <kmem_cache_grow+7e/240>
  13:   c7 00 00 00 00 00         movl   $0x0,(%eax)

Kernel panic: Aiee, killing interrupt handler!

4 warnings issued.  Results may not be reliable.

So I went into slab.c to trying to understand what happen, but I haven't 
found what was my error .

Is someone could give me advice ?

Thanks

sebastien person
