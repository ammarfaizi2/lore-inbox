Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbTIVM0f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 08:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263128AbTIVM0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 08:26:35 -0400
Received: from fep04-mail.bloor.is.net.cable.rogers.com ([66.185.86.74]:41777
	"EHLO fep04-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S263125AbTIVM0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 08:26:31 -0400
Message-ID: <3F6EEAA3.5000809@rogers.com>
Date: Mon, 22 Sep 2003 08:27:15 -0400
From: gaxt <gaxt@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030902 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5-mm3 VFAT File system problem
References: <3F6C543D.7080706@rogers.com> <20030920215152.5e5b318c.rddunlap@osdl.org>
In-Reply-To: <20030920215152.5e5b318c.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep04-mail.bloor.is.net.cable.rogers.com from [24.102.238.105] using ID <dw2price@rogers.com> at Mon, 22 Sep 2003 08:25:54 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Sat, 20 Sep 2003 09:21:01 -0400 gaxt <gaxt@rogers.com> wrote:
> 
> | Upon moving from -mm2 to -mm3, my vfat filesystems did not automatically 
> | bount at bootup as per the fstab and could not be accessed by 
> | applications in Gnome ie. my mount point showed no subdirectories or files.
> | 
> | I could manually mount (not by mount /mnt/win_c but by the full mount -t 
> | vfat /dev/hda1 /mnt/win_c) and I could explore using ls in terminals but 
> | programs in Gnome could not open the filesystem.
> | 
> | Upon rebooting into -mm2 everything was fine again.
> 
> Please post your /etc/fstab file.
> 
> Thanks,
> --
> ~Randy
> 

# /etc/fstab: static file system information.
# $Header: /home/cvsroot/gentoo-src/rc-scripts/etc/fstab,v 1.10 
2002/11/18 19:39:22 azarah Exp $
#
# noatime turns of atimes for increased performance (atimes normally aren't
# needed; notail increases performance of ReiserFS (at the expense of 
storage
# efficiency).  It's safe to drop the noatime options if you want and to
# switch between notail and tail freely.

# <fs>                  <mountpoint>    <type>          <opts> 
         <dump/pass>

# NOTE: If your BOOT partition is ReiserFS, add the notail option to opts.
/dev/hdb2               /boot           ext2            noauto,noatime 
         1 1
/dev/hdb4               /               reiserfs        noatime,notail 
         0 0
/dev/hda2               /home           reiserfs        noatime,notail 
         0 0
/dev/hdb3               none            swap            sw 
         0 0
/dev/cdroms/cdrom0      /mnt/cdrom      iso9660         noauto,ro 
         0 0
/dev/cdroms/cdrom1      /mnt/cdrom1     iso9660         noauto,ro 
         0 0
#/dev/sr0               /mnt/cdrom      iso9660         noauto,ro 
         0 0
#/dev/sr1               /mnt/cdrom1     iso9660         noauto,ro 
         0 0

#proc                   /proc           proc            defaults 
         0 0
none                    /proc           proc            defaults 
         0 0

/dev/fd0                /mnt/floppy     msdos 
noauto,users,umask=000  0 0

# Windows Drives
/dev/hda1               /mnt/win_c      vfat 
noauto,users,umask=000  0 0
/dev/hdb1               /mnt/win_d      vfat 
auto,users,umask=000    0 0

# Flash Card Readers
/dev/sda                /mnt/flash1     vfat 
noauto,users,umask=000  0 0
/dev/sdb1               /mnt/flash2     vfat 
noauto,users,umask=000  0 0
/dev/sdb                /mnt/flash3     vfat 
noauto,users,umask=000  0 0

# NFS Drives on MOOMOO
192.168.1.101:/mnt/zip          /mnt/moozip     nfs 
noauto,rw,hard,intr,users 0 0
192.168.1.101:/mnt/win_c        /mnt/mooc       nfs 
noauto,rw,hard,intr,users 0 0
192.168.1.101:/home/moo_share   /mnt/moo_share  nfs 
noauto,rw,hard,intr,users 0 0

# glibc 2.2 and above expects tmpfs to be mounted at /dev/shm for
# POSIX shared memory (shm_open, shm_unlink). Adding the following
# line to /etc/fstab should take care of this:
# (tmpfs is a dynamically expandable/shrinkable ramdisk, and will use 
almost no
#  memory if not populated with files)

#tmpfs                  /dev/shm        tmpfs           defaults 
         0 0
none                    /dev/shm        tmpfs           defaults 
         0 0

#/dev/sdc2 /mnt/ipod vfat defaults,uid=500,gid=500,user,noauto 0 0
/dev/sdc2 /mnt/ipod vfat defaults,user,noauto 0 0

