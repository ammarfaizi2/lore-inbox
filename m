Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316149AbSEKBIJ>; Fri, 10 May 2002 21:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316182AbSEKBII>; Fri, 10 May 2002 21:08:08 -0400
Received: from ip68-4-246-90.oc.oc.cox.net ([68.4.246.90]:8832 "EHLO
	piggy.ics.uci.edu") by vger.kernel.org with ESMTP
	id <S316149AbSEKBIH>; Fri, 10 May 2002 21:08:07 -0400
Date: Fri, 10 May 2002 18:08:07 -0700 (PDT)
From: Andreas Gal <gal@uci.edu>
To: linux-kernel@vger.kernel.org
Subject: Dell Inspiron 5000 problems
Message-ID: <Pine.LNX.4.44.0205101759340.4124-100000@piggy.ics.uci.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

somehow the recent 2.4 kernels are running worse and worse on my Dell
Inspiron 5000 (NOT 5000e). I am experiencing a number of quite annoying
problems:

1. Dell has a BIOS update out for this machine (A08), but I am still
   using A06. If I update to A08, the keyboard hangs a couple of
   keystrokes after booting. If I suspend & resume the machine, the
   keyboard comes back for a while but it will die off again shortly
   after. I tried to talk to Dell but they only say "we don't support
   Linux for this notebook ...". A while back I tried a 2.2 kernel
   and it worked nicely. Btw, using the kbd-reset flag does not help.
   My gut feeling is that the keyboard interrupt somehow stops
   occuring. It would really help to get info from Dell what they
   changed in the BIOS, the Changelog does not say anything keyboard
   related (any Dell guys reading this?).

2. APM Suspend/Resume: Suspend is working worse with every new release.
   With early 2.4 it nearly always worked, 2.4.9 hand some hangs,
   with 2.4.18 (all redhat stock kernels) the machine nearly never
   survives a suspend. The machine either hangs during suspend
   (screen goes blank, but backlight is still on) or does not come
   back after resume. I think this is closely related to PCMCIA,
   but also happens without a PCMCIA card in the slot. I have
   apmd set up to eject the PCMCIA card before suspend. I saw some
   improvements with the latest BIOS (A08) and the PCMCIA card
   even went alive after resume again (usually I have to pull it
   out and push it back to get it working again, soft eject
   does not work). However, even with the latest BIOS A08 (where
   the keyboard is not working) the machine still hangs often
   when resuming. I know that probably the Dell BIOS is crappy, but
   it would be still nice if I wouldn't have to torture ext3
   so badly. Any clues?

3. USB resets: I have a Microsoft Optical Mouse on the USB port. The
   USB port is resetting every 2-3 seconds (!). This is really a pain.
   I saw this in 2.4.9 sometimes, but in 2.4.18 this happens
   constantly. The mouse has a quite bright LED built in, thus my first
   guess was overpower protection, but it also happens with non-optical
   mice.

May 10 17:44:03 piggy kernel: usb.c: USB disconnect on device 61
May 10 17:44:13 piggy kernel: hub.c: USB new device connect on bus1/1, 
assigned device number 62
May 10 17:44:13 piggy kernel: usb-uhci.c: interrupt, status 3, frame# 963
May 10 17:44:13 piggy kernel: input0: USB HID v1.10 Mouse [Microsoft 
Microsoft USB Mouse] on usb1:62.0
May 10 17:44:16 piggy /etc/hotplug/usb.agent: ... no modules for USB 
product 45e/9/2006
May 10 17:44:28 piggy kernel: usb.c: USB disconnect on device 62
May 10 17:44:30 piggy kernel: hub.c: USB new device connect on bus1/1, 
assigned device number 63
May 10 17:44:30 piggy kernel: usb-uhci.c: interrupt, status 3, frame# 1762
May 10 17:44:30 piggy kernel: input0: USB HID v1.10 Mouse [Microsoft 
Microsoft USB Mouse] on usb1:63.0
May 10 17:44:32 piggy kernel: usb.c: USB disconnect on device 63
May 10 17:44:33 piggy kernel: hub.c: USB new device connect on bus1/1, 
assigned device number 64
May 10 17:44:33 piggy kernel: input0: USB HID v1.10 Mouse [Microsoft 
Microsoft USB Mouse] on usb1:64.0
May 10 17:44:33 piggy /etc/hotplug/usb.agent: ... no modules for USB 
product 45e/9/2006
May 10 17:44:35 piggy kernel: usb.c: USB disconnect on device 64
May 10 17:44:36 piggy kernel: hub.c: connect-debounce failed, port 1 
disabled
May 10 17:44:36 piggy /etc/hotplug/usb.agent: ... no modules for USB 
product 45e/9/2006
May 10 17:44:44 piggy kernel: hub.c: USB new device connect on bus1/1, 
assigned device number 65
May 10 17:44:44 piggy kernel: usb-uhci.c: interrupt, status 3, frame# 1473
May 10 17:44:44 piggy kernel: input0: USB HID v1.00 Mouse [Microsoft 
Microsoft Wheel Mouse Optical®] on usb1:65.0
May 10 17:44:47 piggy /etc/hotplug/usb.agent: Setup hid for USB product 
45e/40/121
May 10 17:44:47 piggy /etc/hotplug/usb.agent: Setup mousedev for USB 
product 45e/40/121
May 10 17:44:51 piggy kernel: usb.c: USB disconnect on device 65
May 10 17:44:51 piggy kernel: hub.c: USB new device connect on bus1/1, 
assigned device number 66
May 10 17:44:51 piggy kernel: usb-uhci.c: interrupt, status 3, frame# 563
May 10 17:44:51 piggy kernel: input0: USB HID v1.00 Mouse [Microsoft 
Microsoft Wheel Mouse Optical®] on usb1:66.0
May 10 17:44:54 piggy /etc/hotplug/usb.agent: Setup hid for USB product 
45e/40/121
May 10 17:44:54 piggy /etc/hotplug/usb.agent: Setup mousedev for USB 
product 45e/40/121

----------------

Andreas

