Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136518AbREDVVA>; Fri, 4 May 2001 17:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136525AbREDVUv>; Fri, 4 May 2001 17:20:51 -0400
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:63760 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S136518AbREDVUo>;
	Fri, 4 May 2001 17:20:44 -0400
Date: Fri, 4 May 2001 23:20:43 +0200
From: Frank de Lange <frank@unternet.org>
To: linux-kernel@vger.kernel.org
Cc: linux-usb-devel@lists.sourceforge.net
Subject: [OOPS] pegasus + MediaGX: Oops in khubd, the continuing story?
Message-ID: <20010504232043.M7822@unternet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well,

I got fed up with all those Oops'es, so I started scribbling one on a piece of
paper. This is what ksymoops makes of it:

ksymoops 2.4.1 on i586 2.4.4.  Options used
     -V (default)
     -k /var/log/ksymoops/20010504223943.ksyms (specified)
     -l /var/log/ksymoops/20010504223943.modules (specified)
     -o /lib/modules/2.4.3 (specified)
     -m /boot/System.map-2.4.3 (specified)

Warning (compare_maps): snd symbol pm_register not found in /usr/lib/alsa-modules/2.4.3/0.5/snd.o.  Ignoring /usr/lib/alsa-modules/2.4.3/0.5/snd.o entry
Warning (compare_maps): snd symbol pm_send not found in /usr/lib/alsa-modules/2.4.3/0.5/snd.o.  Ignoring /usr/lib/alsa-modules/2.4.3/0.5/snd.o entry
Warning (compare_maps): snd symbol pm_unregister not found in /usr/lib/alsa-modules/2.4.3/0.5/snd.o.  Ignoring /usr/lib/alsa-modules/2.4.3/0.5/snd.o entry
eip: c010f6f3
Oops: 0000
CPU: 0
EIP: 0010:[<c010f6f3>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010007
eax: c2667000   ebx: 00000000     ecx: c2686000       edx: 00000000
esi: 00000046   edi: fffffff8     ebp: c26c7ce8       esp: c26c7ccc
ds: 0018   es: 0018   ss: 0018
Process khubd (pid: 428, stackpage=c26c7000)
Stack: c2686000 c2686074 c283ee40 c26861d0 00000001 00000286 00000001 c283ee40
       c4c840e5 c2686074 c4c7d222 c2686074 2f100000 c2686074 00000002 c4c7eccd
       c2686074 c4c88010 c4c88010 c2a6c000 00000006 c2666000 00000000
Call Trace: c4c840e5 c4c7d222 c4c7cccd c4c88010 c4c88010 c4c7fe9b c4c88014
            c4c80857 c4c8000c c4c88000 c01077df c010813e c0106e60 c0115054
            c0108171 c0106c60 c011196c c4c84213 c4c859c0 c4c84601 ffff0006
            c4c851a2 ffff5f5f c4c85564 c4c86334 c4c8639c c4c86380 c4c8639c
            c4c70ad2 c4c86334 c4c7b2e0 c4c70d5b c4c72988 c4c73dba c4c7b334
            c4c73fa2 c4c7b36c c4c7b36c c4c74135 c010542c
Code: 8b 4f 04 8b 1b 8b 01 85 45 fc 74 51 31 c0 9c 5e fa c7 01 00

>>EIP; c010f6f3 <__wake_up+33/a8>   <=====
Trace; c4c840e5 <[pegasus]__module_parm_desc_loopback+25/28>
Trace; c4c7d222 <[usb-ohci]sohci_return_urb+10e/118>
Trace; c4c7cccd <[usbcore]__kstrtab_usb_devfs_handle+1291/15c4>
Trace; c4c88010 <.data.end+1c51/????>
Trace; c4c88010 <.data.end+1c51/????>
Trace; c4c7fe9b <[usb-ohci]hc_release_ohci+4b/b0>
Trace; c4c88014 <.data.end+1c55/????>
Code;  c010f6f3 <__wake_up+33/a8>
00000000 <_EIP>:
Code;  c010f6f3 <__wake_up+33/a8>   <=====
   0:   8b 4f 04                  mov    0x4(%edi),%ecx   <=====
Code;  c010f6f6 <__wake_up+36/a8>
   3:   8b 1b                     mov    (%ebx),%ebx
Code;  c010f6f8 <__wake_up+38/a8>
   5:   8b 01                     mov    (%ecx),%eax
Code;  c010f6fa <__wake_up+3a/a8>
   7:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
Code;  c010f6fd <__wake_up+3d/a8>
   a:   74 51                     je     5d <_EIP+0x5d> c010f750 <__wake_up+90/a8>
Code;  c010f6ff <__wake_up+3f/a8>
   c:   31 c0                     xor    %eax,%eax
Code;  c010f701 <__wake_up+41/a8>
   e:   9c                        pushf  
Code;  c010f702 <__wake_up+42/a8>
   f:   5e                        pop    %esi
Code;  c010f703 <__wake_up+43/a8>
  10:   fa                        cli    
Code;  c010f704 <__wake_up+44/a8>
  11:   c7 01 00 00 00 00         movl   $0x0,(%ecx)


3 warnings issued.  Results may not be reliable.

I may have made some transcription errors, but the main stuff is there.

This Oops (and others just like it) appear when the pegasus module is reloaded
into the system. Some info on the system and the circumstances:

MediaGXLV (200 MHz) + 5530 'kahlua' companion chip
 (so this is ohci usb)
60 MB RAM (+4MB for video)

SMC 2202 (pegasus chip) 10/100tx USB NIC on a 10baseT LAN

Oops also appears on 2.4.4

Cheers//Frank
-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
