Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288891AbSAXSql>; Thu, 24 Jan 2002 13:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288896AbSAXSqd>; Thu, 24 Jan 2002 13:46:33 -0500
Received: from abasin.nj.nec.com ([138.15.150.16]:16652 "HELO
	abasin.nj.nec.com") by vger.kernel.org with SMTP id <S288891AbSAXSqT>;
	Thu, 24 Jan 2002 13:46:19 -0500
From: Sven Heinicke <sven@research.nj.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15440.22127.875361.718680@abasin.nj.nec.com>
Date: Thu, 24 Jan 2002 13:46:07 -0500 (EST)
To: linux-kernel@vger.kernel.org
Subject: ReiserFS and RAID5
X-Mailer: VM 6.72 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We had a drive go bad on a RAID5 with reiserfs on it.  The file system
was built with reiserfsprogs-3.x.0h tools and the systems was running
Linux 2.4.13.  As we had an issue it will be updated to the latest
kernel, it had been stable up to now.

A drive failed and left the partition in a funk.  When I ran ls in the
RAID directory it would freeze up the ls (I suspect in a hardware wait
of some kind).  I uncommented the partition from the fstab file then
tied to shut down the system, but that froze up that system and I hit
the reset key.

The system came up, the raid started rebuilding itsself with the spare
drive.  I tried to mount the drive and it didn't mount.  I updated my
reiserfs tools to reiserfsprogs-3.x.0j.  I ran reiserfsck on the
partition, I wish I kept the exact error message but didn't, it said
something was wrong with the tree and segfaulted.  I then ran it with
--rebuild-tree and went home.

The next morning the raid rebuild and the fsck was finished (should of
I waited for the raid rebuild to finish before running reiserfsck?).
I mounted the disk read only.  The df command reported 1% full when
before it was like 35% full.

But, all was not lost.  inspecting the partition all the data seemed
to be good.  We hurriedly we copied the files to another partition,
took another night, oddly one directory didn't get copied. 

Then some testing:

1. umounted to mounted /mnt/raid0 a coupld of time in read only mode.
   (nothing changed).

2. mounted in read-write.
   (nothing changed)

3. touched /mnt/raid0/foo
   (nothing changed)

4. rm /mnt/raid0/foo
   (nothing changed in df).  Lost a whole bunch of data according to
   du and other programs.  Specifically, we were able to copy:

121M	  scoutabout/08Oct01
59G	  scoutabout/21Nov01
38G	  scoutabout/23Jul01
5.4G	  scoutabout/23Jul01Output
65G	  scoutabout/27Nov01
4.1G	  scoutabout/29Jun01

But now the corrupted file system reads:

121M	/mnt/raid0/scoutabout/08Oct01
1.0k	/mnt/raid0/scoutabout/12Nov01
59G	/mnt/raid0/scoutabout/21Nov01
38G	/mnt/raid0/scoutabout/23Jul01
238M	/mnt/raid0/scoutabout/23Jul01Output
65G	/mnt/raid0/scoutabout/27Nov01
4.1G	/mnt/raid0/scoutabout/29Jun01

and that is the state we are in.  At least most of our data is saved.
Did I do anything wrong that might of been able to keep the RAID
stable after the drive crash?  Would reiser developers want me to try
anything on it to help them debug it and make the support more stable.

Thanks,

 Sven
