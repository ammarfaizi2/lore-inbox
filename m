Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262210AbUKVQpe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbUKVQpe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 11:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbUKVQow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 11:44:52 -0500
Received: from sd291.sivit.org ([194.146.225.122]:43742 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262189AbUKVQaD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 11:30:03 -0500
Date: Mon, 22 Nov 2004 17:30:35 +0100
From: Stelian Pop <stelian@popies.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, greg@kroah.com
Subject: Re: [PATCH] usb-storage should enable scsi disk in Kconfig
Message-ID: <20041122163034.GA3410@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	"Randy.Dunlap" <rddunlap@osdl.org>,
	Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
	Christoph Hellwig <hch@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, greg@kroah.com
References: <20041119193350.GE2700@deep-space-9.dsnet> <20041119195736.GA8466@infradead.org> <20041119213942.GG2700@deep-space-9.dsnet> <20041119230820.GB32455@one-eyed-alien.net> <419FD192.1040604@osdl.org> <20041122103520.GA3550@crusoe.alcove-fr> <41A20D5A.6040004@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A20D5A.6040004@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 08:01:30AM -0800, Randy.Dunlap wrote:

> >>>>Maybe we should add, just below the 'USB storage' Kconfig option another
> >>>>one, let's say 'SCSI disk based USB storage support', which 
> >>>>documentation
> >>>>would talk about 'usb keys, memory stick readers, USB floppy drives 
> >>>>etc',
> >>>>which should just be a dummy option selecting  BLK_DEV_SD ?
> >
> >
> >>Until 'suggests' is available, does this help any?
> >>It's tough getting people to read Help messages though.
> >>
> >>Add comment/NOTE that USB_STORAGE probably needs BLK_DEV_SD also.
> >>Add a few device types to help text and reformat it.
> >
> >
> >Isn't my above suggestion even better ? A separate config option
> >is much more visible IMHO...
> 
> Sounds good, as long as we don't mind the same option being
> settable in multiple places.  Did you submit a patch?

Nope, I was waiting for the discussion to settle.

But here it is:

===== drivers/usb/storage/Kconfig 1.9 vs edited =====
--- 1.9/drivers/usb/storage/Kconfig	2004-06-13 17:24:10 +02:00
+++ edited/drivers/usb/storage/Kconfig	2004-11-22 17:27:43 +01:00
@@ -45,6 +45,16 @@
 	  If you say N here, the kernel will assume that all disk-like USB
 	  devices are write-enabled.
 
+config USB_STORAGE_SD
+	bool "USB Mass Storage SCSI-like disks"
+	depends on USB_STORAGE
+	select BLK_DEV_SD
+	help
+	  Say Y here if you want to enable support for SCSI-like USB
+	  connected disks. These are the most used USB Mass Storage
+	  devices, and include USB keys, USB floppy drives, most USB
+	  flash memory readers, some USB photo cameras etc.
+
 config USB_STORAGE_DATAFAB
 	bool "Datafab Compact Flash Reader support (EXPERIMENTAL)"
 	depends on USB_STORAGE && EXPERIMENTAL
-- 
Stelian Pop <stelian@popies.net>    
