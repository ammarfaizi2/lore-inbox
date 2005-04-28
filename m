Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262202AbVD1SJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbVD1SJi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 14:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262201AbVD1SJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 14:09:38 -0400
Received: from fire.osdl.org ([65.172.181.4]:9663 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262203AbVD1SJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 14:09:28 -0400
Date: Thu, 28 Apr 2005 11:06:14 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Mark Rosenstand <mark@ossholes.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Extremely poor umass transfer rates
Message-Id: <20050428110614.00a0c193.rddunlap@osdl.org>
In-Reply-To: <1114710941.8326.13.camel@mjollnir.bootless.dk>
References: <1114704142.8410.4.camel@mjollnir.bootless.dk>
	<20050428165915.GG30768@redhat.com>
	<1114710941.8326.13.camel@mjollnir.bootless.dk>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: SvC&!/v_Hr`MvpQ*|}uez16KH[#EmO2Tn~(r-y+&Jb}?Zhn}c:Eee&zq`cMb_[5`tT(22ms
 (.P84,bq_GBdk@Kgplnrbj;Y`9IF`Q4;Iys|#3\?*[:ixU(UR.7qJT665DxUP%K}kC0j5,UI+"y-Sw
 mn?l6JGvyI^f~2sSJ8vd7s[/CDY]apD`a;s1Wf)K[,.|-yOLmBl0<axLBACB5o^ZAs#&m?e""k/2vP
 E#eG?=1oJ6}suhI%5o#svQ(LvGa=r
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2005 19:55:40 +0200 Mark Rosenstand wrote:

| On Thu, 2005-04-28 at 12:59 -0400, Dave Jones wrote:
| > On Thu, Apr 28, 2005 at 06:02:22PM +0200, Mark Rosenstand wrote:
| >  > I get transfer rates at around 30 kB/s to USB mass storage devices. It
| >  > applies to both my keyring and my mp3 player. Both are running vfat.
| >  > 
| >  > I'm running 2.6.12-rc3 for amd64 with patches for inotify and skge. The
| >  > motherboard is an ASUS K8V-X (VIA K8T800).
| >  > 
| >  > It worked alright earlier (2.6.10 or 2.6.11, I'll test later if
| >  > necessary.)
| >  > 
| >  > Also, if I transfer more than one file at a time the music tracks start
| >  > overlapping on my mp3 player.
| > 
| > Are you running it on a USB 2.0 capable interface ?

with the EHCI host controller driver loaded?

| I believe so. How do I verify it?

(see below)
and post /proc/bus/usb/devices (contents)

| I've tried to move it to the other on-board hub but without results.
| 
| > Is your mp3 player USB2.0 capable ?
| 
| I'm not sure. But I do know that it used to be *much* faster than this.
| My keyring is USB 2.0 capable and that's slow as well.
| 
| > USB1.1 is painfully slow for storage.
| 
| Yeah, but I don't think it should be 30 kB/s.
| 
| Some more details:
| 
| 
| The line that 'hald' puts in fstab looks like this:
| 
| 	/dev/sdb /media/usbdisk vfat \
| 		user,exec,noauto,utf8,noatime,sync,managed 0 0
| 
| 
| The relevant parts of my .config:
| 
| 	#
| 	# Miscellaneous USB options
| 	#
| 	CONFIG_USB_DEVICEFS=y
| 	# CONFIG_USB_BANDWIDTH is not set
| 	# CONFIG_USB_DYNAMIC_MINORS is not set
| 	# CONFIG_USB_SUSPEND is not set
| 	# CONFIG_USB_OTG is not set
| 
| 	#
| 	# USB Host Controller Drivers
| 	#
| 	CONFIG_USB_EHCI_HCD=y
OK, EHCI answer is Yes.

| 	# CONFIG_USB_EHCI_SPLIT_ISO is not set
| 	# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
| 	# CONFIG_USB_OHCI_HCD is not set
| 	CONFIG_USB_UHCI_HCD=y
| 	# CONFIG_USB_SL811_HCD is not set
| 
| 	[...]
| 
| 	CONFIG_USB_STORAGE=m
| 
| 
| What my dmesg tells me when I attach the device:
| 
| 	usb 2-1: new full speed USB device using uhci_hcd and address 6

"full speed" is USB 1.x (12 Mbps, not high-speed 480 Mbps),
so the device is reporting itself as less than high-speed
or the USB descriptor parsing is missing it somehow (but it
works for a few hundred other devices).

| 	scsi6 : SCSI emulation for USB Mass Storage devices
| 	usb-storage: device found at 6
| 	usb-storage: waiting for device to settle before scanning
| 	  Vendor: iriver    Model: MassStorage Disc  Rev:
| 	  Type:   Direct-Access                      ANSI SCSI revision: 00
| 	SCSI device sdb: 249857 512-byte hdwr sectors (128 MB)
| 	sdb: Write Protect is off
| 	sdb: Mode Sense: 45 00 00 08
| 	sdb: assuming drive cache: write through
| 	SCSI device sdb: 249857 512-byte hdwr sectors (128 MB)
| 	sdb: Write Protect is off
| 	sdb: Mode Sense: 45 00 00 08
| 	sdb: assuming drive cache: write through
| 	sdb:
| 	Attached scsi removable disk sdb at scsi6, channel 0, id 0, lun 0
| 	usb-storage: device scan complete
| 
| Thanks for the advices so far :-)


---
~Randy
