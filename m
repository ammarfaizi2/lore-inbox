Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262147AbVD1GFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbVD1GFl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 02:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbVD1GFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 02:05:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:37088 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262147AbVD1GF3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 02:05:29 -0400
Date: Wed, 27 Apr 2005 23:05:08 -0700
From: Greg KH <greg@kroah.com>
To: Joe <joecool1029@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Device Node Issues with recent mm's and udev
Message-ID: <20050428060508.GA11389@kroah.com>
References: <d4757e6005042716523af66bae@mail.gmail.com> <20050428041428.GB9723@kroah.com> <d4757e6005042721577ba48cc@mail.gmail.com> <20050428050346.GB10182@kroah.com> <d4757e6005042722207e2b926@mail.gmail.com> <20050428052335.GA10772@kroah.com> <d4757e60050427223212fd7105@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4757e60050427223212fd7105@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 01:32:56AM -0400, Joe wrote:
> On 4/28/05, Greg KH <greg@kroah.com> wrote:
> > Again, usb or firewire?
> > And if usb, are you _sure_ there are no kernel log messages?  There
> > should be something there...
> 
> Ok here we go.  This is what dmesg outputs during the time I copy it over.
> 
> scsi5 : SCSI emulation for USB Mass Storage devices
> usb-storage: device found at 6
> usb-storage: waiting for device to settle before scanning
> ACPI: No ACPI bus support for 1-4:1.0
>   Vendor: Apple     Model: iPod              Rev: 1.62
>   Type:   Direct-Access                      ANSI SCSI revision: 00
> SCSI device sdb: 39063023 512-byte hdwr sectors (20000 MB)
> sdb: Write Protect is off
> sdb: Mode Sense: 64 00 00 08
> sdb: assuming drive cache: write through
> SCSI device sdb: 39063023 512-byte hdwr sectors (20000 MB)
> sdb: Write Protect is off
> sdb: Mode Sense: 64 00 00 08
> sdb: assuming drive cache: write through
>  sdb: sdb2 sdb3
> Attached scsi removable disk sdb at scsi5, channel 0, id 0, lun 0
> ACPI: No ACPI bus support for 5:0:0:0
> Attached scsi generic sg1 at scsi5, channel 0, id 0, lun 0,  type 0
> usb-storage: device scan complete
> 
> I find it odd sdb1 disappears (as this was where I was attempting to
> copy the image during this time)

I don't see a "sdb1" partition in the message from the scsi core.  Does
	ls /sys/block/sdb
show a sdb1 partition?

If not, nothing that udev can do, must be a scsi issue :)

> Also from /var/log/messages:
> 
> Apr 28 01:26:20 redefine usb 1-4: new high speed USB device using
> ehci_hcd and address 6
> Apr 28 01:26:20 redefine ACPI: No ACPI bus support for 1-4
> Apr 28 01:26:20 redefine scsi5 : SCSI emulation for USB Mass Storage devices
> Apr 28 01:26:20 redefine usb-storage: device found at 6
> Apr 28 01:26:20 redefine usb-storage: waiting for device to settle
> before scanning
> Apr 28 01:26:20 redefine ACPI: No ACPI bus support for 1-4:1.0
> Apr 28 01:26:25 redefine Vendor: Apple     Model: iPod              Rev: 1.62
> Apr 28 01:26:25 redefine Type:   Direct-Access                     
> ANSI SCSI revision: 00
> Apr 28 01:26:25 redefine SCSI device sdb: 39063023 512-byte hdwr
> sectors (20000 MB)
> Apr 28 01:26:25 redefine sdb: Write Protect is off
> Apr 28 01:26:25 redefine sdb: Mode Sense: 64 00 00 08
> Apr 28 01:26:25 redefine sdb: assuming drive cache: write through
> Apr 28 01:26:25 redefine SCSI device sdb: 39063023 512-byte hdwr
> sectors (20000 MB)
> Apr 28 01:26:25 redefine sdb: Write Protect is off
> Apr 28 01:26:25 redefine sdb: Mode Sense: 64 00 00 08
> Apr 28 01:26:25 redefine sdb: assuming drive cache: write through
> Apr 28 01:26:25 redefine sdb: sdb2 sdb3

Again, no sdb1.

thanks,

greg k-h
