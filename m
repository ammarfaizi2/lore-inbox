Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261979AbUKCXz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbUKCXz4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 18:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbUKCXxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 18:53:32 -0500
Received: from mid-1.inet.it ([213.92.5.18]:46507 "EHLO mid-1.inet.it")
	by vger.kernel.org with ESMTP id S261979AbUKCXuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 18:50:06 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Test patch for ub and double registration
Date: Thu, 4 Nov 2004 00:49:59 +0100
User-Agent: KMail/1.7.1
References: <20041101164432.3fa72b81@lembas.zaitcev.lan> <200411032143.02197.cova@ferrara.linux.it> <20041103125627.0224f431@lembas.zaitcev.lan>
In-Reply-To: <20041103125627.0224f431@lembas.zaitcev.lan>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200411040049.59659.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 21:56, mercoledì 03 novembre 2004, hai scritto:

> > Nov  3 21:36:26 kefk kernel:   2: [f7a6b0c0] link (00000001) e3 IOC
> > Active Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=e1(OUT) (buf=00000000)
> > Nov  3 21:36:26 kefk kernel:
> > Nov  3 21:36:26 kefk kernel: usb 2-1: device descriptor read/64, error
> > -71
>
> So, this fails even before getting to ub. I don't know how to help this,
> but perhaps Greg has any ideas. I'm afraid I would just reboot if weird
> things like this start happening. I hope your device hasn't just died
> suddenly...

well, the flash key is working just fine (tried with mdk 10.1 cooker, kernel 
2.6.8.1-12mdk); i've rebooted my box and the behaviour was exactly the same, 
but after some minutes, it worked (more or less).
Details:
First insertion after reboot (tried also by changing usb port, no differences)
=============
Nov  4 00:28:16 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001803 POWER sig=j  CSC CONNECT
Nov  4 00:28:16 kefk kernel: hub 5-0:1.0: port 3, status 0501, change 0001, 
480 Mb/s
Nov  4 00:28:16 kefk kernel: hub 5-0:1.0: debounce: port 3: total 100ms stable 
100ms status 0x501
Nov  4 00:28:16 kefk kernel: ehci_hcd 0000:00:1d.7: port 3 high speed
Nov  4 00:28:16 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001005 POWER sig=se0  PE CONNECT
Nov  4 00:28:16 kefk kernel: usb 5-3: new high speed USB device using ehci_hcd 
and address 4
Nov  4 00:28:16 kefk kernel: ehci_hcd 0000:00:1d.7: devpath 3 ep0in 3strikes
Nov  4 00:28:16 kefk kernel: ehci_hcd 0000:00:1d.7: port 3 full speed --> 
companion
Nov  4 00:28:16 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
003801 POWER OWNER sig=j  CONNECT
Nov  4 00:28:16 kefk kernel: uhci_hcd 0000:00:1d.1: wakeup_hc
Nov  4 00:28:16 kefk kernel: uhci_hcd 0000:00:1d.1: port 1 portsc 0093,00
Nov  4 00:28:16 kefk kernel: hub 2-0:1.0: port 1, status 0101, change 0001, 12 
Mb/s
Nov  4 00:28:17 kefk kernel: hub 2-0:1.0: debounce: port 1: total 100ms stable 
100ms status 0x101
Nov  4 00:28:17 kefk kernel: usb 2-1: new full speed USB device using uhci_hcd 
and address 2
Nov  4 00:28:17 kefk kernel: uhci_hcd 0000:00:1d.1: uhci_result_control: 
failed with status 440000
Nov  4 00:28:17 kefk kernel: [f79ab240] link (379ab1b2) element (3791e040)
Nov  4 00:28:17 kefk kernel:   0: [f791e040] link (3791e080) e0 Stalled 
CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=37cf9c00)
Nov  4 00:28:17 kefk kernel:   1: [f791e080] link (3791e0c0) e3 SPD Active 
Length=0 MaxLen=3f DT1 EndPt=0 Dev=0, PID=69(IN) (buf=347e2300)
Nov  4 00:28:17 kefk kernel:   2: [f791e0c0] link (00000001) e3 IOC Active 
Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=e1(OUT) (buf=00000000)
==================

Here i don't understand why i get this:
usb 5-3: new high speed USB device using ehci_hcd and address 4
and few lines below this:
usb 2-1: new full speed USB device using uhci_hcd and address 2
when I've inserted only one device :)

After this, I've removed an plugged again the key, with a different result:

==============
ov  4 00:37:16 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001803 POWER sig=j  CSC CONNECT
Nov  4 00:37:16 kefk kernel: hub 5-0:1.0: port 3, status 0501, change 0001, 
480 Mb/s
Nov  4 00:37:16 kefk kernel: hub 5-0:1.0: debounce: port 3: total 100ms stable 
100ms status 0x501
Nov  4 00:37:16 kefk kernel: ehci_hcd 0000:00:1d.7: port 3 high speed
Nov  4 00:37:16 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001005 POWER sig=se0  PE CONNECT
Nov  4 00:37:16 kefk kernel: usb 5-3: new high speed USB device using ehci_hcd 
and address 7
Nov  4 00:37:16 kefk kernel: ehci_hcd 0000:00:1d.7: port 3 high speed
Nov  4 00:37:16 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001005 POWER sig=se0  PE CONNECT
Nov  4 00:37:16 kefk kernel: usb 5-3: ep0 maxpacket = 64
Nov  4 00:37:16 kefk kernel: usb 5-3: new device strings: Mfr=1, Product=2, 
SerialNumber=3
Nov  4 00:37:16 kefk kernel: usb 5-3: default language 0x0409
Nov  4 00:37:16 kefk kernel: usb 5-3: Product: Mass storage
Nov  4 00:37:16 kefk kernel: usb 5-3: Manufacturer: USB
Nov  4 00:37:16 kefk kernel: usb 5-3: SerialNumber: 142E19413C2FCA34
Nov  4 00:37:16 kefk kernel: usb 5-3: hotplug
Nov  4 00:37:16 kefk kernel: usb 5-3: adding 5-3:1.0 (config #1, interface 0)
Nov  4 00:37:16 kefk kernel: usb 5-3:1.0: hotplug
Nov  4 00:37:16 kefk kernel: ub: sizeof ub_scsi_cmd 64 ub_dev 2504
Nov  4 00:37:16 kefk kernel: ub 5-3:1.0: usb_probe_interface
Nov  4 00:37:16 kefk kernel: ub 5-3:1.0: usb_probe_interface - got id
Nov  4 00:37:16 kefk kernel: uba: device 7 capacity nsec 50 bsize 512
Nov  4 00:37:16 kefk kernel: usbcore: registered new driver ub
===============

Note, no usb 2-1 related activity, and  I've been able to see this:

[root@kefk root]# find /sys -name diag
/sys/devices/pci0000:00/0000:00:1d.7/usb5/5-3/5-3:1.0/diag
find: /sys/devices/system/timer: No such file or directory

(/sys/devices/system/timer is a completely diffent story, it seems that timer 
is prepended with non-printable character)

I've tried several times to plug the flash key on a different system, no 
problems at all, and all usb ports of my box are working fine, tested with 
printer, scanner, bluetooth dongles, and so on..




-- 
Fabio Coatti       http://members.ferrara.linux.it/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
