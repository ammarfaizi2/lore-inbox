Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282730AbRK0TVr>; Tue, 27 Nov 2001 14:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282749AbRK0TVd>; Tue, 27 Nov 2001 14:21:33 -0500
Received: from ulima.unil.ch ([130.223.144.143]:1409 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S282730AbRK0TVO>;
	Tue, 27 Nov 2001 14:21:14 -0500
Date: Tue, 27 Nov 2001 20:21:12 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: Can't acess ide ZIP under 2.4.16 with devfs
Message-ID: <20011127202112.A13757@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I didn't try devfs for a long time, I wasn't using it because of a problem
I hadded, but didn't remember which one...

Now, I can remember: I can't access my IDE zip which is normaly (without
devfs) under hdc.

Could someone explain me what I am doing wrong?
I can't test it with a partitionned ZIP as all my ZIP have no partitions.

I give here the output of somes commands (under 2.4.16 with devfs):

[greg@localhost /dev]$ ll hd*
lr-xr-xr-x    1 root     root           32 Nov 27  2001 hda -> ide/host0/bus0/target0/lun0/disc
lr-xr-xr-x    1 root     root           33 Nov 27  2001 hda1 -> ide/host0/bus0/target0/lun0/part1
lr-xr-xr-x    1 root     root           33 Nov 27  2001 hda2 -> ide/host0/bus0/target0/lun0/part2
lr-xr-xr-x    1 root     root           33 Nov 27  2001 hda3 -> ide/host0/bus0/target0/lun0/part3
lr-xr-xr-x    1 root     root           33 Nov 27  2001 hda4 -> ide/host0/bus0/target0/lun0/part4
lr-xr-xr-x    1 root     root           33 Nov 27  2001 hda5 -> ide/host0/bus0/target0/lun0/part5
lr-xr-xr-x    1 root     root           33 Nov 27  2001 hda6 -> ide/host0/bus0/target0/lun0/part6
lr-xr-xr-x    1 root     root           32 Nov 27  2001 hdc -> ide/host0/bus1/target0/lun0/disc

[greg@localhost /dev]$ cat /proc/partitions 
major minor  #blocks  name

   8     0    8925000 scsi/host0/bus0/target0/lun0/disc
   8     1     136521 scsi/host0/bus0/target0/lun0/part1
   8     2    8787555 scsi/host0/bus0/target0/lun0/part2
  22     0     244736 ide/host0/bus1/target0/lun0/disc
   3     0   14114520 ide/host0/bus0/target0/lun0/disc
   3     1    4200966 ide/host0/bus0/target0/lun0/part1
   3     2     136552 ide/host0/bus0/target0/lun0/part2
   3     3      16065 ide/host0/bus0/target0/lun0/part3
   3     4          1 ide/host0/bus0/target0/lun0/part4
   3     5    1052226 ide/host0/bus0/target0/lun0/part5
   3     6    8707198 ide/host0/bus0/target0/lun0/part6

My /etc/fstab contains:
/dev/hdc        /mnt/ext2       ext3            nosuid,noauto,nodev,user                1 2

[greg@localhost /dev]$ mount /mnt/ext2/
mount: wrong fs type, bad option, bad superblock on /dev/hdc,
       or too many mounted file systems

[greg@localhost /dev]$ sudo fdisk /dev/hdc

The number of cylinders for this disk is set to 1757.
There is nothing wrong with that, but this is larger than 1024,
and could in certain setups cause problems with:
1) software that runs at boot time (e.g., old versions of LILO)
2) booting and partitioning software from other OSs
   (e.g., DOS FDISK, OS/2 FDISK)

Command (m for help): p

Disk /dev/hdc: 255 heads, 63 sectors, 1757 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hdc1   *         1       523   4200966    7  HPFS/NTFS
/dev/hdc2           524       540    136552+  82  Linux swap
/dev/hdc3           541       542     16065   83  Linux
/dev/hdc4           543      1757   9759487+   5  Extended
/dev/hdc5           543       673   1052226    6  FAT16
/dev/hdc6           674      1757   8707198+  83  Linux

Command (m for help): q

[greg@localhost /dev]$ sudo fdisk /dev/hda

The number of cylinders for this disk is set to 1757.
There is nothing wrong with that, but this is larger than 1024,
and could in certain setups cause problems with:
1) software that runs at boot time (e.g., old versions of LILO)
2) booting and partitioning software from other OSs
   (e.g., DOS FDISK, OS/2 FDISK)

Command (m for help): p

Disk /dev/hda: 255 heads, 63 sectors, 1757 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hda1   *         1       523   4200966    7  HPFS/NTFS
/dev/hda2           524       540    136552+  82  Linux swap
/dev/hda3           541       542     16065   83  Linux
/dev/hda4           543      1757   9759487+   5  Extended
/dev/hda5           543       673   1052226    6  FAT16
/dev/hda6           674      1757   8707198+  83  Linux

Command (m for help): q

Thanks you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
