Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131296AbRCWSCt>; Fri, 23 Mar 2001 13:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129245AbRCWSCj>; Fri, 23 Mar 2001 13:02:39 -0500
Received: from cp31483-a.dbsch1.nb.nl.home.com ([217.120.33.210]:1799 "EHLO
	CP31483-A.dbsch1.nb.nl.home.com") by vger.kernel.org with ESMTP
	id <S131296AbRCWSCX>; Fri, 23 Mar 2001 13:02:23 -0500
Date: Fri, 23 Mar 2001 19:02:23 +0100 (CET)
From: Erik Oomen <erik.oomen@home.nl>
X-X-Sender: <oomen@CP31483-A.dbsch1.nb.nl.home.com>
To: <linux-kernel@vger.kernel.org>
Subject: USB & Wacom problem after suspend.
Message-ID: <Pine.LNX.4.33.0103231833340.1345-100000@CP31483-A.dbsch1.nb.nl.home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am using an USB wacom intuos tablet on a dell laptop.  Whenever the
laptop has been in standby mode the tablet does not work anymore.

More detailed, I was in X and submitted an 'apm --suspend' command.  After
the resume I have to switch to a console (Ctrl-Alt-F3 for example), pull
the usb-plug out and put in back in and switch to X.  After that it will
work fine.

Here are the logs:

*** enterring apm --suspend

Mar 23 17:13:46 news127 sudo:    oomen : TTY=pts/4 ; PWD=/home/oomen ;
USER=root ; COMMAND=/usr/bin/apm --suspend
Mar 23 17:13:46 news127 cardmgr[172]: executing: './network suspend eth0'
Mar 23 17:13:46 news127 kernel: uhci.c: root-hub INT complete: port1: 183
port2: 80 data: 2
Mar 23 17:13:46 news127 kernel: hub.c: port 1 connection change
Mar 23 17:13:46 news127 kernel: hub.c: port 1, portstatus 301, change 1,
1.5 Mb/s
Mar 23 17:13:46 news127 kernel: usb.c: USB disconnect on device 5
Mar 23 17:13:46 news127 kernel: usb.c: kusbd: /sbin/hotplug remove 5
Mar 23 17:13:46 news127 kernel: usb.c: kusbd policy returned 0xfffffffe
Mar 23 17:13:46 news127 kernel: hub.c: port 1, portstatus 303, change 0,
1.5 Mb/s
Mar 23 17:13:46 news127 kernel: hub.c: USB new device connect on bus1/1,
assigned device number 6
Mar 23 17:13:48 news127 cardmgr[172]: executing: './serial suspend ttyS2'
Mar 23 17:13:48 news127 apmd[405]: User Suspend

*** Resume

Mar 23 18:26:11 news127 kernel: uhci.c: uhci_result_control() failed with
status 440000
Mar 23 18:26:11 news127 kernel:   URB [c22b6ca0] urbp [c12f41e0]
Mar 23 18:26:11 news127 kernel:     QH [c0e211e0]
Mar 23 18:26:11 news127 kernel:       td 0: [c12f31e0]
Mar 23 18:26:11 news127 kernel:       012f31a4 e0 LS Stalled CRC/Timeo
Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d
Mar 23 18:26:11 news127 kernel:       td 1: [c12f31a0]
Mar 23 18:26:11 news127 kernel:       00000001 e3 LS IOC Active Length=0
MaxLen=7ff DT1 EndPt=0 Dev=0, PID=69(IN)
Mar 23 18:26:11 news127 kernel: usb.c: USB device not accepting new
address=6 (error=-110)
Mar 23 18:26:11 news127 kernel: uhci.c: root-hub INT complete: port1: 282
port2: 80 data: 2
Mar 23 18:26:12 news127 kernel: hub.c: port 1, portstatus 303, change 0,
1.5 Mb/s
Mar 23 18:26:12 news127 kernel: hub.c: USB new device connect on bus1/1,
assigned device number 7
Mar 23 18:26:12 news127 kernel: usb.c: kmalloc IF c081b3e0, numif 1
Mar 23 18:26:12 news127 kernel: usb.c: skipped 1 class/vendor specific
interface descriptors
Mar 23 18:26:12 news127 kernel: usb.c: new device strings: Mfr=1,
Product=2, SerialNumber=0
Mar 23 18:26:12 news127 kernel: usb.c: USB device number 7 default
language ID 0x409
Mar 23 18:26:12 news127 cardmgr[172]: executing: './network resume eth0'
Mar 23 18:26:12 news127 kernel: Manufacturer: WACOM
Mar 23 18:26:12 news127 cardmgr[172]: executing: './serial resume ttyS2'
Mar 23 18:26:12 news127 kernel: Product: ET-0405-UV1.1-1
Mar 23 18:26:12 news127 kernel: event1: Event device for input0
Mar 23 18:26:12 news127 kernel: input0: Wacom Graphire on usb1:7.0
Mar 23 18:26:12 news127 kernel: usb.c: wacom driver claimed interface
c081b3e0
Mar 23 18:26:12 news127 kernel: usb.c: kusbd: /sbin/hotplug add 7
Mar 23 18:26:12 news127 kernel: usb.c: kusbd policy returned 0xfffffffe
Mar 23 18:26:13 news127 modprobe: modprobe: Can't locate module
sound-slot-0
Mar 23 18:26:13 news127 modprobe: modprobe: Can't locate module
sound-service-0-6
Mar 23 18:26:13 news127 kernel: eth0: lost link beat
Mar 23 18:26:13 news127 kernel: eth0: autonegotiation restarted
Mar 23 18:26:14 news127 kernel: eth0: remote fault detected
Mar 23 18:26:16 news127 apmd[405]: Normal Resume after 01:12:28 (100%
5:19) AC power

*** In the console, pluggin it out and in again:

Mar 23 18:28:33 news127 kernel: uhci.c: root-hub INT complete: port1: 8a
port2: 80 data: 2
Mar 23 18:28:33 news127 kernel: hub.c: port 1 connection change
Mar 23 18:28:33 news127 kernel: hub.c: port 1, portstatus 100, change 3,
12 Mb/s
Mar 23 18:28:33 news127 kernel: usb.c: USB disconnect on device 8
Mar 23 18:28:33 news127 kernel: usb.c: kusbd: /sbin/hotplug remove 8
Mar 23 18:28:33 news127 kernel: usb.c: kusbd policy returned 0xfffffffe
Mar 23 18:28:33 news127 kernel: uhci.c: root-hub INT complete: port1: 88
port2: 80 data: 2
Mar 23 18:28:33 news127 kernel: hub.c: port 1 enable change, status 100
Mar 23 18:28:34 news127 kernel: uhci.c: root-hub INT complete: port1: 1a3
port2: 80 data: 2
Mar 23 18:28:34 news127 kernel: hub.c: port 1 connection change
Mar 23 18:28:34 news127 kernel: hub.c: port 1, portstatus 301, change 1,
1.5 Mb/s
Mar 23 18:28:34 news127 kernel: hub.c: port 1, portstatus 303, change 0,
1.5 Mb/s
Mar 23 18:28:34 news127 kernel: hub.c: USB new device connect on bus1/1,
assigned device number 9
Mar 23 18:28:34 news127 kernel: usb.c: kmalloc IF c081b3c0, numif 1
Mar 23 18:28:34 news127 kernel: usb.c: skipped 1 class/vendor specific
interface descriptors
Mar 23 18:28:34 news127 kernel: usb.c: new device strings: Mfr=1,
Product=2, SerialNumber=0
Mar 23 18:28:34 news127 kernel: usb.c: USB device number 9 default
language ID 0x409
Mar 23 18:28:34 news127 kernel: Manufacturer: WACOM
Mar 23 18:28:34 news127 kernel: Product: ET-0405-UV1.1-1
Mar 23 18:28:34 news127 kernel: event0: Event device for input0
Mar 23 18:28:34 news127 kernel: input0: Wacom Graphire on usb1:9.0
Mar 23 18:28:34 news127 kernel: usb.c: wacom driver claimed interface
c081b3c0
Mar 23 18:28:34 news127 kernel: usb.c: kusbd: /sbin/hotplug add 9
Mar 23 18:28:34 news127 kernel: usb.c: kusbd policy returned 0xfffffffe


