Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131949AbRDKIDV>; Wed, 11 Apr 2001 04:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132471AbRDKIDM>; Wed, 11 Apr 2001 04:03:12 -0400
Received: from smtp01.web.de ([194.45.170.210]:17426 "HELO smtp.web.de")
	by vger.kernel.org with SMTP id <S131949AbRDKIDE>;
	Wed, 11 Apr 2001 04:03:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: juergen mischker <j_mischker@web.de>
Reply-To: j_mischker@web.de
To: linux-kernel@vger.kernel.org
Subject: k 2.4.2; usb; handspring-visor
Date: Wed, 11 Apr 2001 09:59:50 +0200
X-Mailer: KMail [version 1.2]
Cc: j_mischker@web.de
MIME-Version: 1.0
Message-Id: <01041109595000.00940@horus.arge>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello
i made an kernelupdate 2.2.16 to 2.4.2 and i am using RH 7.0
with the 2.2.16 kernel the usb-visor communication works perfekt.
now with the 2.4.2 kernel my usb does want to connect to my handspring-visor


#dmesg
...
usb.c: registered new driver hub
uhci.c: USB UHCI at I/O 0xd400, IRQ 9
uhci.c: detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
uhci: host controller process error. something bad happened
uhci: host controller halted. very bad
hub.c: USB hub found
hub.c: 2 ports detected
uhci.c: USB UHCI at I/O 0xd800, IRQ 9
uhci.c: detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
uhci: host controller halted. very bad
uhci: host controller process error. something bad happened
uhci: host controller halted. very bad
hub.c: USB hub found
hub.c: 2 ports detected
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 216k freed
uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
uhci.c: root-hub INT complete: port1: 588 port2: 588 data: 6
uhci.c: root-hub INT complete: port1: 588 port2: 588 data: 6
Adding Swap: 136512k swap-space (priority -1)
#

this sounds a little strange to me.
next thing:

#/sbin/modprobe visor
# /sbin/lsmod
Module                  Size  Used by
visor                   4784   0  (unused)
usbserial              12896   0  [visor]
#

# tail -f  /var/log/messages
...
Apr  8 23:24:57 horus kernel: usbserial.c: USB Serial support registered
for Generic
Apr  8 23:24:57 horus kernel: usb.c: registered new driver serial
Apr  8 23:24:57 horus kernel: usbserial.c: USB Serial support registered
for Handspring Visor

now i want to sync an i pressed the sync button (2 times):

#tail -f /var/log/message
...Apr  8 23:24:57 horus kernel: usbserial.c: USB Serial support registered 
for Generic
Apr  8 23:24:57 horus kernel: usb.c: registered new driver serial
Apr  8 23:24:57 horus kernel: usbserial.c: USB Serial support registered
for Handspring Visor
Apr  8 23:25:30 horus kernel: hub.c: USB new device connect on bus1/1,
assigned device number 3
Apr  8 23:25:33 horus kernel: usb_control/bulk_msg: timeout
Apr  8 23:25:33 horus kernel: usb.c: USB device not accepting new
address=3 (error=-110)
Apr  8 23:25:33 horus kernel: hub.c: USB new device connect on bus1/1,
assigned device number 4
Apr  8 23:25:36 horus kernel: usb_control/bulk_msg: timeout
Apr  8 23:25:36 horus kernel: usb.c: USB device not accepting new
address=4 (error=-110)
Apr  8 23:26:25 horus PAM_unix[909]: (system-auth) session opened for
user root by (uid=500)
Apr  8 23:33:09 horus kernel: hub.c: USB new device connect on bus1/1,
assigned device number 5
Apr  8 23:33:12 horus kernel: usb_control/bulk_msg: timeout
Apr  8 23:33:12 horus kernel: usb.c: USB device not accepting new
address=5 (error=-110)
Apr  8 23:33:13 horus kernel: hub.c: USB new device connect on bus1/1,
assigned device number 6
Apr  8 23:33:16 horus kernel: usb_control/bulk_msg: timeout
Apr  8 23:33:16 horus kernel: usb.c: USB device not accepting new
address=6 (error=-110)


#cat /proc/interrupts 
           CPU0       
  0:      23126          XT-PIC  timer
  1:        468          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:       7624          XT-PIC  es1371
  7:          0          XT-PIC  parport0
  9:          2          XT-PIC  usb-uhci, usb-uhci
 11:          0          XT-PIC  eth0
 12:       8030          XT-PIC  PS/2 Mouse
 14:       9979          XT-PIC  ide0
 15:          9          XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:          0
#

# /sbin/lspci -v

...
00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10) 
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Flags: bus master, medium devsel, latency 32, IRQ 9
        I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2

00:07.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10) 
(prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Flags: bus master, medium devsel, latency 32, IRQ 9
        I/O ports at d800 [size=32]
        Capabilities: [80] Power Management version 2
...


thanks for any help
juergen
