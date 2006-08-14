Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751892AbWHNHtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbWHNHtM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 03:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbWHNHtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 03:49:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:8970 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751892AbWHNHtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 03:49:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X/AO+t66QuM0USJ05ujc58vLJsim27519pGYRfWsmMs64E27PKf1wEGhPdv5jTtRJx1++xs6g1j6MCFxzEStIfxXYvw2Iu+ZYXJbW7v1wJpMAl9N6l2/IVEfBVlZgCWSKvw7lVWFWYKBOoLjsWbcu/eM9ziRq08uLnDecLPRAjw=
Message-ID: <9a8748490608140049t492742cx7f826a9f40835d71@mail.gmail.com>
Date: Mon, 14 Aug 2006 09:49:10 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Nathan Scott" <nathans@sgi.com>
Subject: Re: 2.6.18-rc3-git3 - XFS - BUG: unable to handle kernel NULL pointer dereference at virtual address 00000078
Cc: "Avuton Olrich" <avuton@gmail.com>, "Tony. Ho" <linux@idccenter.cn>,
       linux-kernel@vger.kernel.org, xfs@oss.sgi.com
In-Reply-To: <20060814120032.E2698880@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <3aa654a40608072039r2b5c5a19hbd3e68e4fee40869@mail.gmail.com>
	 <9a8748490608080137k596a6290r3567096668449a64@mail.gmail.com>
	 <20060808185405.B2528231@wobbly.melbourne.sgi.com>
	 <9a8748490608100431m244207b1v9c9c5087233fcf3a@mail.gmail.com>
	 <20060811083546.B2596458@wobbly.melbourne.sgi.com>
	 <9a8748490608101544n29f863e7o7584ac64f1d4c210@mail.gmail.com>
	 <9a8748490608101552w12822fa6m415a5fb5537c744d@mail.gmail.com>
	 <9a8748490608110133v5f973cf6w1af340f59bb229ec@mail.gmail.com>
	 <9a8748490608110325k25c340e2yac925eb226d1fe4f@mail.gmail.com>
	 <20060814120032.E2698880@wobbly.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/06, Nathan Scott <nathans@sgi.com> wrote:
> On Fri, Aug 11, 2006 at 12:25:03PM +0200, Jesper Juhl wrote:
> > I didn't capture all of the xfs_repair output, but I did get this :
> > ...
> > Phase 4 - check for duplicate blocks...
> >         - setting up duplicate extent list...
> >         - clear lost+found (if it exists) ...
> >         - clearing existing "lost+found" inode
> >         - deleting existing "lost+found" entry
> >         - check for inodes claiming duplicate blocks...
> >         - agno = 0
> >         - agno = 1
> >         - agno = 2
> >         - agno = 3
> >         - agno = 4
> >         - agno = 5
> >         - agno = 6
> > LEAFN node level is 1 inode 412035424 bno = 8388608
>
> Ooh.  Can you describe this test case you're using?

Sure.

The server has a bunch of XFS filesystems :

