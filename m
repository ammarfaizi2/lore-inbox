Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262280AbUK3Taw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbUK3Taw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 14:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262278AbUK3Tav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 14:30:51 -0500
Received: from mid-1.inet.it ([213.92.5.18]:33511 "EHLO mid-1.inet.it")
	by vger.kernel.org with ESMTP id S262277AbUK3T2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 14:28:53 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: 2.6.10-rc2-mm2 usb storage still oopses
Date: Tue, 30 Nov 2004 20:27:55 +0100
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, Pete Zaitcev <zaitcev@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
References: <200411182203.02176.cova@ferrara.linux.it> <20041129163231.33affbde.akpm@osdl.org> <1101784930.2022.116.camel@mulgrave>
In-Reply-To: <1101784930.2022.116.camel@mulgrave>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200411302027.56951.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 04:22, martedì 30 novembre 2004, James Bottomley ha scritto:

> >
> > Guys, is this problem still present in Linus's tree?  If so, is a fix for
> > 2.6.10 looking feasible?
>
> Al Viro has a tentative one at
>
> http://ftp.linux.org.uk/pub/people/viro/register_disk-hack
>
> If someone could try it out and verify that it fixes the problem, we
> could put it in.

OK, here the result for tests, using 2.6.10-rc2-mm4.
I've to put a 
options usbcore old_scheme_first=1
in modprobe.conf, otherwise the device is not detected.
With this option set, all works just fine (no ub module compiled or loaded, if 
needed I can try also with this): no oopses, no call trace, it just works :)

The only small issue is that if i leave plugged the usb flash key and 
power-cycle my box, at boot the device is not detected and it fails in the 
same way it happens when usbcore old_scheme_first is not set (it's present in 
modprobe.conf)

If I unplug/plug the device, all works just fine.

Great work !

Full logs:

Inserting the device with usbcore old_scheme_first=1:

