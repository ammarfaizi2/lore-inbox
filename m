Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267009AbSIRPP3>; Wed, 18 Sep 2002 11:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266964AbSIRPP2>; Wed, 18 Sep 2002 11:15:28 -0400
Received: from sky.skycomputers.com ([198.4.246.2]:42917 "HELO
	sky.skycomputers.com") by vger.kernel.org with SMTP
	id <S266963AbSIRPP0> convert rfc822-to-8bit; Wed, 18 Sep 2002 11:15:26 -0400
Content-Type: text/plain; charset=US-ASCII
From: Brian Waite <waite@skycomputers.com>
To: Patrick Mansfield <patmans@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [RFC] [PATCH] 0/7 2.5.35 SCSI multi-path
Date: Wed, 18 Sep 2002 11:17:59 -0400
User-Agent: KMail/1.4.1
References: <20020917154940.A18401@eng2.beaverton.ibm.com>
In-Reply-To: <20020917154940.A18401@eng2.beaverton.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209181117.59388.waite@skycomputers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 September 2002 6:49 pm, Patrick Mansfield wrote:

>
> Currently, multi-path support requires a SCSI device that supports one of
> the SCSI INQUIRY device identification pages (page 0x80 or 0x83). Devices
> not supporting one of these pages are treated as if they were separate
> devices. Devices that do not give a unique serial number per LUN for these
> commands might incorrectly be identified as multi-pathed.
>
I might be wrong about this, I have put most of this out of my mind, but I 
belive that many tape drives and many cdrom drives do not return a serial 
number. Does this mean two seperate tape drives will "appear" as a single 
multi-port device, and worse could a cdrom and a tape device appear as the 
same device or do you seperate between device types and then serial numbers.\

 I was working on exactly this problem in Linux a while ago and we were 
running into serial number as uniqueness problems. What we chose to do was 
create a "uniqueness" driver that would first use a customer derived 
uniquness mecanism, IE "host:bus:channel:device is a single ported device of 
type XXX". The fall though mechanism was to query the serial number and if it 
was zero, or provided no serial number,  then it could not be a multiported 
device. Of course for most scsi disks, the serial number was adequate to 
provide multiported-ness.

PS. There is nothing funnier than putting 2 tape drives on a system that 
decides it is a single multiported device, starting a tar, and pulling the 
drive it was writing to, only to watch the tar continue merrily ontl the 
second tape drive. Sure you get your backup, the restore is a real bugger tho 
:)

Sorry to waste bandwidth if you've already discussed, I am probably a bit late 
to the discussion.
Thanks
Brian





