Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262018AbVD1FdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbVD1FdH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 01:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbVD1FdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 01:33:07 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:17504 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262018AbVD1Fc4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 01:32:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g9rIY/lV67fQepDl+9qkPjpKc7vtER05gg3/rj6fuP+u+yTufxmy2ufyA3h66HlLCpJm7r2IkCyI2tWS9BYsUYrcDp3QeYs9OpIXGGZjnRtK5dlQ9vYoZl9HTL+x64Y5IBwPEsTrDeC3nd9sMoYk0Mdvr80Mw38LOBD+kZIC+Ro=
Message-ID: <d4757e60050427223212fd7105@mail.gmail.com>
Date: Thu, 28 Apr 2005 01:32:56 -0400
From: Joe <joecool1029@gmail.com>
Reply-To: Joe <joecool1029@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: Device Node Issues with recent mm's and udev
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20050428052335.GA10772@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <d4757e6005042716523af66bae@mail.gmail.com>
	 <20050428041428.GB9723@kroah.com>
	 <d4757e6005042721577ba48cc@mail.gmail.com>
	 <20050428050346.GB10182@kroah.com>
	 <d4757e6005042722207e2b926@mail.gmail.com>
	 <20050428052335.GA10772@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/05, Greg KH <greg@kroah.com> wrote:
> Again, usb or firewire?
> And if usb, are you _sure_ there are no kernel log messages?  There
> should be something there...

Ok here we go.  This is what dmesg outputs during the time I copy it over.

scsi5 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 6
usb-storage: waiting for device to settle before scanning
ACPI: No ACPI bus support for 1-4:1.0
  Vendor: Apple     Model: iPod              Rev: 1.62
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdb: 39063023 512-byte hdwr sectors (20000 MB)
sdb: Write Protect is off
sdb: Mode Sense: 64 00 00 08
sdb: assuming drive cache: write through
SCSI device sdb: 39063023 512-byte hdwr sectors (20000 MB)
sdb: Write Protect is off
sdb: Mode Sense: 64 00 00 08
sdb: assuming drive cache: write through
 sdb: sdb2 sdb3
Attached scsi removable disk sdb at scsi5, channel 0, id 0, lun 0
ACPI: No ACPI bus support for 5:0:0:0
Attached scsi generic sg1 at scsi5, channel 0, id 0, lun 0,  type 0
usb-storage: device scan complete

I find it odd sdb1 disappears (as this was where I was attempting to
copy the image during this time)

Also from /var/log/messages:

Apr 28 01:26:20 redefine usb 1-4: new high speed USB device using
ehci_hcd and address 6
Apr 28 01:26:20 redefine ACPI: No ACPI bus support for 1-4
Apr 28 01:26:20 redefine scsi5 : SCSI emulation for USB Mass Storage devices
Apr 28 01:26:20 redefine usb-storage: device found at 6
Apr 28 01:26:20 redefine usb-storage: waiting for device to settle
before scanning
Apr 28 01:26:20 redefine ACPI: No ACPI bus support for 1-4:1.0
Apr 28 01:26:25 redefine Vendor: Apple     Model: iPod              Rev: 1.62
Apr 28 01:26:25 redefine Type:   Direct-Access                     
ANSI SCSI revision: 00
Apr 28 01:26:25 redefine SCSI device sdb: 39063023 512-byte hdwr
sectors (20000 MB)
Apr 28 01:26:25 redefine sdb: Write Protect is off
Apr 28 01:26:25 redefine sdb: Mode Sense: 64 00 00 08
Apr 28 01:26:25 redefine sdb: assuming drive cache: write through
Apr 28 01:26:25 redefine SCSI device sdb: 39063023 512-byte hdwr
sectors (20000 MB)
Apr 28 01:26:25 redefine sdb: Write Protect is off
Apr 28 01:26:25 redefine sdb: Mode Sense: 64 00 00 08
Apr 28 01:26:25 redefine sdb: assuming drive cache: write through
Apr 28 01:26:25 redefine sdb: sdb2 sdb3
Apr 28 01:26:25 redefine Attached scsi removable disk sdb at scsi5,
channel 0, id 0, lun 0
Apr 28 01:26:25 redefine ACPI: No ACPI bus support for 5:0:0:0
Apr 28 01:26:25 redefine Attached scsi generic sg1 at scsi5, channel
0, id 0, lun 0,  type 0
Apr 28 01:26:25 redefine usb-storage: device scan complete
Apr 28 01:26:25 redefine scsi.agent[17573]: disk at
/devices/pci0000:00/0000:00:1e.0/0000:02:09.2/usb1/1-4/1-4:1.0/host5/target5:0:0/5:0:0:0

Hope This Can Help, 

Joe
