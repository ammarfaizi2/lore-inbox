Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276675AbRJUUAa>; Sun, 21 Oct 2001 16:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276688AbRJUUAV>; Sun, 21 Oct 2001 16:00:21 -0400
Received: from mail1.worldcom.ch ([212.74.176.11]:1475 "EHLO mail.worldcom.ch")
	by vger.kernel.org with ESMTP id <S276675AbRJUUAP>;
	Sun, 21 Oct 2001 16:00:15 -0400
Date: Sun, 21 Oct 2001 22:00:36 +0200
From: Charles Bueche <charles@bueche.ch>
To: linux-kernel@vger.kernel.org
Subject: USB mouse cause keyboard lock
Message-Id: <20011021220036.3474e5ea.charles@bueche.ch>
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: 8_J3tE`<lbCYC,MPISj7Mm4]AA:G}E}:j,h,oP]yIP|^su@(x<{$?9)OY$b@&Q\S1s8Hbn4UG:XCBf&PY{+NsTYPJv`M;{e|x"mKj:ZJ3dWa[7!^WvafCL]Su><)i/Y(>`V^O9:"{`7@K'Z@:Wz}{vG~;pqkUDFP0X$:3+.|f5eCjB_uYe&gFhK1$k(\54r#T5{f1j3b--*,8_,fnOMh4Crn%WV7Ir4<sN|"!h
X-message-flag: Microsoft Outlook Fatal Error. Please reboot your system.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an annoying problem with my PC : the keyboard locks up very often.

Hardware : Dell laptop, model Inspiron 5000e, BIOS 06, CPU 600 MHz, 256 Mb
ram, 30 Gb IDE disk, 1600x1200 ATI graphic board, Logitech Wheelmouse
optical USB, model M-BD58 (a true Logitech with color logo, no
OEM-version).

Software : Mandrake 8.0, with a good bunch of official updates and a
self-compiled kernel from kernel.org mirror, without any patch, GPM *not*
running, XFree86-4.0.3-7mdk

first, the situation without problem :

- mouse on PS2 port with USB-to-PS2 Logitech adapter
- XF86Config-4 goes to /dev/psaux for the mouse

now the problematic configuration :

- mouse connected directly to USB port
- XF86Config-4 goes to /dev/input/mice
- nothing else on USB bus

in this config, after working for a while (from 3 min to 2 hours), the
keyboard suddenly locks completely. It's not an application issue, as I
can remotely login and kill X, the lock remain. The only way to get out is
to suspend and resume. I do this using the keyboard key combination. I
suppose therefore that the Fn-Suspend goes to BIOS, which trigger the
suspend. Somewhere in the "upper" layer, my key presses are lost.

In the same config, a lot of keypresses are lost. I evaluate the ratio
loss/good at 1-2%. This key loss problem is not at all present in the
non-USB config.

I definitely would like to get my mouse working on USB, because it's the
only mode where I can get the wheel to work using IMPS/2 protocol in
XF86Config-4.

The problem wasn't present on this laptop with 2.2.x. I think the problem
appeared with 2.4, but I'm not very sure, as I haven't be able to test
this for a long time (because APM wasn't working and each kbd lock needed
a cold boot). Now that I can play with it without enduring 30Gb of mke2fs,
I really would like your help to sort it out.

I'm ready to test all sort of patches and report back to LK, as soon as
you don't ask me to reformat my drive :-)

I have collected some info below, let me know if you need more.

Some more info :
----------------------------------
[root@big root]# uname -a
Linux big.worldcom.ch 2.4.12 #1 Wed Oct 17 11:40:26 CEST 2001 i686 unknown
----------------------------------
[root@big root]# lsmod
Module                  Size  Used by
maestro                26912   1 
tulip_cb               32720   2 
cb_enabler              2480   2  [tulip_cb]
ds                      6560   2  [cb_enabler]
i82365                 22192   2 
pcmcia_core            47520   0  [cb_enabler ds i82365]
irtty                   7536   2  (autoclean)
irda                  142800   1  (autoclean) [irtty]
ip_tables              10688   0 
mousedev                3936   0 
usbmouse                1776   0  (unused)
input                   3328   0  [mousedev usbmouse]
usb-uhci               21152   0  (unused)
usbcore                29568   0  [usbmouse usb-uhci]
nls_iso8859-1           2880   2  (autoclean)
nls_cp850               3616   2  (autoclean)
vfat                    8976   2  (autoclean)
fat                    30496   0  (autoclean) [vfat]
----------------------------------
[root@big root]# grep USB /usr/src/linux/.config | grep -v '^#'
CONFIG_USB=m
CONFIG_USB_UHCI=m
CONFIG_USB_MOUSE=m
----------------------------------
[root@big root]# cat /proc/interrupts 
          CPU0       
 0:     601920          XT-PIC  timer
 1:      13792          XT-PIC  keyboard
 2:          0          XT-PIC  cascade
 3:          5          XT-PIC  serial
 5:      19100          XT-PIC  usb-uhci, ESS Maestro 2E
 8:          5          XT-PIC  rtc
11:      16867          XT-PIC  i82365, eth0
12:     105190          XT-PIC  PS/2 Mouse
14:      14214          XT-PIC  ide0
15:         22          XT-PIC  ide1
NMI:          0 
ERR:        286

---
Charles Bueche <charles@bueche.ch>
snow, wave, wind and net -surfer
