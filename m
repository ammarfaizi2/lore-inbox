Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273515AbRJPH6P>; Tue, 16 Oct 2001 03:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273691AbRJPH6G>; Tue, 16 Oct 2001 03:58:06 -0400
Received: from ictmac01.ict.uni-karlsruhe.de ([129.13.127.116]:22024 "EHLO
	mail.ict.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id <S273515AbRJPH55>; Tue, 16 Oct 2001 03:57:57 -0400
Message-ID: <3BCBE89C.ADD98E21@ict.uni-karlsruhe.de>
Date: Tue, 16 Oct 2001 09:58:20 +0200
From: =?iso-8859-1?Q?J=F6rg?= Ziuber <ziuber@ict.uni-karlsruhe.de>
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Thomas Hood <jdthood@mail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP BIOS patch against 2.4.12-ac2
In-Reply-To: <E15t6nz-000205-00@the-village.bc.nu> <1003202856.12542.57.camel@thanatos>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tested the updated patch against 2.4.12-ac2 on a Sony Vaio PCG-FX205K.

You can see in the appendix output, no oops.

But, one Problem:
If I attach an USB device to the laptop it will not initialize and I get
the kernel messages, you will find in the last 10 lines of the output.
Amazing: If I cause permament traffic with a working device on IRQ 9
(e.g. a ping via eth0), the USB device will be recognized and works,
even though muuuuch slower.

Ideas ?

Bye,
-- 
J. Ziuber
ziuber@ict.uni-karlsruhe.de



APPENDIX:
---------
/var/log/boot.msg

...
<4>Local APIC disabled by BIOS -- reenabling.
<4>Found and enabled local APIC!
...
<6>Sony Vaio laptop detected.
<4>PCI: PCI BIOS revision 2.10 entry at 0xfd9b0, last bus=1
<4>PCI: Using configuration type 1
<4>PCI: Probing PCI hardware
<3>Unknown bridge resource 2: assuming transparent
<6>PCI: Using IRQ router PIIX [8086/244c] at 00:1f.0
<6>PnPBIOS: Found PnP BIOS installation structure at 0xc00f71a0.
<6>PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x8f27, dseg 0x400.
<6>PnPBIOS: 20 nodes reported by PnP BIOS; 20 recorded by driver.
<4>PnPBIOS: PNP0c01: 0xe0000-0xfffff was already reserved
<4>PnPBIOS: PNP0c01: 0x100000-0xfbfffff was already reserved
<4>PnPBIOS: PNP0c02: 0x4d0-0x4d1 has been reserved
<4>PnPBIOS: PNP0c02: 0x1000-0x105f has been reserved
<4>PnPBIOS: PNP0c02: 0x1060-0x107f has been reserved
<4>PnPBIOS: PNP0c02: 0x1180-0x11bf has been reserved
<4>PnPBIOS: PNP0c02: 0xdc000-0xdffff was already reserved
<4>PnPBIOS: PNP0c02: 0xd8000-0xdbfff was already reserved
...
<6>PCI: Found IRQ 9 for device 00:1f.6
<6>PCI: Sharing IRQ 9 with 00:1f.3
<6>PCI: Sharing IRQ 9 with 00:1f.5
...

/proc/interrupts:

           CPU0       
  0:      44393          XT-PIC  timer
  1:       3023          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  9:          9          XT-PIC  eth0, usb-uhci, usb-uhci
 12:          0          XT-PIC  PS/2 Mouse
 14:       3185          XT-PIC  ide0
 15:          1          XT-PIC  ide1
NMI:          0 
LOC:      44350 
ERR:          0
MIS:          0


/var/log/messages:

Oct 16 09:18:58 shep syslogd 1.3-3: restart.
Oct 16 09:19:00 shep usbmgr[278]: start 0.4.6
Oct 16 09:19:00 shep usbmgr[280]: "usb-uhci" was loaded
Oct 16 09:19:00 shep usbmgr[295]: mount /proc/bus/usb
Oct 16 09:19:00 shep usbmgr[280]: class:0x9 subclass:0x0 protocol:0x0
Oct 16 09:19:01 shep usbmgr[280]: USB device is matched the
configuration
Oct 16 09:19:01 shep usbmgr[280]: "none" isn't loaded
Oct 16 09:19:01 shep rpc.statd[338]: Version 0.3.1 Starting
Oct 16 09:19:01 shep kernel: klogd 1.3-3, log source = /proc/kmsg
started.
Oct 16 09:19:01 shep kernel: Inspecting /boot/System.map
Oct 16 09:19:01 shep kernel: Symbol table has incorrect version number. 
Oct 16 09:19:01 shep kernel: Inspecting /System.map
Oct 16 09:19:01 shep kernel: Loaded 13123 symbols from /System.map.
Oct 16 09:19:01 shep kernel: Symbols match kernel version 2.4.12.
Oct 16 09:19:01 shep kernel: Loaded 423 symbols from 7 modules.
Oct 16 09:19:01 shep kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
Oct 16 09:19:01 shep kernel: eepro100.c: $Revision: 1.36 $ 2000/11/17
Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
Oct 16 09:19:01 shep kernel: PCI: Found IRQ 9 for device 01:08.0
Oct 16 09:19:01 shep kernel: eth0: Intel Corporation 82820 (ICH2)
Chipset Ethernet Controller, 08:00:46:2B:FE:50, IRQ 9.
Oct 16 09:19:01 shep kernel:   Board assembly 000000-000, Physical
connectors present: RJ45
Oct 16 09:19:01 shep kernel:   Primary interface chip i82555 PHY #1.
Oct 16 09:19:01 shep kernel:   General self-test: passed.
Oct 16 09:19:01 shep kernel:   Serial sub-system self-test: passed.
Oct 16 09:19:01 shep kernel:   Internal registers self-test: passed.
Oct 16 09:19:01 shep kernel:   ROM checksum self-test: passed
(0x04f4518b).
Oct 16 09:19:01 shep kernel: IPv6 v0.8 for NET4.0
Oct 16 09:19:01 shep kernel: IPv6 over IPv4 tunneling driver
Oct 16 09:19:01 shep kernel: usb.c: registered new driver usbdevfs
Oct 16 09:19:01 shep kernel: usb.c: registered new driver hub
Oct 16 09:19:01 shep kernel: usb-uhci.c: $Revision: 1.268 $ time
09:11:00 Oct 16 2001
Oct 16 09:19:01 shep kernel: usb-uhci.c: High bandwidth mode enabled
Oct 16 09:19:01 shep kernel: PCI: Found IRQ 10 for device 00:1f.2
Oct 16 09:19:01 shep kernel: IRQ routing conflict for 00:1f.2, have irq
9, want irq 10
Oct 16 09:19:01 shep kernel: PCI: Setting latency timer of device
00:1f.2 to 64
Oct 16 09:19:01 shep kernel: usb-uhci.c: USB UHCI at I/O 0x1820, IRQ 9
Oct 16 09:19:01 shep kernel: usb-uhci.c: Detected 2 ports
Oct 16 09:19:01 shep kernel: usb.c: new USB bus registered, assigned bus
number 1
Oct 16 09:19:01 shep kernel: usb.c: kmalloc IF cf7aeb40, numif 1
Oct 16 09:19:01 shep kernel: usb.c: new device strings: Mfr=0,
Product=2, SerialNumber=1
Oct 16 09:19:01 shep kernel: usb.c: USB device number 1 default language
ID 0x0
Oct 16 09:19:01 shep kernel: Product: USB UHCI Root Hub
Oct 16 09:19:01 shep kernel: SerialNumber: 1820
Oct 16 09:19:01 shep kernel: hub.c: USB hub found
Oct 16 09:19:01 shep kernel: hub.c: 2 ports detected
Oct 16 09:19:01 shep kernel: hub.c: standalone hub
Oct 16 09:19:01 shep kernel: hub.c: ganged power switching
Oct 16 09:19:01 shep kernel: hub.c: global over-current protection
Oct 16 09:19:01 shep kernel: hub.c: Port indicators are not supported
Oct 16 09:19:01 shep kernel: hub.c: power on to power good time: 2ms
Oct 16 09:19:01 shep kernel: hub.c: hub controller current requirement:
0mA
Oct 16 09:19:01 shep kernel: hub.c: port removable status: RR
Oct 16 09:19:01 shep kernel: hub.c: local power source is good
Oct 16 09:19:01 shep kernel: hub.c: no over-current condition exists
Oct 16 09:19:01 shep kernel: hub.c: enabling power on all ports
Oct 16 09:19:01 shep kernel: usb.c: hub driver claimed interface
cf7aeb40
Oct 16 09:19:01 shep kernel: usb.c: kusbd: /sbin/hotplug add 1
Oct 16 09:19:01 shep kernel: usb.c: kusbd policy returned 0xfffffffe
Oct 16 09:19:01 shep kernel: PCI: Found IRQ 9 for device 00:1f.4
Oct 16 09:19:01 shep kernel: PCI: Setting latency timer of device
00:1f.4 to 64
Oct 16 09:19:01 shep kernel: usb-uhci.c: USB UHCI at I/O 0x2400, IRQ 9
Oct 16 09:19:01 shep kernel: usb-uhci.c: Detected 2 ports
Oct 16 09:19:01 shep kernel: usb.c: new USB bus registered, assigned bus
number 2
Oct 16 09:19:01 shep kernel: usb.c: kmalloc IF cf7aec60, numif 1
Oct 16 09:19:01 shep kernel: usb.c: new device strings: Mfr=0,
Product=2, SerialNumber=1
Oct 16 09:19:01 shep kernel: usb.c: USB device number 1 default language
ID 0x0
Oct 16 09:19:01 shep kernel: Product: USB UHCI Root Hub
Oct 16 09:19:01 shep kernel: SerialNumber: 2400
Oct 16 09:19:01 shep kernel: hub.c: USB hub found
Oct 16 09:19:01 shep kernel: hub.c: 2 ports detected
Oct 16 09:19:01 shep kernel: hub.c: standalone hub
Oct 16 09:19:01 shep kernel: hub.c: ganged power switching
Oct 16 09:19:01 shep kernel: hub.c: global over-current protection
Oct 16 09:19:01 shep kernel: hub.c: Port indicators are not supported
Oct 16 09:19:01 shep kernel: hub.c: power on to power good time: 2ms
Oct 16 09:19:01 shep kernel: hub.c: hub controller current requirement:
0mA
Oct 16 09:19:01 shep kernel: hub.c: port removable status: RR
Oct 16 09:19:01 shep kernel: hub.c: local power source is good
Oct 16 09:19:01 shep kernel: hub.c: no over-current condition exists
Oct 16 09:19:01 shep kernel: hub.c: enabling power on all ports
Oct 16 09:19:01 shep kernel: usb.c: hub driver claimed interface
cf7aec60
Oct 16 09:19:01 shep kernel: usb.c: kusbd: /sbin/hotplug add 1
Oct 16 09:19:01 shep kernel: usb.c: kusbd policy returned 0xfffffffe
Oct 16 09:19:01 shep kernel: usb-uhci.c: v1.268:USB Universal Host
Controller Interface driver
Oct 16 09:19:01 shep kernel: Installing knfsd (copyright (C) 1996
okir@monad.swb.de).
Oct 16 09:19:02 shep /usr/sbin/cron[403]: (CRON) STARTUP (fork ok) 
Oct 16 09:19:03 shep /sbin/SuSEpersonal-firewall: SuSEpersonal-firewall:
Loading of module ipchains was not successful.
Oct 16 09:19:03 shep /sbin/SuSEpersonal-firewall: Aborting. No action
taken.
Oct 16 09:19:09 shep kernel: eth0: no IPv6 routers present
Oct 16 09:20:24 shep kernel: hub.c: port 2 connection change
Oct 16 09:20:24 shep kernel: hub.c: port 2, portstatus 101, change 1, 12
Mb/s
Oct 16 09:20:24 shep kernel: hub.c: port 2, portstatus 103, change 0, 12
Mb/s
Oct 16 09:20:24 shep kernel: hub.c: USB new device connect on bus1/2,
assigned device number 2
Oct 16 09:20:27 shep kernel: usb_control/bulk_msg: timeout
Oct 16 09:20:27 shep kernel: usb.c: USB device not accepting new
address=2 (error=-110)
Oct 16 09:20:27 shep kernel: hub.c: port 2, portstatus 103, change 0, 12
Mb/s
Oct 16 09:20:27 shep kernel: hub.c: USB new device connect on bus1/2,
assigned device number 3
Oct 16 09:20:30 shep kernel: usb_control/bulk_msg: timeout
Oct 16 09:20:30 shep kernel: usb.c: USB device not accepting new
address=3 (error=-110)
