Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315783AbSEZHx2>; Sun, 26 May 2002 03:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315784AbSEZHx1>; Sun, 26 May 2002 03:53:27 -0400
Received: from surf.viawest.net ([216.87.64.26]:10746 "EHLO surf.viawest.net")
	by vger.kernel.org with ESMTP id <S315780AbSEZHxY>;
	Sun, 26 May 2002 03:53:24 -0400
Date: Sun, 26 May 2002 00:53:14 -0700
From: A Guy Called Tyketto <tyketto@wizard.com>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.18-dj1
Message-ID: <20020526075314.GA1307@wizard.com>
In-Reply-To: <20020526014439.GA19527@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux/2.5.7 (i686)
X-uptime: 12:32am  up 3 min,  2 users,  load average: 0.16, 0.16, 0.07
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 26, 2002 at 02:44:39AM +0100, Dave Jones wrote:
> Resync against 2.5.18, and go through the pending patches folder.
> Mostly compilation fixes, but a handful of useful bits too.
> A lot of the pending stuff doesn't apply any more, so it may
> take a while for me to get around to applying. (ie, resending
> resynced versions of patches you sent me may be quicker)
> 
>  -- Davej.

        I seem to be bringing a shitload of bad news to the list. :) Anywho, 
got this with booting -dj1. Oops was handwritten, and thrown through ksymoops:

ksymoops 2.4.5 on i686 2.5.7.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.5.18/ (specified)
     -m /usr/src/linux/System.map (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 00000040
c01cbd2d
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01cbd2d>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010212
eax: 00000020   ebx: 00000000     ecx: 00000008       edx: 00000040
esi: c02f1a20   edi: 00000040     ebp: 00000020       esp: c1525d30
ds: 0010   es: 0018   ss: 0018
Stack: dfe0e928 00000000 dfe0e800 00000000 00000040 c01d086b c02794ac dfe0e928
       00000000 00000010 00000010 00000000 00000010 c0290c84 c02794ac 00000001
       00000000 dfe0e800 00007f80 c02ed6a0 c150e3c0 00000000 c1503ec0 00000000
Call Trace: [<c01d086b>] [<c01cd0b6>] [c01d36cd>] [<c01cebe8>] [<c01cec03>]
   [<c0192025>] [<c0193a94>] [<c01cba91>] [<c01c9ca7>] [<c0192435>] [<c010507e>]
   [<c0105668>]
Code: f3 a5 a8 02 74 08 66 a5 a8 01 74 01 a4 eb 0f 8d 74 26 00 55


>>EIP; c01cbd2d <fb_copy_cmap+9d/2b0>   <=====

>>esi; c02f1a20 <palette_red+0/20>
>>esp; c1525d30 <END_OF_CODE+123244c/????>

Trace; c01d086b <gen_set_cmap+8b/a0>
Trace; c01cd0b6 <fbcon_setup+866/8e0>
Trace; c0192025 <update_screen+25/60>
Trace; c0193a94 <take_over_console+e4/190>
Trace; c01cba91 <register_framebuffer+101/150>
Trace; c01c9ca7 <vgacon_cursor+1b7/1c0>
Trace; c0192435 <poke_blanked_console+55/60>
Trace; c010507e <init+1e/160>
Trace; c0105668 <kernel_thread+28/40>

Code;  c01cbd2d <fb_copy_cmap+9d/2b0>
0000000000000000 <_EIP>:
Code;  c01cbd2d <fb_copy_cmap+9d/2b0>   <=====
   0:   f3 a5                     repz movsl %ds:(%esi),%es:(%edi)   <=====
Code;  c01cbd2f <fb_copy_cmap+9f/2b0>
   2:   a8 02                     test   $0x2,%al
Code;  c01cbd31 <fb_copy_cmap+a1/2b0>
   4:   74 08                     je     e <_EIP+0xe> c01cbd3b <fb_copy_cmap+ab/2b0>
Code;  c01cbd33 <fb_copy_cmap+a3/2b0>
   6:   66 a5                     movsw  %ds:(%esi),%es:(%edi)
Code;  c01cbd35 <fb_copy_cmap+a5/2b0>
   8:   a8 01                     test   $0x1,%al
Code;  c01cbd37 <fb_copy_cmap+a7/2b0>
   a:   74 01                     je     d <_EIP+0xd> c01cbd3a <fb_copy_cmap+aa/2b0>
Code;  c01cbd39 <fb_copy_cmap+a9/2b0>
   c:   a4                        movsb  %ds:(%esi),%es:(%edi)
Code;  c01cbd3a <fb_copy_cmap+aa/2b0>
   d:   eb 0f                     jmp    1e <_EIP+0x1e> c01cbd4b <fb_copy_cmap+bb/2b0>
Code;  c01cbd3c <fb_copy_cmap+ac/2b0>
   f:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c01cbd40 <fb_copy_cmap+b0/2b0>
  13:   55                        push   %ebp

Kernel panic: Attempted to kill init!

        Video card used, is an ATI Rage Fury Pro (Rage128 chipset). Blew up 
right after the framebuffer kicked in. revelant part of .config:

CONFIG_AGP=y
CONFIG_AGP_VIA=y
CONFIG_DRM=y
CONFIG_DRM_R128=y
CONFIG_DRM_RADEON=y
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_ATY=y
CONFIG_FB_ATY_CT=y
CONFIG_FB_RADEON=y
CONFIG_FB_ATY128=y


                                                        BL.        
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

