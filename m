Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbUCBKCj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 05:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbUCBKCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 05:02:38 -0500
Received: from matrix.roma2.infn.it ([141.108.255.2]:724 "EHLO
	matrix.roma2.infn.it") by vger.kernel.org with ESMTP
	id S261585AbUCBKCa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 05:02:30 -0500
From: "Emiliano 'AlberT' Gabrielli" <AlberT@SuperAlberT.it>
Reply-To: AlberT@SuperAlberT.it
Organization: SuperAlberT.it
To: linux-kernel@vger.kernel.org
Subject: Synaptics and USB mouse conflict at boot time !?
Date: Tue, 2 Mar 2004 11:03:38 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200403021103.54310.AlberT@SuperAlberT.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Hi all,
	 I have a strange behaviour on my laptop: touchpad is not probed by the 
kernel (2.6.3) *if* and only if at boot time the USB mouse is plugged in ...
 ...
 it seems like there is a sort of conflict between usb and synaptics, but only 
at boot time. If I boot without the usb mouse plugged in, then the touchpad 
is recognised...
and if *now* I plug in the usb mouse then all work fine and both usb and 
synaptics mouse works right together...

Last boot I starter the system with the usb mouse not connected and, after the 
probe of the synaptics touchpad the system starts a fs check... waiting for 
it to end, I plugged the usb mouse in and, surprise: at every movement of the 
usb mouse I have a lot of messages from synaptics:

### /var/log/messages ###

Mar  2 10:26:29 emc2 kernel: Uniform CD-ROM driver Revision: 3.20
Mar  2 10:26:29 emc2 kernel: Console: switching to colour frame buffer device 
128x48
Mar  2 10:26:29 emc2 kernel: mice: PS/2 mouse device common for all mice
Mar  2 10:26:29 emc2 kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Mar  2 10:26:29 emc2 kernel: Synaptics Touchpad, model: 1
Mar  2 10:26:29 emc2 kernel:  Firmware: 5.9
Mar  2 10:26:29 emc2 kernel:  Sensor: 15
Mar  2 10:26:29 emc2 kernel:  new absolute packet format
Mar  2 10:26:29 emc2 kernel:  Touchpad has extended capability bits
Mar  2 10:26:29 emc2 kernel:  -> multifinger detection
Mar  2 10:26:29 emc2 kernel:  -> palm detection
Mar  2 10:26:29 emc2 kernel: input: SynPS/2 Synaptics TouchPad on 
isa0060/serio1
Mar  2 10:26:29 emc2 kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Mar  2 10:26:29 emc2 kernel: input: AT Translated Set 2 keyboard on 
isa0060/serio0
Mar  2 10:26:29 emc2 kernel: NET: Registered protocol family 2
Mar  2 10:26:29 emc2 kernel: IP: routing cache hash table of 4096 buckets, 
32Kbytes
Mar  2 10:26:29 emc2 kernel: TCP: Hash tables configured (established 32768 
bind 65536)
Mar  2 10:26:29 emc2 kernel: ip_conntrack version 2.1 (4091 buckets, 32728 
max) - 300 bytes per
conntrack
Mar  2 10:26:29 emc2 kernel: arp_tables: (C) 2002 David S. Miller
Mar  2 10:26:29 emc2 kernel: kjournald starting.  Commit interval 5 seconds
Mar  2 10:26:29 emc2 kernel: EXT3-fs: mounted filesystem with ordered data 
mode.
Mar  2 10:26:29 emc2 kernel: VFS: Mounted root (ext3 filesystem) readonly.
Mar  2 10:26:29 emc2 kernel: Mounted devfs on /dev
Mar  2 10:26:29 emc2 kernel: Freeing unused kernel memory: 152k freed
Mar  2 10:26:29 emc2 kernel: NET: Registered protocol family 1
Mar  2 10:26:29 emc2 kernel: Adding 1052216k swap on /dev/hda5.  Priority:-1 
extents:1
Mar  2 10:26:29 emc2 kernel: Synaptics driver lost sync at byte 1
Mar  2 10:26:29 emc2 last message repeated 59 times
Mar  2 10:26:29 emc2 kernel: Synaptics driver resynced.
Mar  2 10:26:29 emc2 kernel: Synaptics driver lost sync at byte 1
Mar  2 10:26:29 emc2 last message repeated 53 times
Mar  2 10:26:29 emc2 kernel: Synaptics driver resynced.
Mar  2 10:26:29 emc2 kernel: Synaptics driver lost sync at byte 1

Mar  2 10:26:29 emc2 kernel: Synaptics driver lost sync at byte 1
Mar  2 10:26:29 emc2 last message repeated 74 times
Mar  2 10:26:29 emc2 kernel: EXT3 FS on hda6, internal journal
Mar  2 10:26:29 emc2 kernel: Intel(R) PRO/100 Network Driver - version 
2.3.36-k1
Mar  2 10:26:29 emc2 kernel: Copyright (c) 2003 Intel Corporation
Mar  2 10:26:29 emc2 kernel:
Mar  2 10:26:29 emc2 kernel: e100: eth0: Intel(R) PRO/100 Network Connection
Mar  2 10:26:29 emc2 kernel:   Hardware receive checksums enabled
Mar  2 10:26:29 emc2 kernel:
Mar  2 10:26:29 emc2 kernel: intel8x0_measure_ac97_clock: measured 49420 usecs
Mar  2 10:26:29 emc2 kernel: intel8x0: clocking to 48000
Mar  2 10:26:29 emc2 kernel: kjournald starting.  Commit interval 5 seconds
Mar  2 10:26:29 emc2 kernel: EXT3 FS on hda3, internal journal
Mar  2 10:26:29 emc2 kernel: EXT3-fs: mounted filesystem with ordered data 
mode.
Mar  2 10:26:29 emc2 kernel: drivers/usb/core/usb.c: registered new driver 
usbfs
Mar  2 10:26:29 emc2 kernel: drivers/usb/core/usb.c: registered new driver hub
Mar  2 10:26:29 emc2 kernel: ehci_hcd 0000:00:1d.7: EHCI Host Controller
Mar  2 10:26:29 emc2 kernel: ehci_hcd 0000:00:1d.7: irq 7, pci mem e18ec000
Mar  2 10:26:29 emc2 kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, 
assigned bus number
1
Mar  2 10:26:29 emc2 kernel: PCI: cache line size of 32 is not supported by 
device 0000:00:1d.7
Mar  2 10:26:29 emc2 kernel: ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 
1.00, driver 2003-Dec-29
Mar  2 10:26:29 emc2 kernel: hub 1-0:1.0: USB hub found
Mar  2 10:26:29 emc2 kernel: hub 1-0:1.0: 4 ports detected
Mar  2 10:26:29 emc2 kernel: drivers/usb/host/uhci-hcd.c: USB Universal Host 
Controller Interfac
e driver v2.1
Mar  2 10:26:29 emc2 kernel: uhci_hcd 0000:00:1d.0: UHCI Host Controller
Mar  2 10:26:29 emc2 kernel: uhci_hcd 0000:00:1d.0: irq 3, io base 00001800
Mar  2 10:26:29 emc2 kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, 
assigned bus number
2
Mar  2 10:26:29 emc2 kernel: hub 2-0:1.0: USB hub found
Mar  2 10:26:29 emc2 kernel: hub 2-0:1.0: 2 ports detected
Mar  2 10:26:29 emc2 kernel: uhci_hcd 0000:00:1d.1: UHCI Host Controller
Mar  2 10:26:29 emc2 kernel: uhci_hcd 0000:00:1d.1: irq 11, io base 00001820
Mar  2 10:26:29 emc2 kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, 
assigned bus number
3
Mar  2 10:26:29 emc2 kernel: hub 3-0:1.0: USB hub found
Mar  2 10:26:29 emc2 kernel: hub 3-0:1.0: 2 ports detected
Mar  2 10:26:29 emc2 kernel: usb 3-1: new low speed USB device using address 2
Mar  2 10:26:29 emc2 kernel: NET: Registered protocol family 17
Mar  2 10:26:29 emc2 kernel: ip_tables: (C) 2000-2002 Netfilter core team
Mar  2 10:26:31 emc2 logger: Shorewall Started
Mar  2 10:26:32 emc2 usb.agent[275]: kernel driver usbcore already loaded
Mar  2 10:26:32 emc2 usb.agent[275]: kernel driver usbcore already loaded
Mar  2 10:26:32 emc2 usb.agent[294]: kernel driver usbcore already loaded
Mar  2 10:26:32 emc2 usb.agent[294]: kernel driver usbcore already loaded
Mar  2 10:26:32 emc2 usb.agent[311]: kernel driver usbcore already loaded
Mar  2 10:26:32 emc2 usb.agent[311]: kernel driver usbcore already loaded
Mar  2 10:26:33 emc2 kernel: drivers/usb/core/usb.c: registered new driver 
hiddev
Mar  2 10:26:33 emc2 input.agent[1620]: ... no modules for INPUT product
Mar  2 10:26:33 emc2 input.agent[1629]: ... no modules for INPUT product
Mar  2 10:26:33 emc2 input.agent[1638]: ... no modules for INPUT product 
3/5fe/7/49c
Mar  2 10:26:33 emc2 kernel: input: USB HID v1.00 Mouse [Cypress Sem Cypress 
USB Mouse] on usb-0
000:00:1d.1-1
Mar  2 10:26:33 emc2 kernel: drivers/usb/core/usb.c: registered new driver hid
Mar  2 10:26:33 emc2 kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core 
driver
Mar  2 10:26:34 emc2 kernel: Synaptics driver resynced.


#############################

from here all works fine ...  It seems like the system is made stable only 
after the usb probe is finisced ...


Any idea ???


   
- -- 
<?php echo '       Emiliano `AlberT` Gabrielli       '."\n".
           '  E-Mail: AlberT_AT_SuperAlberT_it  '."\n".
           '  Web:    http://SuperAlberT.it  '."\n".
'  IRC:    #php,#AES azzurra.com '."\n".'ICQ: 158591185'; ?>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFARFwHF4boRkzPHocRApPrAJ4zorIJvQ/eFWEfy8i796h9vtdsQACeL3VK
NNFSYN+K1LZAUrHvz+PM+H4=
=8FGN
-----END PGP SIGNATURE-----

