Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316465AbSFCNom>; Mon, 3 Jun 2002 09:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316652AbSFCNol>; Mon, 3 Jun 2002 09:44:41 -0400
Received: from 12-237-16-92.client.attbi.com ([12.237.16.92]:28290 "EHLO
	ledzep.dyndns.org") by vger.kernel.org with ESMTP
	id <S316465AbSFCNoi>; Mon, 3 Jun 2002 09:44:38 -0400
Message-ID: <3CFB72BE.20406@attbi.com>
Date: Mon, 03 Jun 2002 08:44:30 -0500
From: Jordan Breeding <jordan.breeding@attbi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Oops in 2.5.20 with radeon framebuffer
Content-Type: multipart/mixed;
 boundary="------------000602010202030909020705"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000602010202030909020705
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

    For the past couple of 2.5.x kernel versions I have been seeing an
odd Oops on boot of a newly built kernel.  The Oops only happens on
stock kernels from ftp.kernel.org, if I wait until the -dj patch for the
version in question it always boots fine.  I guess the means that
somewhere the framebuffer code in -dj is different enough from mainline
to allow my machine to boot and to work perfectly.  With a mainline
kernel my system will start to boot and then as soon as video switches
from text to framebuffer the Oops happens, the logo in the top left
never even gets drawn.  Attached is a copy of the oops which has been
run through ksymoops already.  Thank you for any help.

Jordan


--------------000602010202030909020705
Content-Type: text/plain;
 name="oops.processed"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops.processed"

ksymoops 2.4.4 on i686 2.5.18-dj1.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.5.20 (specified)
     -m /usr/src/linux/System.map (specified)

No modules in ksyms, skipping objects
Unable to handle kernel NULL pointer dereference at virtual address 00000040
c02e4554
*pde = 00000000
Oops: 0002
CPU: 0
EIP: 0010:[<c02e4554>]  Not Tainted
Using defaults from ksymoops -t elf32-i386 -a i386
eax: c053c6c0 ebx: 00000020 ecx: 00000008 edx: 00000020
esi: c053c6c0 edi: 00000040 ebp: 00000000 esp: c17d7d94
ds: 0018 es: 0018 ss: 0018
Stack: 00000020 00002c2c 00003e3e 00000030 00000010 dfd06128 00000000 00000000
  dfd06000 c02e8fc8 c044530c dfd06128 00000000 00000010 00000010 00000010
  00000010 c046dd84 c044530c 00000001 00000000 dfd06000 c0538340 c1507a40
Call Trace: [<c02e8fc8>] [<c02e59b7>] [<c02eb7fd>] [<c02e73ad>] [<c02512b9>]
  [<c0254f4c>] [<c02e429c>] [<c02e9f59>] [<c022368d>] [<c024048e>] [<c02405d5>]
  [<c02415d6>] [<c02405f2>] [<c02405a0>] [<c0241cc0>] [<c0105000>] [<c0223776>]
  [<c01050de>] [<c0105000>] [<c0107386>] [<c0105080>]
Code: f3 a5 f6 c3 02 74 02 66 a5 f6 c3 01 74 01 a4 eb 0b 53 56 57

>>EIP; c02e4554 <fb_copy_cmap+a4/2c0>   <=====
Trace; c02e8fc8 <gen_set_cmap+88/a0>
Trace; c02e59b7 <fbcon_setup+8c7/940>
Trace; c02eb7fd <radeonfb_switch+fd/130>
Trace; c02e73ad <fbcon_switch+17d/1c0>
Trace; c02512b9 <redraw_screen+c9/140>
Trace; c0254f4c <take_over_console+ec/180>
Trace; c02e429c <register_framebuffer+fc/140>
Trace; c02e9f59 <radeonfb_pci_register+679/7d0>
Trace; c022368d <pci_device_probe+1d/30>
Trace; c024048e <found_match+2e/b0>
Trace; c02405d5 <do_driver_bind+35/40>
Trace; c02415d6 <bus_for_each_dev+a6/120>
Trace; c02405f2 <driver_bind+12/20>
Trace; c02405a0 <do_driver_bind+0/40>
Trace; c0241cc0 <driver_register+b0/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0223776 <pci_register_driver+36/50>
Trace; c01050de <init+5e/200>
Trace; c0105000 <_stext+0/0>
Trace; c0107386 <kernel_thread+26/30>
Trace; c0105080 <init+0/200>
Code;  c02e4554 <fb_copy_cmap+a4/2c0>
00000000 <_EIP>:
Code;  c02e4554 <fb_copy_cmap+a4/2c0>   <=====
   0:   f3 a5                     repz movsl %ds:(%esi),%es:(%edi)   <=====
Code;  c02e4556 <fb_copy_cmap+a6/2c0>
   2:   f6 c3 02                  test   $0x2,%bl
Code;  c02e4559 <fb_copy_cmap+a9/2c0>
   5:   74 02                     je     9 <_EIP+0x9> c02e455d <fb_copy_cmap+ad/2c0>
Code;  c02e455b <fb_copy_cmap+ab/2c0>
   7:   66 a5                     movsw  %ds:(%esi),%es:(%edi)
Code;  c02e455d <fb_copy_cmap+ad/2c0>
   9:   f6 c3 01                  test   $0x1,%bl
Code;  c02e4560 <fb_copy_cmap+b0/2c0>
   c:   74 01                     je     f <_EIP+0xf> c02e4563 <fb_copy_cmap+b3/2c0>
Code;  c02e4562 <fb_copy_cmap+b2/2c0>
   e:   a4                        movsb  %ds:(%esi),%es:(%edi)
Code;  c02e4563 <fb_copy_cmap+b3/2c0>
   f:   eb 0b                     jmp    1c <_EIP+0x1c> c02e4570 <fb_copy_cmap+c0/2c0>
Code;  c02e4565 <fb_copy_cmap+b5/2c0>
  11:   53                        push   %ebx
Code;  c02e4566 <fb_copy_cmap+b6/2c0>
  12:   56                        push   %esi
Code;  c02e4567 <fb_copy_cmap+b7/2c0>
  13:   57                        push   %edi

<0>Kernel Panic: Attempted to kill init!


--------------000602010202030909020705--

