Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315277AbSHLGbb>; Mon, 12 Aug 2002 02:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317328AbSHLGbb>; Mon, 12 Aug 2002 02:31:31 -0400
Received: from ns.splentec.com ([209.47.35.194]:1805 "EHLO pepsi.splentec.com")
	by vger.kernel.org with ESMTP id <S315277AbSHLGb3>;
	Mon, 12 Aug 2002 02:31:29 -0400
Message-ID: <012301c241cb$16ea8530$fe232fd1@corona>
From: "James Lee" <jlee@canada.com>
To: <linux-kernel@vger.kernel.org>, <linux-xfs@oss.sgi.com>
References: <d8jsn1k9b03.fsf@wirth.ping.uio.no>
Subject: Re: kernel BUG at filemap.c:843!
Date: Mon, 12 Aug 2002 02:40:03 -0400
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm also having the exactly same problem.
Tested with 2.4.19-xfs(checked out from SGI's CVS on Aug 10) on Redhat 7.2.
Kernel and userland tools are compiled with gcc 2.91.66
The following is the result of some tests:

scsidisks -> xfs: OK
scsidisks -> raid5 -> xfs: OK
scsidisks -> lvm -> xfs: OK
scsidisks -> raid0 -> lvm -> xfs: OK
scsidisks -> raid1 -> lvm -> xfs: OK
scsidisks -> raid5 -> lvm -> xfs: kernel BUG at filemap.c:843!

This problem is always reproducible with the following shell script:

        #!/bin/sh
        mkraid /dev/md0
        vgcreate VolumeGroup /dev/md0
        lvcreate -L1G -nTestVolume VolumeGroup
        mkfs.xfs -f -d size=32m /dev/VolumeGroup/TestVolume
        mount -t xfs /dev/VolumeGroup/TestVolume
/mnt -onoatime,nodiratime,usrquota,grpquota

Whenever I run the above script, mount command always generates kernel oops.
But, if I insert some delay as of the following, then mount goes well:


        #!/bin/sh
        mkraid /dev/md0
        vgcreate VolumeGroup /dev/md0
        lvcreate -L1G -nTestVolume VolumeGroup
        mkfs.xfs -f -d size=32m /dev/VolumeGroup/TestVolume
        sleep 1
        mount -t xfs /dev/VolumeGroup/TestVolume
/mnt -onoatime,nodiratime,usrquota,grpquota

JLee

----- Original Message -----
From: "Dagfinn Ilmari Manns?er" <ilmari@ping.uio.no>
To: <linux-kernel@vger.kernel.org>; <linux-xfs@oss.sgi.com>
Sent: Sunday, August 11, 2002 8:27 PM
Subject: kernel BUG at filemap.c:843!


> Hi,
>
> I have been bitten a few times by the BUG() in unlock_page(), both
> with 2.4.19-rc3-xfs and 2.4.19-xfs (the latter checked out from SGI's
> CVS on Aug 10). The system is SCSI-only, with a raid5 array as an LVM
> physical volume and XFS on all the volumes.
>
> Software-wise it's Debian Woody, but the kernel is compiled on a Sid
> box with gcc 2.95.4-16.
>
> Attached are the decoded oops, the module list and the config.
>
> --
> ilmari
>
>


