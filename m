Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130521AbRCDVgh>; Sun, 4 Mar 2001 16:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130522AbRCDVgR>; Sun, 4 Mar 2001 16:36:17 -0500
Received: from linux.kappa.ro ([194.102.255.131]:38834 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S130521AbRCDVgL>;
	Sun, 4 Mar 2001 16:36:11 -0500
Date: Sun, 4 Mar 2001 23:32:44 +0200
From: Mircea Damian <dmircea@kappa.ro>
To: Keith Owens <kaos@ocs.com.au>
Cc: sjhill@cotw.com, linux-kernel@vger.kernel.org
Subject: Re: LILO error with 2.4.3-pre1...
Message-ID: <20010304233244.B32142@linux.kappa.ro>
In-Reply-To: <3AA19820.6A33E871@cotw.com> <22634.983669972@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <22634.983669972@ocs3.ocs-net>; from kaos@ocs.com.au on Sun, Mar 04, 2001 at 12:39:32PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 04, 2001 at 12:39:32PM +1100, Keith Owens wrote:
> On Sat, 03 Mar 2001 19:19:28 -0600, 
> "Steven J. Hill" <sjhill@cotw.com> wrote:
> >I have no idea why the 1023 limit is coming up considering 2.4.2 and
> >LILO were working just fine together and I have a newer BIOS that has
> >not problems detecting the driver properly. Go ahead, call me idiot :).
> 
> OK, you're an idiot :).  It only worked before because all the files
> that lilo used just happened to be below cylinder 1024.  Your partition
> goes past cyl 1024 and your new kernel is using space above 1024.  Find
> a version of lilo that can cope with cyl >= 1024 (is there one?) or
> move the kernel below cyl 1024.  You might need to repartition your
> disk to get / all below 1024.

Call me idiot too but please explain what is wrong here:

# cat /etc/lilo.conf
boot = /dev/hda
timeout = 150
vga = 4
ramdisk = 0
lba32
append = "hdc=scsi"
prompt


image = /boot/vmlinuz-2.4.2
  root = /dev/hda2
  read-only
  label = Linux

other = /dev/hda3
  label = win
  table = /dev/hda

# fdisk -l /dev/hda

Disk /dev/hda: 255 heads, 63 sectors, 1650 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hda1             1        17    136521   82  Linux swap
/dev/hda2            18      1165   9221310   83  Linux
/dev/hda3   *      1166      1650   3895762+   c  Win95 FAT32 (LBA)
root@taz:~# lilo -v
LILO version 21.7, Copyright (C) 1992-1998 Werner Almesberger
Linux Real Mode Interface library Copyright (C) 1998 Josh Vanderhoof
Development beyond version 21 Copyright (C) 1999-2001 John Coffman
Released 24-Feb-2001 and compiled at 18:31:02 on Mar  3 2001.

Reading boot sector from /dev/hda
Merging with /boot/boot.b
Boot image: /boot/vmlinuz-2.4.2
Added Linux *
Boot other: /dev/hda3, on /dev/hda, loader /boot/chain.b
Device 0x0300: Invalid partition table, 3rd entry
  3D address:     63/254/141 (2281229)
  Linear address: 1/0/1165 (18715725)


Mar  2 20:26:29 taz kernel: hda: IBM-DJNA-371350, ATA DISK drive 
Mar  2 20:26:29 taz kernel: hda: 26520480 sectors (13578 MB) w/1966KiB Cache, CHS=1650/255/63 


Is anybody able to explain the error?
That partition contains a valid VFAT partition with win98se installed on it (and it works fine,
ofc if I remove lilo from MBR).

-- 
Mircea Damian
E-mails: dmircea@kappa.ro, dmircea@roedu.net
WebPage: http://taz.mania.k.ro/~dmircea/
