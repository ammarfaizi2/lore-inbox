Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbTJ0J4Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 04:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbTJ0J4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 04:56:24 -0500
Received: from tao.natur.cuni.cz ([195.113.56.1]:8712 "EHLO tao.natur.cuni.cz")
	by vger.kernel.org with ESMTP id S261276AbTJ0JyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 04:54:01 -0500
X-Obalka-From: mmokrejs@natur.cuni.cz
X-Obalka-To: <linux-kernel@vger.kernel.org>
Date: Mon, 27 Oct 2003 10:53:59 +0100 (CET)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: Linux Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: 2.4.23-pre8 slow(radeon issue?)
Message-ID: <Pine.OSF.4.51.0310271038190.303669@tao.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I suspect there's something wrong with 2.4.23-pre8 radeon module or it's
coupling into the kernel(as I don't remember to see a change mentions in
Chagelog). I have Radeon 7500 in laptop ASUS L3800C.

  What happens is that X server eats time to time all CPU time. 2.4.23-pre7
runs fine on same host with same .config. I see some warnings while
compiling radeon(as a module):

make[3]: Entering directory `/usr/src/linux-2.4.23-pre8/drivers/char/drm'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.23-pre8/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /usr/src/linux-2.4.23-pre8/include/linux/modversions.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=radeon_drv  -c -o radeon_drv.o radeon_drv.c
In file included from drmP.h:75,
                 from radeon_drv.c:32:
drm_os_linux.h:16:2: warning: #warning the author of this code needs to read up on list_entry
In file included from radeon_drv.c:35:
radeon_drv.h:846:2: warning: #warning PCI posting bug
In file included from radeon_drv.c:38:
drm_agpsupport.h: In function `radeon_agp_acquire':
drm_agpsupport.h:82: warning: suggest parentheses around assignment used as truth value
In file included from drm_dma.h:33,
                 from radeon_drv.c:42:
drm_os_linux.h:16:2: warning: #warning the author of this code needs to read up on list_entry
...

  Inspecting dmesg output from both kernel doesn't give any hint.
Maybe, /proc/interrupts here, but I don't believe they are much comparable:

--- int.pre7    2003-10-27 09:56:33.000000000 +0100
+++ int.pre8    2003-10-26 13:55:03.000000000 +0100
@@ -1,13 +1,13 @@
            CPU0
-  0:     277051          XT-PIC  timer
-  1:       8873          XT-PIC  keyboard
+  0:     487954          XT-PIC  timer
+  1:       7520          XT-PIC  keyboard
   2:          0          XT-PIC  cascade
-  5:     164445          XT-PIC  Ricoh Co Ltd RL5c476 II, usb-uhci, radeon@PCI:1:0:0
+  5:     327132          XT-PIC  Ricoh Co Ltd RL5c476 II, usb-uhci, radeon@PCI:1:0:0
   8:          2          XT-PIC  rtc
-  9:      22975          XT-PIC  acpi, usb-uhci, eth0
+  9:      25887          XT-PIC  acpi, usb-uhci, eth0
  11:          0          XT-PIC  Ricoh Co Ltd RL5c476 II (#2), Intel ICH3
- 12:       7674          XT-PIC  PS/2 Mouse
- 14:      22148          XT-PIC  ide0
+ 12:       2572          XT-PIC  PS/2 Mouse
+ 14:      13474          XT-PIC  ide0
  15:         91          XT-PIC  ide1
 NMI:          0
 LOC:          0


from XF86Config:

Section "Module"
    Load        "dbe"   # Double buffer extension
    Load        "GLcore"
    Load        "ddc"
    Load        "drm"
    Load        "glx"
    Load        "dri"
    Load        "extmod"
    Load        "type1"
    Load        "freetype"
    Load        "bitmap"
    Load        "vbe"
    Load        "int10"
    Load        "synaptics"
    Load        "record"
    Load        "v4l"
EndSection

Section "Device"
    Identifier  "ATI Radeon M7-P"
    Driver      "ati"
    #VideoRam    32768
    Option      "AGPMode" "4"
    Option      "AGPSize" "64"
    Option      "EnablePageFlip" "true"
    Option      "AGPFastWrite" "true"
    Option      "NoAccel" "false"
    Option      "ForcePCIMode" "false"
    Option      "EnablePageFlip" "true"
    #Option     "UseFBDev" "true"
    # Insert Clocks lines here if appropriate
EndSection


  Any help on that? Please Cc: me in replies, as the SMTP servers used to redistributed
emial from lkml don't have registered their reverse addresses in DNS and so
tcp-wrappers refuse them(we use tcp-wrappers in sendmail to reject such).
-- 
Martin Mokrejs <mmokrejs@natur.cuni.cz>, <m.mokrejs@gsf.de>
PGP5.0i key is at http://www.natur.cuni.cz/~mmokrejs
MIPS / Institute for Bioinformatics <http://mips.gsf.de>
GSF - National Research Center for Environment and Health
Ingolstaedter Landstrasse 1, D-85764 Neuherberg, Germany
tel.: +49-89-3187 3683 , fax: +49-89-3187 3585
