Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262195AbVD1Rzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbVD1Rzg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 13:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbVD1Rzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 13:55:36 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:65305 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S262195AbVD1RzU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 13:55:20 -0400
Subject: Re: Extremely poor umass transfer rates
From: Mark Rosenstand <mark@ossholes.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20050428165915.GG30768@redhat.com>
References: <1114704142.8410.4.camel@mjollnir.bootless.dk>
	 <20050428165915.GG30768@redhat.com>
Content-Type: text/plain
Date: Thu, 28 Apr 2005 19:55:40 +0200
Message-Id: <1114710941.8326.13.camel@mjollnir.bootless.dk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-28 at 12:59 -0400, Dave Jones wrote:
> On Thu, Apr 28, 2005 at 06:02:22PM +0200, Mark Rosenstand wrote:
>  > I get transfer rates at around 30 kB/s to USB mass storage devices. It
>  > applies to both my keyring and my mp3 player. Both are running vfat.
>  > 
>  > I'm running 2.6.12-rc3 for amd64 with patches for inotify and skge. The
>  > motherboard is an ASUS K8V-X (VIA K8T800).
>  > 
>  > It worked alright earlier (2.6.10 or 2.6.11, I'll test later if
>  > necessary.)
>  > 
>  > Also, if I transfer more than one file at a time the music tracks start
>  > overlapping on my mp3 player.
> 
> Are you running it on a USB 2.0 capable interface ?

I believe so. How do I verify it?

I've tried to move it to the other on-board hub but without results.

> Is your mp3 player USB2.0 capable ?

I'm not sure. But I do know that it used to be *much* faster than this.
My keyring is USB 2.0 capable and that's slow as well.

> USB1.1 is painfully slow for storage.

Yeah, but I don't think it should be 30 kB/s.

Some more details:


The line that 'hald' puts in fstab looks like this:

	/dev/sdb /media/usbdisk vfat \
		user,exec,noauto,utf8,noatime,sync,managed 0 0


The relevant parts of my .config:

	#
	# Miscellaneous USB options
	#
	CONFIG_USB_DEVICEFS=y
	# CONFIG_USB_BANDWIDTH is not set
	# CONFIG_USB_DYNAMIC_MINORS is not set
	# CONFIG_USB_SUSPEND is not set
	# CONFIG_USB_OTG is not set

	#
	# USB Host Controller Drivers
	#
	CONFIG_USB_EHCI_HCD=y
	# CONFIG_USB_EHCI_SPLIT_ISO is not set
	# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
	# CONFIG_USB_OHCI_HCD is not set
	CONFIG_USB_UHCI_HCD=y
	# CONFIG_USB_SL811_HCD is not set

	[...]

	CONFIG_USB_STORAGE=m


What my dmesg tells me when I attach the device:

	usb 2-1: new full speed USB device using uhci_hcd and address 6
	scsi6 : SCSI emulation for USB Mass Storage devices
	usb-storage: device found at 6
	usb-storage: waiting for device to settle before scanning
	  Vendor: iriver    Model: MassStorage Disc  Rev:
	  Type:   Direct-Access                      ANSI SCSI revision: 00
	SCSI device sdb: 249857 512-byte hdwr sectors (128 MB)
	sdb: Write Protect is off
	sdb: Mode Sense: 45 00 00 08
	sdb: assuming drive cache: write through
	SCSI device sdb: 249857 512-byte hdwr sectors (128 MB)
	sdb: Write Protect is off
	sdb: Mode Sense: 45 00 00 08
	sdb: assuming drive cache: write through
	sdb:
	Attached scsi removable disk sdb at scsi6, channel 0, id 0, lun 0
	usb-storage: device scan complete

Thanks for the advices so far :-)

-- 
  .-.    Mark Rosenstand        (-.)
  oo|                           cc )
 /`'\    (+45) 255 31337      3-n-(
(\_;/)   mark@geekworld.org    _(|/`->

