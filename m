Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292346AbSBYVP6>; Mon, 25 Feb 2002 16:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292344AbSBYVPt>; Mon, 25 Feb 2002 16:15:49 -0500
Received: from chaos.analogic.com ([204.178.40.224]:46217 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S292347AbSBYVPg>; Mon, 25 Feb 2002 16:15:36 -0500
Date: Mon, 25 Feb 2002 16:18:48 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Manohar Pradhan <mpml@isp.primuseurope.com>
cc: =?ISO-8859-1?B?SmFrb2Ig2HN0ZXJnYWFyZA==?= <jakob@unthought.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Re[2]: Urgent SCSI I/O Error
In-Reply-To: <154785420535.20020225204419@isp.primuseurope.com>
Message-ID: <Pine.LNX.3.95.1020225155852.29043A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2002, Manohar Pradhan wrote:

> Hi All,
> 
> If the Hard Drive is died, means I will need to replace. I have backup
> for the Data in that /www partition.
> 
> Means when I replace new HDD, I will have to partition/format using
> fdisk /sda ?
> 
> >From my partition info,
> 
> /dev/sdb6               917072    732972    137516  84% /
> /dev/sda1                18820      5811     12037  33% /boot
> /dev/sda6              2218336    462492   1643156  22% /www
> /dev/sda5              5297560    418936   4609520   8% /home
> /dev/sda7              1210440    711516    437436  62% /software
> /dev/sdb1              5550188     50896   5217356   1% /usr
> /dev/sdb5              2016016     28572   1885032   1% /var
> 
> 
> My problematic HDD is /sda so if I replace this HDD, how can I boot as
> boot images are in /sda1 /boot partition. How can I copy this boot
> images to somewhere and make it work and what will be the process?
> 
> I know if I reboot and replace the HDD, it will give problem while
> booting, any Idea to struggle with this?
> 
> Thanks a lot for all your help.
> 
> Regards
> Manohar
> 
> 

Simple. This assumes your boot drive (/dev/sda) is still readable.

(1)  Comment out (in /etc/fstab) everything that mounts anything you
don't need for the basic system. This is just to simplify things
when you are working.

(2)  Make a floppy disk that boots linux and uses the current root
file-system (man rdev). If you don't need modules to boot it's just
`cp /boot/vmlinuz-whatever-rev-is /dev/fd0`
`rdev /dev/fd0 /dev/sdb6`
Boot, using your floppy, to make certain your system comes up okay.

(3)  Shut down and install your new SCSI disk as the next highest
SCSI device number. This will make it /dev/sdc because you have
/dev/sda and /dev/sdb.

(4)  Reboot. Your new SCSI disk will be /dev/sdc.

(5)  Using fdisk, partition it like /dev/sda, the one you are
replacing.

(6)  `mkfs` on each partition.
(7)  Mount each partition, one at a time, off from /mnt and tar
your files to it like:
	mount /dev/sdc1 /mnt	# will be /boot
	cd /boot
	tar -clf - . | (cd /mnt; tar -xvpf -)
	umount/mnt
Do this for each parition.

(8)  Shut down, and change the SCSI address of /dev/sdc to the address
of the drive you are replacing /dev/sda (change to device 0). Remove
the bad drive.

(9)  Reboot using the floppy.
(10) Execute lilo, this will make the new drive bootable.
(11) Un-comment /etc/fstab stuff.
(12) Execute mount -a

Done, remove floppy and reboot.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

        111,111,111 * 111,111,111 = 12,345,678,987,654,321

