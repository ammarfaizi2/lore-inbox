Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129602AbQLXT7P>; Sun, 24 Dec 2000 14:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129818AbQLXT7E>; Sun, 24 Dec 2000 14:59:04 -0500
Received: from ns1.tu-graz.ac.at ([129.27.2.3]:9117 "EHLO ns1.tu-graz.ac.at")
	by vger.kernel.org with ESMTP id <S129602AbQLXT6u>;
	Sun, 24 Dec 2000 14:58:50 -0500
From: rkreiner@sbox.tu-graz.ac.at
Message-ID: <3A464EF9.38029296@sbox.tu-graz.ac.at>
Date: Sun, 24 Dec 2000 20:31:05 +0100
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.4.0-test13-pre4 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
        linux-kernel@vger.kernel.org, mikeg@wen-online.de
Subject: Re: FEATURE (was Re: PROBLEM: multiple mount of devices 
 possible2.4.0-test1 -  2.4.0-test13-pre4
In-Reply-To: <Pine.LNX.4.21.0012231824020.838-100000@penguin.homenet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tigran Aivazian wrote:
> 
> it is not a problem, it is a feature. (and a useful one!)
> 

yes, mount devices several times it would be a nice feature, but do
something like:

/etc/fstab:
/dev/hdd1 /mydrive ext2 ro,noauto,user 1 1

as user: mount /mydrive
as root: mount /dev/hda2 /mydrive
as user: mount /mydrive
as root: mount /dev/hda2 /mydrive
as user: mount /mydrive

result /proc/mounts:
/dev/hdd1 /mydrive ext2 ro,noexec,nosuid,nodev 0 0
/dev/hda2 /mydrive vfat rw 0 0
/dev/hdd1 /mydrive ext2 ro,noexec,nosuid,nodev 0 0
/dev/hda2 /mydrive vfat rw 0 0
/dev/hdd1 /mydrive ext2 ro,noexec,nosuid,nodev 0 0     

u dont have control about the mountpoints

Here a BIG PROBLEM:
as user: mount /mydrive
as root: mount /dev/hdd1 /test
as root: mount /dev/hdd1 /mnt

result /proc/mounts:
/dev/hdd1 /mydrive ext2 ro,noexec,nosuid,nodev 0 0
/dev/hdd1 /test ext2 ro,noexec,nosuid,nodev 0 0
/dev/hdd1 /mnt ext2 ro,noexec,nosuid,nodev 0 0    

but do like 
mount -o remount /mnt -w

result /proc/mounts:
/dev/hdd1 /mydrive ext2 rw 0 0
/dev/hdd1 /test ext2 rw 0 0
/dev/hdd1 /mnt ext2 rw 0 0     

ALL mountpoints now READ-WRITE-able!

u lost noexec... and dont have more "security" for users...
same as sym-links ... no new feature...


Reinhard.

> On Sat, 23 Dec 2000 rkreiner@sbox.tu-graz.ac.at wrote:
> 
> >
> > 1. multiple mount of devices possible 2.4.0-test1 - 2.4.0-test13-pre4
> >
> > 2. its still possible to mount devices several times.
> >    IMHO it shouldnt be possible like 2.2.18
> >    with umount in /proc/mounts is still the real information,
> >    in /etc/mtab all corresponding mountpoints are deleted.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
