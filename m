Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129727AbQKFVyp>; Mon, 6 Nov 2000 16:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130436AbQKFVyf>; Mon, 6 Nov 2000 16:54:35 -0500
Received: from devserv.devel.redhat.com ([207.175.42.156]:11014 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129727AbQKFVy2>; Mon, 6 Nov 2000 16:54:28 -0500
Date: Mon, 6 Nov 2000 16:54:20 -0500
From: Crutcher Dunnavant <crutcher@redhat.com>
To: Miles Lane <miles@speakeasy.org>
Cc: Matthew Dharm <mdharm@one-eyed-alien.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test10 -- Problem reading VFAT formatted ORB drive.
Message-ID: <20001106165420.I11672@devserv.devel.redhat.com>
In-Reply-To: <3A07C0BF.4060607@speakeasy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A07C0BF.4060607@speakeasy.org>; from miles@speakeasy.org on Tue, Nov 07, 2000 at 12:43:43AM -0800
Organization: Red Hat, Inc.
X-Department: OS Development
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

++ 07/11/00 00:43 -0800 - Miles Lane:
> Hi,
> 
> I have an ORB drive I am accessing using the usb-storage driver.
> I formatted the drive media last night using Windoze 98.  The media
> was formatted as though it had one large partition, which is weird
> because I had previously partitioned the drive under Linux 2.4.0-test10
> with several partitions.  The Windoze format utility did not notice
> those partitions and simply (I thought) wrote one large partition and
> formatted it as VFAT.  I have successfully written and read data on
> the media using two separate Windoze 98 machines.  When I mounted
> the drive under 2.4.0-test10 and then looked at the media with
> fdisk, here's what I see:
> 
> #> fdisk /dev/sda
> 
> Disk /dev/sda: 68 heads, 62 sectors, 1021 cylinders
> Units = cylinders of 4216 * 512 bytes
> 
>     Device Boot    Start       End    Blocks   Id  System
> /dev/sda1   ?    455397    584533 272218546+  20  Unknown
> Partition 1 has different physical/logical beginnings (non-Linux?):
>       phys=(356, 97, 46) logical=(455396, 22, 59)
> Partition 1 has different physical/logical endings:
>       phys=(357, 116, 40) logical=(584532, 18, 23)
> Partition 1 does not end on cylinder boundary:
>       phys=(357, 116, 40) should be (357, 67, 62)
> /dev/sda2   ?    315509    443350 269488144   6b  Unknown
> Partition 2 has different physical/logical beginnings (non-Linux?):
>       phys=(288, 110, 57) logical=(315508, 39, 57)
> Partition 2 has different physical/logical endings:
>       phys=(269, 101, 57) logical=(443349, 17, 52)
> Partition 2 does not end on cylinder boundary:
>       phys=(269, 101, 57) should be (269, 67, 62)
> /dev/sda3   ?    127844    459524 699181456   53  OnTrack DM6 Aux3
> Partition 3 has different physical/logical beginnings (non-Linux?):
>       phys=(345, 32, 19) logical=(127843, 53, 18)
> Partition 3 has different physical/logical endings:
>       phys=(324, 77, 19) logical=(459523, 53, 49)
> Partition 3 does not end on cylinder boundary:
>       phys=(324, 77, 19) should be (324, 67, 62)
> /dev/sda4   *    330795    330800     10668+  49  Unknown
> Partition 4 has different physical/logical beginnings (non-Linux?):
>       phys=(87, 1, 0) logical=(330794, 2, 36)
> Partition 4 has different physical/logical endings:
>       phys=(335, 78, 2) logical=(330799, 6, 44)
> Partition 4 does not end on cylinder boundary:
>       phys=(335, 78, 2) should be (335, 67, 62)
> 
> Partition table entries are not in disk order
> 
> 
> When I try to mount the drive, I get the common error:
> 
> mount -t vfat /dev/sda1 /mnt/orb1
> mount: wrong fs type, bad option, bad superblock on /dev/sda1,
>         or too many mounted file systems
> 
> What's going on here?  It seems to me that this is a bug in the
> Linux test10 filesystem support, since Windoze can read and write
> to this drive currently.  Our implementation should be compatible.
> 
> Cheers,
> 	Miles
> 
It would seem, to me, that if the partitions exist, but are conflicted,
yet windows sees them as a single drive; then windows is misbehaving,
and probably horked your partitions.

-- 
"I may be a monkey,     Crutcher Dunnavant 
 but I'm a monkey       <crutcher@redhat.com>
 with ambition!"        Red Hat OS Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
