Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282947AbRK0U56>; Tue, 27 Nov 2001 15:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282946AbRK0U5u>; Tue, 27 Nov 2001 15:57:50 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:21285 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S282947AbRK0U5c>; Tue, 27 Nov 2001 15:57:32 -0500
Message-ID: <3C03FEC5.3000003@paulbristow.net>
Date: Tue, 27 Nov 2001 21:59:49 +0100
From: Paul Bristow <paul@paulbristow.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010914
X-Accept-Language: en-us
MIME-Version: 1.0
To: Gregoire Favre <greg@ulima.unil.ch>
CC: linux-kernel@vger.kernel.org
Subject: Re: Can't acess ide ZIP under 2.4.16 with devfs
In-Reply-To: <20011127202112.A13757@ulima.unil.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregoire,

I'm working (right this minute) on devfs support for ide-floppy

but... your problem doesn't look like an ide-floppy/devfs problem.

On my system, the output from fdisk on a zip 250 looks like

  [root@zoltar ide]# fdisk /dev/hdf

   Command (m for help): p

   Disk /dev/hdf: 64 heads, 32 sectors, 239 cylinders
   Units = cylinders of 2048 * 512 bytes

      Device    Boot    Start       End    Blocks   Id  System
      /dev/hdf4   *         1       239    244720    6  FAT16

so your hdc is a hard disk, not a zip.

Try changing your fstab to point to ide/host0/bus1/target0/lun0/disc 
instead of /dev/hdc

Gregoire Favre wrote:

> Hello,
> 
> I didn't try devfs for a long time, I wasn't using it because of a problem
> I hadded, but didn't remember which one...
> 
> Now, I can remember: I can't access my IDE zip which is normaly (without
> devfs) under hdc.
> 
> Could someone explain me what I am doing wrong?
> I can't test it with a partitionned ZIP as all my ZIP have no partitions.
> 
> I give here the output of somes commands (under 2.4.16 with devfs):
> 
> [greg@localhost /dev]$ ll hd*
> lr-xr-xr-x    1 root     root           32 Nov 27  2001 hda -> ide/host0/bus0/target0/lun0/disc
> lr-xr-xr-x    1 root     root           33 Nov 27  2001 hda1 -> ide/host0/bus0/target0/lun0/part1
> lr-xr-xr-x    1 root     root           33 Nov 27  2001 hda2 -> ide/host0/bus0/target0/lun0/part2
> lr-xr-xr-x    1 root     root           33 Nov 27  2001 hda3 -> ide/host0/bus0/target0/lun0/part3
> lr-xr-xr-x    1 root     root           33 Nov 27  2001 hda4 -> ide/host0/bus0/target0/lun0/part4
> lr-xr-xr-x    1 root     root           33 Nov 27  2001 hda5 -> ide/host0/bus0/target0/lun0/part5
> lr-xr-xr-x    1 root     root           33 Nov 27  2001 hda6 -> ide/host0/bus0/target0/lun0/part6
> lr-xr-xr-x    1 root     root           32 Nov 27  2001 hdc -> ide/host0/bus1/target0/lun0/disc
> 
> [greg@localhost /dev]$ cat /proc/partitions 
> major minor  #blocks  name
> 
>    8     0    8925000 scsi/host0/bus0/target0/lun0/disc
>    8     1     136521 scsi/host0/bus0/target0/lun0/part1
>    8     2    8787555 scsi/host0/bus0/target0/lun0/part2
>   22     0     244736 ide/host0/bus1/target0/lun0/disc
>    3     0   14114520 ide/host0/bus0/target0/lun0/disc
>    3     1    4200966 ide/host0/bus0/target0/lun0/part1
>    3     2     136552 ide/host0/bus0/target0/lun0/part2
>    3     3      16065 ide/host0/bus0/target0/lun0/part3
>    3     4          1 ide/host0/bus0/target0/lun0/part4
>    3     5    1052226 ide/host0/bus0/target0/lun0/part5
>    3     6    8707198 ide/host0/bus0/target0/lun0/part6
> 
> My /etc/fstab contains:
> /dev/hdc        /mnt/ext2       ext3            nosuid,noauto,nodev,user                1 2
> 
> [greg@localhost /dev]$ mount /mnt/ext2/
> mount: wrong fs type, bad option, bad superblock on /dev/hdc,
>        or too many mounted file systems
> 
> 
> 	Grégoire
> ________________________________________________________________
> http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
> -


-- 

Paul

Email: 
paul@paulbristow.net
Web: 
http://paulbristow.net
ICQ: 
11965223

