Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269261AbRHGSSj>; Tue, 7 Aug 2001 14:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269262AbRHGSS3>; Tue, 7 Aug 2001 14:18:29 -0400
Received: from dev.audiogalaxy.com ([64.245.48.170]:27154 "EHLO
	dev.audiogalaxy.com") by vger.kernel.org with ESMTP
	id <S269274AbRHGSSR>; Tue, 7 Aug 2001 14:18:17 -0400
Date: Tue, 7 Aug 2001 13:18:29 -0500 (CDT)
From: Michael Merhej <michael@audiogalaxy.com>
To: <linux-kernel@vger.kernel.org>
Subject: VM issues (2.4.8pre4 and 2.4.8pre5) vs 2.4.7
Message-ID: <Pine.LNX.4.33.0108071207070.26895-100000@dev.audiogalaxy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Box configuration:
dual 1ghz box, 2gigs of RAM, 15k RPM scsi drive, eepro100, aic7xxx host
MySQL 3.23.40
database size = ~5 gigs on ext2 filesystem

The database is mostly random access with most hits resulting in non
cached data.  MySQL is heavily IO bound.

We have seen a 40% increase in queries per second that our
machines can perform on the above configuration on 2.4.7pre4 compared
to 2.4.7 which is excellent.  This was verfied on several machines within
one of our database farms.  BTW We tried 2.4.7pre5 on several of
these machines and they all locked up after an hour.


Box configuration:
dual 1ghz box, 1gig of RAM, 4 x 15k RPM scsi drives in RAID 0 on 1
reiserfs partition, aic7xxx host, eepro100 and 3com gigabit card
kernel NFSD

the reiserfs parition contains about 44gigs of small files (200bytes-20k)

data access is also random access:
nfsstat -o rc
Server reply cache:
hits       misses     nocache
1337       456292     14301729


On kernel 2.4.7pre6 and below we had majors problems where nfsd would
appear to freeze in the "down" state reported by WCHAN and the load would
jump to the number of NFSD processes.  Throughput would go from several
megabytes per second to a few kilobytes per second on NFS.  The partiton
was still very readable and writeable though on the machine locally.  The
box would stay in the state for several minutes to an hour then magically
resume nfs transfers.  Kernel 2.4.8pre4 appears to have made this much
better.

Hope this helps