Nov 30 19:54:41 kefk kernel: hub 5-0:1.0: state 5 ports 8 chg ff00 evt 0008
Nov 30 19:54:41 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001803 POWER sig=j  CSC CONNECT
Nov 30 19:54:41 kefk kernel: hub 5-0:1.0: port 3, status 0501, change 0001, 
480 Mb/s
Nov 30 19:54:41 kefk kernel: hub 5-0:1.0: debounce: port 3: total 100ms stable 
100ms status 0x501
Nov 30 19:54:41 kefk kernel: ehci_hcd 0000:00:1d.7: port 3 high speed
Nov 30 19:54:41 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001005 POWER sig=se0  PE CONNECT
Nov 30 19:54:41 kefk kernel: usb 5-3: new high speed USB device using ehci_hcd 
and address 3
Nov 30 19:54:41 kefk kernel: usb 5-3: new device strings: Mfr=1, Product=2, 
SerialNumber=3
Nov 30 19:54:41 kefk kernel: usb 5-3: default language 0x0409
Nov 30 19:54:41 kefk kernel: usb 5-3: Product: Mass storage
Nov 30 19:54:41 kefk kernel: usb 5-3: Manufacturer: USB
Nov 30 19:54:41 kefk kernel: usb 5-3: SerialNumber: 142E19413C2FCA34
Nov 30 19:54:41 kefk kernel: usb 5-3: hotplug
Nov 30 19:54:41 kefk kernel: usb 5-3: adding 5-3:1.0 (config #1, interface 0)
Nov 30 19:54:41 kefk kernel: usb 5-3:1.0: hotplug
Nov 30 19:54:42 kefk kernel: Initializing USB Mass Storage driver...
Nov 30 19:54:42 kefk kernel: usb-storage 5-3:1.0: usb_probe_interface
Nov 30 19:54:42 kefk kernel: usb-storage 5-3:1.0: usb_probe_interface - got id
Nov 30 19:54:42 kefk kernel: scsi3 : SCSI emulation for USB Mass Storage 
devices
Nov 30 19:54:42 kefk kernel: usbcore: registered new driver usb-storage
Nov 30 19:54:42 kefk kernel: USB Mass Storage support registered.
Nov 30 19:54:42 kefk kernel: usb-storage: device found at 3
Nov 30 19:54:42 kefk kernel: usb-storage: waiting for device to settle before 
scanning
Nov 30 19:54:47 kefk kernel:   Vendor: 512MB     Model: USB2.0FlashDrive  Rev: 
2.00
Nov 30 19:54:47 kefk kernel:   Type:   Direct-Access                      ANSI 
SCSI revision: 02
Nov 30 19:54:47 kefk kernel: sdb: Unit Not Ready, sense:
Nov 30 19:54:47 kefk kernel: : Current: sense key=0x6
Nov 30 19:54:47 kefk kernel:     ASC=0x28 ASCQ=0x0
Nov 30 19:54:47 kefk kernel: sdb : READ CAPACITY failed.
Nov 30 19:54:47 kefk kernel: sdb : status=1, message=00, host=0, driver=08
Nov 30 19:54:47 kefk kernel: sd: Current: sense key=0x6
Nov 30 19:54:47 kefk kernel:     ASC=0x28 ASCQ=0x0
Nov 30 19:54:47 kefk kernel: sdb: test WP failed, assume Write Enabled
Nov 30 19:54:47 kefk kernel: sdb: assuming drive cache: write through
Nov 30 19:54:47 kefk kernel: sdb: Unit Not Ready, sense:
Nov 30 19:54:47 kefk kernel: : Current: sense key=0x6
Nov 30 19:54:47 kefk kernel:     ASC=0x28 ASCQ=0x0
Nov 30 19:54:47 kefk kernel: SCSI device sdb: 1024000 512-byte hdwr sectors 
(524 MB)
Nov 30 19:54:47 kefk kernel: sdb: Write Protect is off
Nov 30 19:54:47 kefk kernel: sdb: Mode Sense: 03 00 00 00
Nov 30 19:54:47 kefk kernel: sdb: assuming drive cache: write through
Nov 30 19:54:47 kefk kernel: SCSI device sdb: 1024000 512-byte hdwr sectors 
(524 MB)
Nov 30 19:54:47 kefk kernel: sdb: Write Protect is off
Nov 30 19:54:47 kefk kernel: sdb: Mode Sense: 03 00 00 00
Nov 30 19:54:47 kefk kernel: sdb: assuming drive cache: write through
Nov 30 19:54:47 kefk kernel:  sdb: sdb1
Nov 30 19:54:47 kefk kernel: Attached scsi removable disk sdb at scsi3, 
channel 0, id 0, lun 0
Nov 30 19:54:47 kefk kernel: Attached scsi generic sg4 at scsi3, channel 0, id 
0, lun 0,  type 0
Nov 30 19:54:47 kefk kernel: usb-storage: device scan complete
Nov 30 19:54:47 kefk scsi.agent[7714]: disk 
at /devices/pci0000:00/0000:00:1d.7/usb5/5-3/5-3:1.0/host3/target3:0:0/3:0:0:0


removing it:
Nov 30 19:55:44 kefk kernel: hub 5-0:1.0: state 5 ports 8 chg ff00 evt 0008
Nov 30 19:55:44 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001002 POWER sig=se0  CSC
Nov 30 19:55:44 kefk kernel: hub 5-0:1.0: port 3, status 0100, change 0001, 12 
Mb/s
Nov 30 19:55:44 kefk kernel: usb 5-3: USB disconnect, address 3
Nov 30 19:55:44 kefk kernel: usb 5-3: usb_disable_device nuking all URBs
Nov 30 19:55:44 kefk kernel: usb 5-3: unregistering interface 5-3:1.0
Nov 30 19:55:44 kefk kernel: usb 5-3:1.0: hotplug
Nov 30 19:55:44 kefk kernel: usb 5-3: unregistering device
Nov 30 19:55:44 kefk kernel: usb 5-3: hotplug
Nov 30 19:55:44 kefk kernel: hub 5-0:1.0: debounce: port 3: total 100ms stable 
100ms status 0x100


inserting the device with old_scheme_first not set:

Nov 30 20:00:25 kefk kernel: hub 5-0:1.0: state 5 ports 8 chg ff00 evt 0008
Nov 30 20:00:25 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001803 POWER sig=j  CSC CONNECT
Nov 30 20:00:25 kefk kernel: hub 5-0:1.0: port 3, status 0501, change 0001, 
480 Mb/s
Nov 30 20:00:25 kefk kernel: hub 5-0:1.0: debounce: port 3: total 100ms stable 
100ms status 0x501
Nov 30 20:00:25 kefk kernel: ehci_hcd 0000:00:1d.7: port 3 high speed
Nov 30 20:00:25 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001005 POWER sig=se0  PE CONNECT
Nov 30 20:00:25 kefk kernel: usb 5-3: new high speed USB device using ehci_hcd 
and address 3
Nov 30 20:00:25 kefk kernel: ehci_hcd 0000:00:1d.7: devpath 3 ep0in 3strikes
Nov 30 20:00:25 kefk kernel: ehci_hcd 0000:00:1d.7: port 3 full speed --> 
companion
Nov 30 20:00:25 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
003801 POWER OWNER sig=j  CONNECT
Nov 30 20:00:25 kefk kernel: uhci_hcd 0000:00:1d.1: wakeup_hc
Nov 30 20:00:26 kefk kernel: hub 2-0:1.0: state 5 ports 2 chg fffc evt 0002
Nov 30 20:00:26 kefk kernel: uhci_hcd 0000:00:1d.1: port 1 portsc 0083,00
Nov 30 20:00:26 kefk kernel: hub 2-0:1.0: port 1, status 0101, change 0001, 12 
Mb/s
Nov 30 20:00:26 kefk kernel: hub 2-0:1.0: debounce: port 1: total 100ms stable 
100ms status 0x101
Nov 30 20:00:26 kefk kernel: usb 2-1: new full speed USB device using uhci_hcd 
and address 2
Nov 30 20:00:26 kefk kernel: uhci_hcd 0000:00:1d.1: uhci_result_control: 
failed with status 440000
Nov 30 20:00:26 kefk kernel: [f7977240] link (379771b2) element (37a86040)
Nov 30 20:00:26 kefk kernel:   0: [f7a86040] link (37a86080) e0 Stalled 
CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=37144ba0)
Nov 30 20:00:26 kefk kernel:   1: [f7a86080] link (37a860c0) e3 SPD Active 
Length=0 MaxLen=3f DT1 EndPt=0 Dev=0, PID=69(IN) (buf=355ae500)
Nov 30 20:00:26 kefk kernel:   2: [f7a860c0] link (00000001) e3 IOC Active 
Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=e1(OUT) (buf=00000000)
Nov 30 20:00:26 kefk kernel:
Nov 30 20:00:26 kefk kernel: usb 2-1: device descriptor read/64, error -71
Nov 30 20:00:26 kefk kernel: uhci_hcd 0000:00:1d.1: uhci_result_control: 
failed with status 440000
Nov 30 20:00:26 kefk kernel: [f7977240] link (379771b2) element (37a86040)
Nov 30 20:00:26 kefk kernel:   0: [f7a86040] link (37a86080) e0 Stalled 
CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=36486e60)
Nov 30 20:00:26 kefk kernel:   1: [f7a86080] link (37a860c0) e3 SPD Active 
Length=0 MaxLen=3f DT1 EndPt=0 Dev=0, PID=69(IN) (buf=355aef00)
Nov 30 20:00:26 kefk kernel:   2: [f7a860c0] link (00000001) e3 IOC Active 
Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=e1(OUT) (buf=00000000)

