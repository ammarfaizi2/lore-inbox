Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129312AbQKFUgr>; Mon, 6 Nov 2000 15:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129468AbQKFUgh>; Mon, 6 Nov 2000 15:36:37 -0500
Received: from lolita.speakeasy.net ([216.254.0.13]:37933 "HELO
	lolita.speakeasy.net") by vger.kernel.org with SMTP
	id <S129312AbQKFUg3>; Mon, 6 Nov 2000 15:36:29 -0500
Message-ID: <3A07C0BF.4060607@speakeasy.org>
Date: Tue, 07 Nov 2000 00:43:43 -0800
From: Miles Lane <miles@speakeasy.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test10 i686; en-US; m18) Gecko/20001102
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Dharm <mdharm@one-eyed-alien.net>, linux-kernel@vger.kernel.org
Subject: 2.4.0-test10 -- Problem reading VFAT formatted ORB drive.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an ORB drive I am accessing using the usb-storage driver.
I formatted the drive media last night using Windoze 98.  The media
was formatted as though it had one large partition, which is weird
because I had previously partitioned the drive under Linux 2.4.0-test10
with several partitions.  The Windoze format utility did not notice
those partitions and simply (I thought) wrote one large partition and
formatted it as VFAT.  I have successfully written and read data on
the media using two separate Windoze 98 machines.  When I mounted
the drive under 2.4.0-test10 and then looked at the media with
fdisk, here's what I see:

#> fdisk /dev/sda

Disk /dev/sda: 68 heads, 62 sectors, 1021 cylinders
Units = cylinders of 4216 * 512 bytes

    Device Boot    Start       End    Blocks   Id  System
/dev/sda1   ?    455397    584533 272218546+  20  Unknown
Partition 1 has different physical/logical beginnings (non-Linux?):
      phys=(356, 97, 46) logical=(455396, 22, 59)
Partition 1 has different physical/logical endings:
      phys=(357, 116, 40) logical=(584532, 18, 23)
Partition 1 does not end on cylinder boundary:
      phys=(357, 116, 40) should be (357, 67, 62)
/dev/sda2   ?    315509    443350 269488144   6b  Unknown
Partition 2 has different physical/logical beginnings (non-Linux?):
      phys=(288, 110, 57) logical=(315508, 39, 57)
Partition 2 has different physical/logical endings:
      phys=(269, 101, 57) logical=(443349, 17, 52)
Partition 2 does not end on cylinder boundary:
      phys=(269, 101, 57) should be (269, 67, 62)
/dev/sda3   ?    127844    459524 699181456   53  OnTrack DM6 Aux3
Partition 3 has different physical/logical beginnings (non-Linux?):
      phys=(345, 32, 19) logical=(127843, 53, 18)
Partition 3 has different physical/logical endings:
      phys=(324, 77, 19) logical=(459523, 53, 49)
Partition 3 does not end on cylinder boundary:
      phys=(324, 77, 19) should be (324, 67, 62)
/dev/sda4   *    330795    330800     10668+  49  Unknown
Partition 4 has different physical/logical beginnings (non-Linux?):
      phys=(87, 1, 0) logical=(330794, 2, 36)
Partition 4 has different physical/logical endings:
      phys=(335, 78, 2) logical=(330799, 6, 44)
Partition 4 does not end on cylinder boundary:
      phys=(335, 78, 2) should be (335, 67, 62)

Partition table entries are not in disk order


When I try to mount the drive, I get the common error:

mount -t vfat /dev/sda1 /mnt/orb1
mount: wrong fs type, bad option, bad superblock on /dev/sda1,
        or too many mounted file systems

What's going on here?  It seems to me that this is a bug in the
Linux test10 filesystem support, since Windoze can read and write
to this drive currently.  Our implementation should be compatible.

Cheers,
	Miles

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