# mount
/dev/md1 on / type xfs (rw)
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
tmpfs on /dev/shm type tmpfs (rw)
usbfs on /proc/bus/usb type usbfs (rw)
/dev/md0 on /boot type ext3 (rw)
/dev/mapper/Archive-Backup on /mnt/backup type xfs (rw)
/dev/mapper/Mirror-ws1 on /mnt/rsync/ws1 type xfs
(rw,noatime,ihashsize=64433,logdev=/dev/Log/ws1_log)
/dev/mapper/Mirror-ws2 on /mnt/rsync/ws2 type xfs
(rw,noatime,ihashsize=64433,logdev=/dev/Log/ws2_log)
/dev/mapper/Mirror-ws3 on /mnt/rsync/ws3 type xfs
(rw,noatime,ihashsize=64433,logdev=/dev/Log/ws3_log)
/dev/mapper/Mirror-ws4 on /mnt/rsync/ws4 type xfs
(rw,noatime,ihashsize=64433,logdev=/dev/Log/ws4_log)
/dev/mapper/Mirror-ws5 on /mnt/rsync/ws5 type xfs
(rw,noatime,ihashsize=64433,logdev=/dev/Log/ws5_log)
/dev/mapper/Mirror-ws6 on /mnt/rsync/ws6 type xfs
(rw,noatime,ihashsize=64433,logdev=/dev/Log/ws6_log)
/dev/mapper/Mirror-ws7 on /mnt/rsync/ws7 type xfs
(rw,noatime,ihashsize=64433,logdev=/dev/Log/ws7_log)
/dev/mapper/Mirror-ws8 on /mnt/rsync/ws8 type xfs
(rw,noatime,ihashsize=64433,logdev=/dev/Log/ws8_log)
/dev/mapper/Mirror-ws9 on /mnt/rsync/ws9 type xfs
(rw,noatime,ihashsize=64433,logdev=/dev/Log/ws9_log)
/dev/mapper/Mirror-ws10 on /mnt/rsync/ws10 type xfs
(rw,noatime,ihashsize=64433,logdev=/dev/Log/ws10_log)
/dev/mapper/Mirror-ws11 on /mnt/rsync/ws11 type xfs
(rw,noatime,ihashsize=64433,logdev=/dev/Log/ws11_log)
/dev/mapper/Mirror-ws12 on /mnt/rsync/ws12 type xfs
(rw,noatime,ihashsize=64433,logdev=/dev/Log/ws12_log)
/dev/mapper/Mirror-ws13 on /mnt/rsync/ws13 type xfs
(rw,noatime,ihashsize=64433,logdev=/dev/Log/ws13_log)
/dev/mapper/Mirror-ws14 on /mnt/rsync/ws14 type xfs
(rw,noatime,ihashsize=64433,logdev=/dev/Log/ws14_log)
/dev/mapper/Mirror-ws15 on /mnt/rsync/ws15 type xfs
(rw,noatime,ihashsize=64433,logdev=/dev/Log/ws15_log)
/dev/mapper/Mirror-ws16 on /mnt/rsync/ws16 type xfs
(rw,noatime,ihashsize=64433,logdev=/dev/Log/ws16_log)
/dev/mapper/Mirror-ws17 on /mnt/rsync/ws17 type xfs
(rw,noatime,ihashsize=64433,logdev=/dev/Log/ws17_log)
/dev/mapper/Mirror-ws18 on /mnt/rsync/ws18 type xfs
(rw,noatime,ihashsize=64433,logdev=/dev/Log/ws18_log)
/dev/mapper/Mirror-ws19 on /mnt/rsync/ws19 type xfs
(rw,noatime,ihashsize=64433,logdev=/dev/Log/ws19_log)
/dev/mapper/Mirror-ws20 on /mnt/rsync/ws20 type xfs
(rw,noatime,ihashsize=64433,logdev=/dev/Log/ws20_log)
/dev/mapper/Mirror-ws21 on /mnt/rsync/ws21 type xfs
(rw,noatime,ihashsize=64433,logdev=/dev/Log/ws21_log)
/dev/mapper/Mirror-wsb1 on /mnt/rsync/wsb1 type xfs
(rw,noatime,ihashsize=64433,logdev=/dev/Log/wsb1_log)
/dev/mapper/Mirror-wsb2 on /mnt/rsync/wsb2 type xfs
(rw,noatime,ihashsize=64433,logdev=/dev/Log/wsb2_log)
/dev/mapper/Mirror-wsb3 on /mnt/rsync/wsb3 type xfs
(rw,noatime,ihashsize=64433,logdev=/dev/Log/wsb3_log)
/dev/mapper/Mirror-wsb4 on /mnt/rsync/wsb4 type xfs
(rw,noatime,ihashsize=64433,logdev=/dev/Log/wsb4_log)
/dev/mapper/Mirror-wsp1 on /mnt/rsync/wsp1 type xfs
(rw,noatime,ihashsize=64433,logdev=/dev/Log/wsp1_log)
/dev/mapper/Mirror-wsp2 on /mnt/rsync/wsp2 type xfs
(rw,noatime,ihashsize=64433,logdev=/dev/Log/wsp2_log)
/dev/mapper/Mirror-wsp3 on /mnt/rsync/wsp3 type xfs
(rw,noatime,ihashsize=64433,logdev=/dev/Log/wsp3_log)
/dev/mapper/Mirror-obr1 on /mnt/ob/obr1 type xfs (rw,noatime,ihashsize=64433)
tmpfs on /dev type tmpfs (rw,size=10M,mode=0755)

These filesystems vary in size from 50G to 3.5T

The XFS filesystems contain rsync copies of filesystems on as many servers.
The workload that triggers the problem is when all the servers start
updating their copy via rsync - Then within a few hours the problem
triggers.

So to recreate the same scenario you'll want 28 servers doing rsync of
filesystems of various sizes between 50G & 3.5T to a central server
running 2.6.18-rc4 with 28 XFS filesystems.
The XFS filesystems are on LVM and each physical volume is made up of
two disks in a RAID1.


>  Something with
> a bunch of renames in it, obviously, but I'd also like to be able to
> reproduce locally with the exact data set (file names in particular),
> if at all possible.
>
There are millions of files. The data the server recievs is copies of
websites. Each server that sends data to the server with the 28 XFS
filesystems hosts between 1800 and 2600 websites, so there are lots of
files and every concievable strange filename.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
