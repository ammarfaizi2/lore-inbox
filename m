Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314446AbSEKGHS>; Sat, 11 May 2002 02:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314456AbSEKGHR>; Sat, 11 May 2002 02:07:17 -0400
Received: from heavymos.kumin.ne.jp ([61.114.158.133]:50745 "HELO
	emerald.kumin.ne.jp") by vger.kernel.org with SMTP
	id <S314446AbSEKGHQ>; Sat, 11 May 2002 02:07:16 -0400
Message-Id: <200205110606.AA00096@prism.kumin.ne.jp>
From: Seiichi Nakashima <nakasima@kumin.ne.jp>
Date: Sat, 11 May 2002 15:06:53 +0900
To: linux-kernel@vger.kernel.org
Subject: 2.5.15 kernel panic again ( VESA VGA graphic console )
MIME-Version: 1.0
X-Mailer: AL-Mail32 Version 1.12
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I install 2.5.15 with vesa framebufer console, and boot up with vga=771 parameter,
then kernel panic occured again ( 2.5.14 occured too ). 
But boot up without vga parameter, 2.5.15 boot up fine.

I send the_oops.txt ( I type text on console ), ksymoops's output and config parameter.
I used "ksymoops -m /boot/System.map -O -K < the_oops.txt"

========== ksymoops input ==========

c01a3776
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01a3776>]    Not tainted
EFLAGS: 00010202
eax: 00000020   ebx: 00000040   ecx: 00000008   edx: 00000000
esi: c029f840   edi: 00000040   ebp: 00000020   esp: c5f97e50
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, threadinfo=c5f96000 task=c5f94040)
Stack: c029fb28 00000000 c029fa00 00000000 00005656 00000008 00000010 c01a7fd7
       c022766c c029fb28 00000000 00000010 00000010 00000000 00000010 c02409c4
       c022766c 00000001 00000000 c029fa00 00007f58 c029b4c0 c10da160 00000000
Call Trace: [<c01a7fd7>] [<c01a64f4>] [<c01a650f>] [<c0175a34>] [<c01791b7>]
   [<c01a3521>] [<c0105023>] [<c010553c>]

Code: f3 a5 a8 02 74 02 66 a5 a8 01 74 01 a4 8b 4c 24 24 8b 44 24
 <0>Kernel panic: Attempted to kill init!

========== ksymoops output ==========

ksymoops 2.4.5 on i686 2.5.15.  Options used
     -V (default)
     -K (specified)
     -l /proc/modules (default)
     -O (specified)
     -m /boot/System.map (specified)

No ksyms, skipping lsmod
c01a3776
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01a3776>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000020   ebx: 00000040   ecx: 00000008   edx: 00000000
esi: c029f840   edi: 00000040   ebp: 00000020   esp: c5f97e50
ds: 0018   es: 0018   ss: 0018
Stack: c029fb28 00000000 c029fa00 00000000 00005656 00000008 00000010 c01a7fd7
       c022766c c029fb28 00000000 00000010 00000010 00000000 00000010 c02409c4
       c022766c 00000001 00000000 c029fa00 00007f58 c029b4c0 c10da160 00000000
Call Trace: [<c01a7fd7>] [<c01a64f4>] [<c01a650f>] [<c0175a34>] [<c01791b7>]
   [<c01a3521>] [<c0105023>] [<c010553c>]
Code: f3 a5 a8 02 74 02 66 a5 a8 01 74 01 a4 8b 4c 24 24 8b 44 24


>>EIP; c01a3776 <fb_copy_cmap+a2/240>   <=====

>>esi; c029f840 <palette_red+0/20>
>>esp; c5f97e50 <END_OF_CODE+5cf64e4/????>

Trace; c01a7fd7 <gen_set_cmap+8b/98>
Trace; c01a64f4 <fbcon_switch+170/1c8>
Trace; c01a650f <fbcon_switch+18b/1c8>
Trace; c0175a34 <redraw_screen+e0/148>
Trace; c01791b7 <take_over_console+f3/190>
Trace; c01a3521 <register_framebuffer+101/12c>
Trace; c0105023 <init+7/124>
Trace; c010553c <kernel_thread+28/38>

Code;  c01a3776 <fb_copy_cmap+a2/240>
0000000000000000 <_EIP>:
Code;  c01a3776 <fb_copy_cmap+a2/240>   <=====
   0:   f3 a5                     repz movsl %ds:(%esi),%es:(%edi)   <=====
Code;  c01a3778 <fb_copy_cmap+a4/240>
   2:   a8 02                     test   $0x2,%al
Code;  c01a377a <fb_copy_cmap+a6/240>
   4:   74 02                     je     8 <_EIP+0x8> c01a377e <fb_copy_cmap+aa/240>
Code;  c01a377c <fb_copy_cmap+a8/240>
   6:   66 a5                     movsw  %ds:(%esi),%es:(%edi)
Code;  c01a377e <fb_copy_cmap+aa/240>
   8:   a8 01                     test   $0x1,%al
Code;  c01a3780 <fb_copy_cmap+ac/240>
   a:   74 01                     je     d <_EIP+0xd> c01a3783 <fb_copy_cmap+af/240>
Code;  c01a3782 <fb_copy_cmap+ae/240>
   c:   a4                        movsb  %ds:(%esi),%es:(%edi)
Code;  c01a3783 <fb_copy_cmap+af/240>
   d:   8b 4c 24 24               mov    0x24(%esp,1),%ecx
Code;  c01a3787 <fb_copy_cmap+b3/240>
  11:   8b 44 24 00               mov    0x0(%esp,1),%eax

 <0>Kernel panic: Attempted to kill init!

========== /usr/src/linux/.config ( frame-buffer only ) ==========

#
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
# CONFIG_FB_RIVA is not set
# CONFIG_FB_CLGEN is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_VESA=y
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_HGA is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_MATROX is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FBCON_ADVANCED is not set
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
# CONFIG_FBCON_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

--------------------------------
  Seiichi Nakashima
  Email   nakasima@kumin.ne.jp
--------------------------------