Now, rebooting the box leaving the device inserted, with old_scheme_first=1 in 
modprobe.conf

Nov 30 20:03:40 kefk kernel: usb 4-0:1.0: hotplug
Nov 30 20:03:40 kefk kernel: hub 4-0:1.0: usb_probe_interface
Nov 30 20:03:40 kefk kernel: hub 4-0:1.0: usb_probe_interface - got id
Nov 30 20:03:40 kefk kernel: hub 4-0:1.0: USB hub found
Nov 30 20:03:40 kefk kernel: hub 4-0:1.0: 2 ports detected
Nov 30 20:03:40 kefk kernel: hub 4-0:1.0: standalone hub
Nov 30 20:03:40 kefk kernel: hub 4-0:1.0: no power switching (usb 1.0)
Nov 30 20:03:40 kefk kernel: hub 4-0:1.0: individual port over-current 
protection
Nov 30 20:03:40 kefk kernel: hub 4-0:1.0: power on to power good time: 2ms
Nov 30 20:03:40 kefk kernel: hub 4-0:1.0: local power source is good
Nov 30 20:03:40 kefk kernel: hub 2-0:1.0: debounce: port 1: total 100ms stable 
100ms status 0x101
Nov 30 20:03:40 kefk kernel: usb 2-1: new full speed USB device using uhci_hcd 
and address 2
Nov 30 20:03:40 kefk kernel: uhci_hcd 0000:00:1d.1: uhci_result_control: 
failed with status 440000
Nov 30 20:03:40 kefk kernel: [f7ab5240] link (37ab51b2) element (37ab4040)
Nov 30 20:03:40 kefk kernel:   0: [f7ab4040] link (37ab4080) e0 Stalled 
CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=37998f20)
Nov 30 20:03:40 kefk kernel:   1: [f7ab4080] link (00000001) e3 IOC Active 
Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=69(IN) (buf=00000000)
Nov 30 20:03:40 kefk kernel:
Nov 30 20:03:40 kefk kernel: uhci_hcd 0000:00:1d.1: uhci_result_control: 
failed with status 440000
Nov 30 20:03:40 kefk kernel: [f7ab5240] link (37ab51b2) element (37ab4040)
Nov 30 20:03:40 kefk kernel:   0: [f7ab4040] link (37ab4080) e0 Stalled 
CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=378ef180)
Nov 30 20:03:40 kefk kernel:   1: [f7ab4080] link (00000001) e3 IOC Active 
Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=69(IN) (buf=00000000)
Nov 30 20:03:40 kefk kernel:
Nov 30 20:03:40 kefk kernel: usb 2-1: device not accepting address 2, error 
-71
Nov 30 20:03:40 kefk kernel: usb 2-1: new full speed USB device using uhci_hcd 
and address 3
Nov 30 20:03:40 kefk kernel: uhci_hcd 0000:00:1d.1: uhci_result_control: 
failed with status 440000
Nov 30 20:03:40 kefk kernel: [f7ab5240] link (37ab51b2) element (37ab4040)
Nov 30 20:03:40 kefk kernel:   0: [f7ab4040] link (37ab4080) e0 Stalled 
CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=378ef180)
Nov 30 20:03:40 kefk kernel:   1: [f7ab4080] link (00000001) e3 IOC Active 
Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=69(IN) (buf=00000000)

After this, if I remove and plug again the device, all works just fine.







-- 
Fabio Coatti       http://members.ferrara.linux.it/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
