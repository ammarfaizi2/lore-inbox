Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267225AbSIRQDX>; Wed, 18 Sep 2002 12:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267201AbSIRQDX>; Wed, 18 Sep 2002 12:03:23 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:11660 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267174AbSIRQDT>;
	Wed, 18 Sep 2002 12:03:19 -0400
Date: Wed, 18 Sep 2002 09:08:02 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Brian Waite <waite@skycomputers.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFC] [PATCH] 0/7 2.5.35 SCSI multi-path
Message-ID: <20020918090802.B14245@eng2.beaverton.ibm.com>
References: <20020917154940.A18401@eng2.beaverton.ibm.com> <200209181117.59388.waite@skycomputers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200209181117.59388.waite@skycomputers.com>; from waite@skycomputers.com on Wed, Sep 18, 2002 at 11:17:59AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2002 at 11:17:59AM -0400, Brian Waite wrote:
> On Tuesday 17 September 2002 6:49 pm, Patrick Mansfield wrote:
> 
> >
> > Currently, multi-path support requires a SCSI device that supports one of
> > the SCSI INQUIRY device identification pages (page 0x80 or 0x83). Devices
> > not supporting one of these pages are treated as if they were separate
> > devices. Devices that do not give a unique serial number per LUN for these
> > commands might incorrectly be identified as multi-pathed.
> >
> I might be wrong about this, I have put most of this out of my mind, but I 
> belive that many tape drives and many cdrom drives do not return a serial 
> number. Does this mean two seperate tape drives will "appear" as a single 
> multi-port device, and worse could a cdrom and a tape device appear as the 
> same device or do you seperate between device types and then serial numbers.\
> 
>  I was working on exactly this problem in Linux a while ago and we were 
> running into serial number as uniqueness problems. What we chose to do was 
> create a "uniqueness" driver that would first use a customer derived 
> uniquness mecanism, IE "host:bus:channel:device is a single ported device of 
> type XXX". The fall though mechanism was to query the serial number and if it 
> was zero, or provided no serial number,  then it could not be a multiported 
> device. Of course for most scsi disks, the serial number was adequate to 
> provide multiported-ness.
> 
> PS. There is nothing funnier than putting 2 tape drives on a system that 
> decides it is a single multiported device, starting a tar, and pulling the 
> drive it was writing to, only to watch the tar continue merrily ontl the 
> second tape drive. Sure you get your backup, the restore is a real bugger tho 
> :)
> 
> Sorry to waste bandwidth if you've already discussed, I am probably a bit late 
> to the discussion.
> Thanks
> Brian

Devices without serial numbers are treated as if they had different serial
numbers, they show up as if there was no multi-path support.

Special handling is need for devices with unique identifiers outside of VPD
INQUIRY 0x80 and 0x83. This has to be handled on a per device basis, with
special scanning/probing code to get the unique identifier. Some devices
give the same value for page 0x80 no matter what LUN you connect to - these
are the biggest problem, and could show up as you described.

-- Patrick Mansfield

