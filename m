Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132886AbRAQUcj>; Wed, 17 Jan 2001 15:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132130AbRAQUc2>; Wed, 17 Jan 2001 15:32:28 -0500
Received: from mail.zmailer.org ([194.252.70.162]:39692 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S131894AbRAQUcT>;
	Wed, 17 Jan 2001 15:32:19 -0500
Date: Wed, 17 Jan 2001 22:32:06 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Werner Almesberger <Werner.Almesberger@epfl.ch>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Linux not adhering to BIOS Drive boot order?
Message-ID: <20010117223206.H25659@mea-ext.zmailer.org>
In-Reply-To: <1355693A51C0D211B55A00105ACCFE64E95191@ATL_MS1> <Pine.LNX.4.21.0101161154580.17397-100000@sol.compendium-tech.com> <20010117202222.B4979@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010117202222.B4979@almesberger.net>; from Werner.Almesberger@epfl.ch on Wed, Jan 17, 2001 at 08:22:22PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2001 at 08:22:22PM +0100, Werner Almesberger wrote:
> The only cases when you really need to know the name of a disk is when
>  - doing disk-level management, e.g. partitioning or creating file
>    systems (*)
>  - adding a swap partition (sigh)
>  - telling your boot loader where to put its boot sector

  2.4.0 with devfs mounted at boot time into /dev/

  Only thing missing is that here  /dev/scsi/host0/  propably should be
  a symlink to something like   /dev/bus/pci/BB/II.F ...
  Or perhaps  /dev/scsi/BUS/BB/II.F/busN/targetT/lunL/partP
  but mixing in ISA-bus controllers is somewhat tough..

$ mount
/dev/scsi/host0/bus0/target0/lun0/part3 on / type ext2 (rw)
/dev/scsi/host0/bus0/target2/lun0/part2 on /home type ext2 (rw)
/dev/scsi/host0/bus0/target0/lun0/part4 on /usr type ext2 (rw)
/dev/scsi/host0/bus0/target2/lun0/part1 on /usr/src type ext2 (rw)
/dev/scsi/host0/bus0/target0/lun0/part1 on /boot type ext2 (rw)

  I do, of course, use mounting with  LABEL=

  This new style (which contains, hopefully, physical PCI location)
  mount device paths will failry easily handle question about which
  is where...   And the partitions are PHYSICAL partition numbers,
  not some logical ones.  That is true with /dev/sdXP case as well
  as with /dev/hdXP case.

> - Werner

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
