Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264288AbTFDXR7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 19:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264289AbTFDXR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 19:17:59 -0400
Received: from CPE-203-51-32-18.nsw.bigpond.net.au ([203.51.32.18]:62711 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP id S264288AbTFDXRz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 19:17:55 -0400
Message-ID: <3EDE8147.5B9A7093@eyal.emu.id.au>
Date: Thu, 05 Jun 2003 09:31:19 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.21-rc6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.21-rc6: usb-uhci.c: interrupt
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For some time now I notice these messages when I use my SCSI
tape:
	kernel: usb-uhci.c: interrupt, status 28, frame# 1015
with different frame# each time.

I used a USB mass-storage device a while back, for a short time,
it was since removed.

I am chasing some data corruption and will suspect everything
at this point. Any chance that this causes a problem for scsi
devices?

Anyway, I am rather sure that the usb system should keep quiet
as it is not accessed at all.

boot messages:
==============
May 29 21:40:45 eyal kernel: usb.c: registered new driver usbdevfs
May 29 21:40:45 eyal kernel: usb.c: registered new driver hub
May 29 21:40:45 eyal kernel: usb-uhci.c: $Revision: 1.275 $ time
20:19:46 May 29 2003
May 29 21:40:45 eyal kernel: usb-uhci.c: High bandwidth mode enabled
May 29 21:40:45 eyal kernel: usb-uhci.c: USB UHCI at I/O 0xd800, IRQ 5
May 29 21:40:45 eyal kernel: usb-uhci.c: Detected 2 ports
May 29 21:40:45 eyal kernel: usb.c: new USB bus registered, assigned bus
number 1
May 29 21:40:45 eyal kernel: hub.c: USB hub found
May 29 21:40:45 eyal kernel: hub.c: 2 ports detected
May 29 21:40:45 eyal kernel: usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 5
May 29 21:40:45 eyal kernel: usb-uhci.c: Detected 2 ports
May 29 21:40:45 eyal kernel: usb.c: new USB bus registered, assigned bus
number 2
May 29 21:40:45 eyal kernel: hub.c: USB hub found
May 29 21:40:45 eyal kernel: hub.c: 2 ports detected
May 29 21:40:45 eyal kernel: usb-uhci.c: v1.275:USB Universal Host
Controller Interface driver

Mass-storage usage
==================
May 30 19:16:13 eyal kernel: hub.c: new USB device 00:07.2-1, assigned
address 2
May 30 19:16:13 eyal kernel: usb.c: USB device 2 (vend/prod 0xc76/0x7)
is not claimed by any active driver.
May 30 19:18:56 eyal kernel: SCSI subsystem driver Revision: 1.00
May 30 19:18:57 eyal kernel: Initializing USB Mass Storage driver...
May 30 19:18:57 eyal kernel: usb.c: registered new driver usb-storage
May 30 19:18:57 eyal kernel: scsi0 : SCSI emulation for USB Mass Storage
devices
May 30 19:18:57 eyal kernel:   Vendor:          
Model:                   Rev:     
May 30 19:18:57 eyal kernel:   Type:  
Direct-Access                      ANSI SCSI revision: 02
May 30 19:18:57 eyal kernel: USB Mass Storage support registered.
May 30 19:18:57 eyal kernel: Attached scsi removable disk sda at scsi0,
channel 0, id 0, lun 0
May 30 19:18:57 eyal kernel: SCSI device sda: 512000 512-byte hdwr
sectors (262 MB)
May 30 19:18:57 eyal kernel: sda: Write Protect is off
May 30 19:18:57 eyal kernel:  sda: sda1
May 30 19:21:49 eyal kernel: usb.c: deregistering driver usb-storage
May 30 19:21:49 eyal kernel: scsi : 0 hosts left.
May 30 19:21:53 eyal kernel: usb.c: USB disconnect on device 00:07.2-1
address 2

some stray messages
===================
Jun  3 20:16:15 eyal kernel: usb-uhci.c: interrupt, status 28, frame#
607
Jun  3 20:18:12 eyal kernel: usb-uhci.c: interrupt, status 28, frame#
801
Jun  3 20:18:12 eyal kernel: usb-uhci.c: interrupt, status 28, frame#
329
Jun  3 20:18:40 eyal kernel: usb-uhci.c: interrupt, status 30, frame#
1309
Jun  3 20:20:51 eyal kernel: usb-uhci.c: interrupt, status 28, frame#
1335
Jun  3 20:27:00 eyal kernel: usb-uhci.c: interrupt, status 28, frame#
440
Jun  4 00:24:13 eyal kernel: usb-uhci.c: interrupt, status 28, frame#
1015
Jun  4 01:00:04 eyal kernel: usb-uhci.c: interrupt, status 28, frame#
240

# lsmod
=======
Module                  Size  Used by    Tainted: P  
st                     27124   0  (autoclean)
dc395x_trm             47168   0  (autoclean)
sg                     24772   0  (autoclean)
sd_mod                 10172   0  (autoclean)
scsi_mod               84680   4  [st dc395x_trm sg sd_mod]
bttv                   77568   0  (autoclean)
tuner                   9540   1 
videodev                5664   3  (autoclean) [bttv]
i2c-algo-bit            8300   1  (autoclean) [bttv]
es1371                 27136   1  (autoclean)
gameport                1548   0  (autoclean) [es1371]
ac97_codec             10912   0  (autoclean) [es1371]
soundcore               3588   4  (autoclean) [bttv es1371]
nvidia               1540320  10  (autoclean)
usb-uhci               21764   0  (unused)
usbcore                57152   1  [usb-uhci]
ipt_limit                960   2  (autoclean)
ipt_LOG                 3200   3  (autoclean)
ipt_state                608   4  (autoclean)
iptable_filter          1760   1  (autoclean)
ip_conntrack_ftp        3808   0  (unused)
ip_conntrack           17396   2  [ipt_state ip_conntrack_ftp]
ip_tables              10752   4  [ipt_limit ipt_LOG ipt_state
iptable_filter]
ide-cd                 29024   0  (autoclean)
cdrom                  29024   0  (autoclean) [ide-cd]
via686a                 8228   0 
eeprom                  3552   0  (unused)
i2c-proc                6624   0  [via686a eeprom]
i2c-isa                 1252   0  (unused)
i2c-viapro              3912   0  (unused)
i2c-core               15112   0  [bttv tuner i2c-algo-bit via686a
eeprom i2c-proc i2c-isa i2c-viapro]
3c509                  10400   1  (autoclean)
nls_iso8859-1           2880   2  (autoclean)
nls_cp437               4384   2  (autoclean)
msdos                   4988   2  (autoclean)
fat                    29944   0  (autoclean) [msdos]
serial                 43808   1  (autoclean)
isa-pnp                28796   0  (autoclean) [3c509 serial]
rtc                     6012   0  (autoclean)
unix                   14212  56  (autoclean)

# cat /proc/interrupts 
======================
           CPU0       
  0:   56055069          XT-PIC  timer
  1:     162333          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  4:         29          XT-PIC  serial
  5:      11057          XT-PIC  usb-uhci, usb-uhci, bttv
  8:          3          XT-PIC  rtc
  9:   36502293          XT-PIC  nvidia
 10:    2546310          XT-PIC  es1371, DC395x_TRM
 11:   15725277          XT-PIC  eth0
 12:    2104939          XT-PIC  PS/2 Mouse
 14:    3748686          XT-PIC  ide0
 15:         19          XT-PIC  ide1
NMI:          0 
ERR:          0

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
