Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132484AbRDNQ2q>; Sat, 14 Apr 2001 12:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132220AbRDNQ2g>; Sat, 14 Apr 2001 12:28:36 -0400
Received: from gear.torque.net ([204.138.244.1]:25098 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S132483AbRDNQ2W>;
	Sat, 14 Apr 2001 12:28:22 -0400
Message-ID: <3AD87A7D.BB66C5DA@torque.net>
Date: Sat, 14 Apr 2001 12:27:41 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac4 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Matt Domsch <Matt_Domsch@Dell.com>
Subject: Re: [RFC][PATCH] adding PCI bus information to SCSI layer
In-Reply-To: <E14oBtM-0003fN-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Also ISA adapters are not the only non-PCI adapters,
> > there are the growing band of pseudo adapters that
> > may or may not have a PCI bus at the bottom of some
> > other protocol stack.
> 
> An ioctl might be better. We already have an ioctl for querying the lun
> information for a disk. We could also return the bus information for its
> controller(s) [remember multipathing]

Both 'cat /proc/scsi/scsi' and ioctls used on
fds belonging to the existing upper level drivers
(e.g. sd and sr) have a problem as far as getting
HBA environment information: there needs to be at
least one SCSI device (target) connected to the
HBA. With no SCSI devices connected, there is no 
fd to do an ioctl on. [The same problem arises
if a device is there but marked offline, has an
exclusive lock on it, ...]

Perhaps Matt could look at the approach I have taken
with the scsimon experimental upper level driver.
Scsimon was originally designed to get scsi based
information to the /sbin/hotplug mechanism. It also
supplies ioctls to probe HBAs as well as SCSI devices.
More information about it can be found at:
  http://www.torque.net/scsi/scsimon.html

It should not be difficult to add HBA PCI bus information
to scsimon (after the Scsi_Host structure is expanded to
hold that information).

Doug Gilbert
