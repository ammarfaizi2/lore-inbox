Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131004AbQKGEqE>; Mon, 6 Nov 2000 23:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131003AbQKGEp4>; Mon, 6 Nov 2000 23:45:56 -0500
Received: from hera.cwi.nl ([192.16.191.1]:58347 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S131004AbQKGEpw>;
	Mon, 6 Nov 2000 23:45:52 -0500
Date: Tue, 7 Nov 2000 05:45:50 +0100
From: Andries Brouwer <aeb@veritas.com>
To: Miles Lane <miles@speakeasy.org>
Cc: Matthew Dharm <mdharm@one-eyed-alien.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test10 -- Problem reading VFAT formatted ORB drive.
Message-ID: <20001107054550.A15541@veritas.com>
In-Reply-To: <3A07C0BF.4060607@speakeasy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A07C0BF.4060607@speakeasy.org>; from miles@speakeasy.org on Tue, Nov 07, 2000 at 12:43:43AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2000 at 12:43:43AM -0800, Miles Lane wrote:

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
...
> 
> What's going on here?  It seems to me that this is a bug in the
> Linux test10 filesystem support, since Windoze can read and write
> to this drive currently.  Our implementation should be compatible.

Well, clearly (i) you can read it, and (ii) you don't like the contents.
With these removable disks there are often two possibilities:
either format the thing as a large floppy (without partition table)
or format it as a disk.
Maybe you did the former. (In that case, "mount /dev/sda" might work.)

If you can't find out what happened, I wouldnt mind seeing
the first 64 sectors or so.

(By the way, the geometry is interesting: 1021/68/62.
My web page says:
  "The size is 2.2 GB. Castlewood recommends a C/H/S = 4273/16/63 geometry,
   which multiplies out to 4307184 sectors, that is, 2205278208 bytes.
   The default geometry with which the IDE version of the drive is shipped
   gives only 528 MB."
Now 68*62*1021*512=2203922432, almost full capacity. I wonder who
invented it.)

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
