Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271330AbTGQCFm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 22:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271332AbTGQCFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 22:05:42 -0400
Received: from pop016pub.verizon.net ([206.46.170.173]:37585 "EHLO
	pop016.verizon.net") by vger.kernel.org with ESMTP id S271330AbTGQCEs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 22:04:48 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: Greg KH <greg@kroah.com>
Subject: Re: [BK PATCH] USB update for 2.4.22-pre5
Date: Wed, 16 Jul 2003 22:19:36 -0400
User-Agent: KMail/1.5.1
References: <20030714170817.GA23458@kroah.com>
In-Reply-To: <20030714170817.GA23458@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Organization: None that appears to be detectable by casual observers
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307162219.36290.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at pop016.verizon.net from [151.205.62.27] at Wed, 16 Jul 2003 21:19:39 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg;
I took the list and all the Cc:'s off this as its pretty verbose.

And then Greg said to send it to the list, so here it is.

On Monday 14 July 2003 13:08, Greg KH wrote:
>Hi,
>
>Here are some USB bugfixes and updates against 2.4.22-pre5.  There
> are a number of resyncs here with drivers that are already in 2.5,
> and a new USB host controller driver was added.  Also, the
> unusual_devs.h list for usb-storage devices is now in sync with 2.5
> thanks to Alan Stern, which should make things a lot easier in the
> future.
>
>Please pull from:  bk://kernel.bkbits.net/gregkh/linux/marcelo-2.4

Greg, I think maybe this patchset is the one that killed what little
access I had to this usb camera.  It may be that the camera software
itself is user space stuff, but it appears this is broken by the usb 
patches and the camera software never has a chance to connect because
of it.  So I rebooted to -pre5 to verify I still had partial access,
but I didn't do a startx as that entails re-installs of the nvidia
drivers to do so, so the startx logs below were obtained from a
week ago's boot to -pre5.

Booted to 2.4.22-pre5, I get a message in dmesg that the device is 
not claimed by any driver, which seems to be brought in when I startx, 
at which point the system logs show a rather extensive verbosity as 
the buffers are initialized.

Booted to 2.4.22-pre6 as I am now, dmesg contains this:
----
Linux version 2.4.22-pre6 (root@coyote.coyote.den) (gcc version 3.2 
20020903 
(Red Hat Linux 8.0 3.2-7)) #2 Tue Jul 15 09:10:24 EDT 2003
[...]
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
host/usb-uhci.c: $Revision: 1.275 $ time 09:12:36 Jul 15 2003
host/usb-uhci.c: High bandwidth mode enabled
host/usb-uhci.c: USB UHCI at I/O 0xdc00, IRQ 11
host/usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
host/usb-uhci.c: USB UHCI at I/O 0xe000, IRQ 11
host/usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
host/usb-uhci.c: USB UHCI at I/O 0xe400, IRQ 11
host/usb-uhci.c: Detected 2 ports
ieee1394: Host added: Node[00:1023]  GUID[0050625600001065]  [Linux 
OHCI-1394]
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
host/usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
usb.c: registered new driver usbscanner
scanner.c: 0.4.13:USB Scanner Driver
usb.c: registered new driver usblp
printer.c: v0.11: USB Printer Device Class driver
usb.c: registered new driver serial
usbserial.c: USB Serial support registered for Generic
usbserial.c: USB Serial Driver core v1.4
usbserial.c: USB Serial support registered for PL-2303
pl2303.c: Prolific PL2303 USB to serial adaptor driver v0.9
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
[...]
hub.c: new USB device 00:11.2-1, assigned address 2
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on 
usb1:2.0
hub.c: new USB device 00:11.2-2, assigned address 3
printer.c: usblp0: USB Bidirectional printer dev 3 if 0 alt 0 proto 2 
vid 0x04B8 pid 0x0005
hub.c: new USB device 00:11.3-1, assigned address 2
hub.c: USB hub found
hub.c: 4 ports detected
hub.c: new USB device 00:11.3-2, assigned address 3
scanner.c: USB scanner device (0x04b8/0x010f) now attached to scanner0
hub.c: new USB device 00:11.3-1.1, assigned address 4
usbserial.c: PL-2303 converter detected
usbserial.c: PL-2303 converter now attached to ttyUSB0 (or usb/tts/0 
for devfs)
hub.c: new USB device 00:11.3-1.2, assigned address 5
printer.c: usblp1: USB Bidirectional printer dev 5 if 0 alt 0 proto 2 
vid 0x04B8 pid 0x0005
host/usb-uhci.c: ENXIO 80000280, flags 0, urb df814c40, burb df814bc0
hub.c: usb_hub_port_status (2) failed (err = -6)
hub.c: connect-debounce failed, port 3 disabled
host/usb-uhci.c: ENXIO 80000200, flags 0, urb df814c40, burb df814bc0
hub.c: cannot disable port 3 of hub 2 (err = -6)
host/usb-uhci.c: ENXIO 80000280, flags 0, urb df814c40, burb df814bc0
hub.c: usb_hub_port_status (2) failed (err = -6)
host/usb-uhci.c: ENXIO 80000280, flags 0, urb df814c40, burb df814bc0
hub.c: get_hub_status failed
host/usb-uhci.c: ENXIO 80000280, flags 0, urb df814c40, burb df814bc0
hub.c: usb_hub_port_status (2) failed (err = -6)
host/usb-uhci.c: ENXIO 80000280, flags 0, urb df814c40, burb df814bc0
hub.c: usb_hub_port_status (2) failed (err = -6)
host/usb-uhci.c: ENXIO 80000280, flags 0, urb df814c40, burb df814bc0
hub.c: usb_hub_port_status (2) failed (err = -6)
host/usb-uhci.c: ENXIO 80000280, flags 0, urb df814c40, burb df814bc0
hub.c: usb_hub_port_status (2) failed (err = -6)
host/usb-uhci.c: ENXIO 80000280, flags 0, urb df814c40, burb df814bc0
hub.c: get_hub_status failed
----

Then, just to make sure the configs weren't changed:
[root@coyote src]# cmp -l ./linux-2.4.22-pre5/.config ./linux/.config
[root@coyote src]#

So there was no difference in the .config's.  It was properly detected 
under 
-pre5 but not claimed by any driver.  Under -pre6 I get the above 
error messages 
in this same order location in /var/log/dmesg.

Under -pre5, /var/log/messages records this when startx is being done:
----
Jul 12 06:08:45 coyote kernel: QuickCam VC: (C) 2001 by De Marchi 
Daniele, <demarchidaniele@libero.it>
Jul 12 06:08:45 coyote kernel: QuickCam VC: v4l level driver version 
1.0.generic registered.
Jul 12 06:08:45 coyote kernel: QuickCam VC: Making a quickcam 
directory in /proc.
Jul 12 06:08:45 coyote kernel: QuickCam VC(USB): (C) 2001 by De Marchi 
Daniele, <demarchidaniele@libero.it>
Jul 12 06:08:45 coyote kernel: QuickCam VC(USB): lowlevel driver 
version 1.0.generic registered.
Jul 12 06:08:45 coyote kernel: qcamvc_usb: init
Jul 12 06:08:45 coyote kernel: usb.c: registered new driver Connectix 
QuickCam VC
Jul 12 06:08:45 coyote kernel: qcamvc usb probe
Jul 12 06:08:45 coyote kernel: qcamvc usb probe 1
Jul 12 06:08:45 coyote kernel: qcamvc usb probe 2
Jul 12 06:08:45 coyote kernel: qcamvc usb probe 3
Jul 12 06:08:45 coyote kernel: Quickcam VC: Creating a camera entry in 
proc quickcam.
Jul 12 06:08:45 coyote kernel: Quickcam dev struct in 
create_proc_qcamvc d9ea1000
Jul 12 06:08:45 coyote kernel: qcamvc dev struct in qcamvc_init_done 
d9ea1008
Jul 12 06:08:45 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:45 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d6c len 1 rlen 0
Jul 12 06:08:45 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:45 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d6c len 1 rlen 0
Jul 12 06:08:45 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:45 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d6c len 1 rlen 0
Jul 12 06:08:45 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:45 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d6c len 1 rlen 0
Jul 12 06:08:45 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:45 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d43 len 1 rlen 0
Jul 12 06:08:45 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:45 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d43 len 1 rlen 0
Jul 12 06:08:45 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:45 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d43 len 1 rlen 0
Jul 12 06:08:45 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:45 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d43 len 1 rlen 0
Jul 12 06:08:45 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:45 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d1c len 21 rlen 0
Jul 12 06:08:45 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:45 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d6c len 2 rlen 0
Jul 12 06:08:45 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:45 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d6c len 1 rlen 0
Jul 12 06:08:45 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:45 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d6c len 1 rlen 0
Jul 12 06:08:45 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:45 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d3100000 len 131072 rlen 0
Jul 12 06:08:45 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:45 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d6c len 1 rlen 0
Jul 12 06:08:45 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:45 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d6c len 1 rlen 0
Jul 12 06:08:45 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:45 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d6c len 1 rlen 0
Jul 12 06:08:45 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:45 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d6c len 1 rlen 0
Jul 12 06:08:45 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:45 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d6c len 1 rlen 0
Jul 12 06:08:45 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:45 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d6c len 1 rlen 0
Jul 12 06:08:45 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:45 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d1c len 21 rlen 0
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3b3a len 2 rlen 0
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d6c len 1 rlen 0
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d6c len 1 rlen 0
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d43 len 1 rlen 0
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d43 len 1 rlen 0
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d43 len 1 rlen 0
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d43 len 1 rlen 0
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d6c len 1 rlen 0
Jul 12 06:08:46 coyote kernel: Camera sucessfull registered
Jul 12 06:08:46 coyote kernel: qcamvc usb probe 4
Jul 12 06:08:46 coyote kernel: qcamvc usb probe 5
Jul 12 06:08:46 coyote kernel: qcamvc usb probe
Jul 12 06:08:46 coyote kernel: qcamvc usb probe 1
Jul 12 06:08:46 coyote kernel: qcamvc usb probe 2
Jul 12 06:08:46 coyote kernel: qcamvc usb probe 3
Jul 12 06:08:46 coyote kernel: Quickcam VC: Creating a camera entry in 
proc quickcam.
Jul 12 06:08:46 coyote kernel: Quickcam dev struct in 
create_proc_qcamvc dc39b000
Jul 12 06:08:46 coyote kernel: qcamvc dev struct in qcamvc_init_done 
dc39b008
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d6c len 1 rlen 0
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d6c len 1 rlen 0
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d6c len 1 rlen 0
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d6c len 1 rlen 0
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d6c len 1 rlen 0
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d43 len 1 rlen 0
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d43 len 1 rlen 0
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d43 len 1 rlen 0
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: QuickCam VC(USB): bulkwrite buJul 16 
07:19:47 coyote kernel: QuickCam VC: (C) 2001 by De Marchi Daniele, 
<demarchidaniele@libero.it>
Jul 16 07:19:47 coyote kernel: QuickCam VC: v4l level driver version 
1.0.generic registered.
Jul 16 07:19:47 coyote kernel: QuickCam VC: Making a quickcam 
directory in /proc.
Jul 16 07:19:47 coyote kernel: QuickCam VC(USB): (C) 2001 by De Marchi 
Daniele, <demarchidaniele@libero.it>
Jul 16 07:19:47 coyote kernel: QuickCam VC(USB): lowlevel driver 
version 1.0.generic registered.
Jul 16 07:19:47 coyote kernel: qcamvc_usb: init
Jul 16 07:19:47 coyote kernel: usb.c: registered new driver Connectix 
QuickCam VC
f d8fe3d43 len 1 rlen 0
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d1c len 21 rlen 0
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d6c len 2 rlen 0
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d6c len 1 rlen 0
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d6c len 1 rlen 0
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d3100000 len 131072 rlen 0
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d6c len 1 rlen 0
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d6c len 1 rlen 0
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d6c len 1 rlen 0
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d6c len 1 rlen 0
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d6c len 1 rlen 0
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d6c len 1 rlen 0
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d1c len 21 rlen 0
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3b3a len 2 rlen 0
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d6c len 1 rlen 0
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d6c len 1 rlen 0
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d43 len 1 rlen 0
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d43 len 1 rlen 0
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d43 len 1 rlen 0
Jul 12 06:08:46 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:46 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d43 len 1 rlen 0
Jul 12 06:08:47 coyote kernel: host/usb-uhci.c: uhci_submit_urb: 
pipesize for pipe c0008500 is zero
Jul 12 06:08:47 coyote kernel: QuickCam VC(USB): bulkwrite buf 
d8fe3d6c len 1 rlen 0
Jul 12 06:08:47 coyote kernel: Camera sucessfull registered
Jul 12 06:08:47 coyote kernel: qcamvc usb probe 4
Jul 12 06:08:47 coyote kernel: qcamvc usb probe 5
----

Excessively verbose ain't it? :)

whereas booted to pre6, this is all I get:
----
Jul 16 07:19:47 coyote kernel: QuickCam VC: (C) 2001 by De Marchi 
Daniele, <demarchidaniele@libero.it>
Jul 16 07:19:47 coyote kernel: QuickCam VC: v4l level driver version 
1.0.generic registered.
Jul 16 07:19:47 coyote kernel: QuickCam VC: Making a quickcam 
directory in /proc.
Jul 16 07:19:47 coyote kernel: QuickCam VC(USB): (C) 2001 by De Marchi 
Daniele, <demarchidaniele@libero.it>
Jul 16 07:19:47 coyote kernel: QuickCam VC(USB): lowlevel driver 
version 1.0.generic registered.
Jul 16 07:19:47 coyote kernel: qcamvc_usb: init
Jul 16 07:19:47 coyote kernel: usb.c: registered new driver Connectix 
QuickCam VC
----
As if the debugging has been turned off, but the display on the camera 
is also
blanked, it should be showing a 'PC' indicating its under the 
computers control.
It isn't of course, qcam-vc problems, but at least the usb is talking 
to it. 
At -pre6, its not.

So I repeat, something in that -pre5 to -pre6 patching of the usb 
stuffs broke this.
Possibly even this patchset below.

>The individual patches will be sent in follow up messages to this
> email to you and the linux-usb-devel mailing list.
>
>thanks,
>
>greg k-h
>
> MAINTAINERS                        |    4
> drivers/usb/ax8817x.c              |    4
> drivers/usb/host/Config.in         |    6
> drivers/usb/host/Makefile          |    1
> drivers/usb/host/sl811.c           | 2755
> ++++++++++++++++++++++++++++++++++++- drivers/usb/host/sl811.h     
>      |  177 ++
> drivers/usb/serial/ftdi_sio.c      |    3
> drivers/usb/serial/ftdi_sio.h      |    6
> drivers/usb/serial/ipaq.c          |    3
> drivers/usb/serial/ipaq.h          |    5
> drivers/usb/storage/initializers.h |    9
> drivers/usb/storage/protocol.c     |   54
> drivers/usb/storage/sddr09.c       |    4
> drivers/usb/storage/unusual_devs.h |  308 +---
> drivers/usb/storage/usb.c          |   12
> drivers/usb/storage/usb.h          |    2
> drivers/usb/usb.c                  |    2
> drivers/usb/usbnet.c               |  199 +-
> 18 files changed, 3265 insertions(+), 289 deletions(-)
>-----
>
><david:csse.uwa.edu.au>:
>  o USB: Adding DSS-20 SyncStation to ftdi_sio
>
><yinah:couragetech.com.cn>:
>  o USB: patch for sl811 usb host controller driver
>
>Alan Stern:
>  o USB: Implement US_FL_FIX_CAPACITY for 2.4
>  o USB: Updates for unusual_devs.h
>  o USB: Final reconciliation for unusual_devs.h in 2.4
>  o USB: Reconcile unusual_devs.h for 2.4 and 2.5
>
>David Brownell:
>  o USB: usbnet updates
>  o USB: usb_string(), don't use bogus ids
>
>David T. Hollis:
>  o USB: ax8817x.c - add Intellinet USB 2.0 Ethernet device ids
>
>Ganesh Varadarajan:
>  o USB: more ids for ipaq
>
>Greg Kroah-Hartman:
>  o USB: fix up previous sl811 patch
>  o USB: fix up my USB Bluetooth entry to help prevent confusion in
> the future
>
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.


