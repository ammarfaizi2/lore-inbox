Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270767AbTHAONr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 10:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270773AbTHAONb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 10:13:31 -0400
Received: from h24-86-78-151.ed.shawcable.net ([24.86.78.151]:37250 "HELO
	alpha.home") by vger.kernel.org with SMTP id S270767AbTHAONW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 10:13:22 -0400
From: "Gordon Larsen" <glarsen@alpha.homedns.org>
To: <linux-kernel@vger.kernel.org>
Subject: Disk speed differences under 2.6.0
Date: Fri, 1 Aug 2003 07:54:26 -0600
Message-ID: <IBEJLCACHGEIBMFJACBEEEJICKAA.glarsen@alpha.homedns.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-reply-to: <0E3FA95632D6D047BA649F95DAB60E570185F3CF@EXA-ATLANTA.se.lsil.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My apologies if this has already been discussed - but has anyone noticed
disk I/O speed differences under 2.6.0 as compared to 2.4.20?  My system has
an ASUS A7V333 MB with 768M Ram, a 1300MHz Duron, three 40GB Maxtor drives
running linux software raid.  See the screen capture below:

-----------------------------
2.4.20-19.9 -----------------------------------------------
[root@alpha root]# uname -a
Linux alpha 2.4.20-19.9 #1 Mon Jul 28 18:59:34 MDT 2003 i686 athlon i386
GNU/Linux
[root@alpha root]# hdparm -t /dev/md0

/dev/md0:
 Timing buffered disk reads:  64 MB in  2.90 seconds = 22.07 MB/sec
[root@alpha root]# hdparm -t /dev/md1

/dev/md1:
 Timing buffered disk reads:  64 MB in  1.66 seconds = 38.55 MB/sec
[root@alpha root]# hdparm -t /dev/md2

/dev/md2:
 Timing buffered disk reads:  64 MB in  0.96 seconds = 66.67 MB/sec
[root@alpha root]# hdparm -t /dev/md3

/dev/md3:
 Timing buffered disk reads:  64 MB in  1.74 seconds = 36.78 MB/sec
[root@alpha root]# hdparm -t /dev/md4

/dev/md4:
 Timing buffered disk reads:  64 MB in  1.74 seconds = 36.78 MB/sec
[root@alpha root]# hdparm -t /dev/md5

/dev/md5:
 Timing buffered disk reads:  64 MB in  1.68 seconds = 38.10 MB/sec
[root@alpha root]# hdparm -t /dev/md6

/dev/md6:
 Timing buffered disk reads:  64 MB in  1.70 seconds = 37.65 MB/sec

-----------------------------
2.6.0-0.test.2.1.28 -----------------------------------------------

[root@alpha root]# uname -a
Linux alpha 2.6.0-0.test2.1.28custom #1 Thu Jul 31 20:02:20 MDT 2003 i686
athlon i386 GNU/Linux
[root@alpha root]# hdparm -t /dev/md0

/dev/md0:
 Timing buffered disk reads:  64 MB in  2.67 seconds = 24.00 MB/sec
[root@alpha root]# hdparm -t /dev/md1

/dev/md1:
 Timing buffered disk reads:  64 MB in  1.92 seconds = 33.37 MB/sec
[root@alpha root]# hdparm -t /dev/md2

/dev/md2:
 Timing buffered disk reads:  64 MB in  1.37 seconds = 46.79 MB/sec
[root@alpha root]# hdparm -t /dev/md3

/dev/md3:
 Timing buffered disk reads:  64 MB in  2.23 seconds = 28.69 MB/sec
[root@alpha root]# hdparm -t /dev/md4

/dev/md4:
 Timing buffered disk reads:  64 MB in  2.20 seconds = 29.07 MB/sec
[root@alpha root]# hdparm -t /dev/md5

/dev/md5:
 Timing buffered disk reads:  64 MB in  2.03 seconds = 31.45 MB/sec
[root@alpha root]# hdparm -t /dev/md6

/dev/md6:
 Timing buffered disk reads:  64 MB in  1.99 seconds = 32.23 MB/sec

-----------------------------
Mounts -----------------------------------------------

[root@alpha root]# mount
/dev/md0 on / type ext3 (rw)
none on /proc type proc (rw)
usbdevfs on /proc/bus/usb type usbdevfs (rw)
/dev/md1 on /boot type ext3 (rw)
none on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/md3 on /home type ext3 (rw)
none on /dev/shm type tmpfs (rw)
/dev/md6 on /tmp type ext3 (rw)
/dev/md4 on /usr type ext3 (rw)
/dev/md5 on /var type ext3 (rw)

----------------------------- MD Device
dump -----------------------------------------------

[root@alpha root]# lsraid -R -p
# md device [dev 9, 2] /dev/md2 queried online
raiddev /dev/md2
        raid-level              0
        nr-raid-disks           2
        nr-spare-disks          0
        persistent-superblock   1
        chunk-size              64

        device          /dev/hde1
        raid-disk               0
        device          /dev/hdg2
        raid-disk               1

# md device [dev 9, 1] /dev/md1 queried online
raiddev /dev/md1
        raid-level              1
        nr-raid-disks           2
        nr-spare-disks          0
        persistent-superblock   1
        chunk-size              64

        device          /dev/hde2
        raid-disk               0
        device          /dev/hdg1
        raid-disk               1

# md device [dev 9, 4] /dev/md4 queried online
raiddev /dev/md4
        raid-level              5
        nr-raid-disks           3
        nr-spare-disks          0
        persistent-superblock   1
        chunk-size              64

        device          /dev/hde3
        raid-disk               0
        device          /dev/hdg3
        raid-disk               1
        device          /dev/hdh3
        raid-disk               2

# md device [dev 9, 3] /dev/md3 queried online
raiddev /dev/md3
        raid-level              5
        nr-raid-disks           3
        nr-spare-disks          0
        persistent-superblock   1
        chunk-size              64

        device          /dev/hde5
        raid-disk               0
        device          /dev/hdg5
        raid-disk               1
        device          /dev/hdh5
        raid-disk               2

# md device [dev 9, 5] /dev/md5 queried online
raiddev /dev/md5
        raid-level              5
        nr-raid-disks           3
        nr-spare-disks          0
        persistent-superblock   1
        chunk-size              64

        device          /dev/hde6
        raid-disk               0
        device          /dev/hdg6
        raid-disk               1
        device          /dev/hdh6
        raid-disk               2

# md device [dev 9, 0] /dev/md0 queried online
raiddev /dev/md0
        raid-level              1
        nr-raid-disks           2
        nr-spare-disks          0
        persistent-superblock   1
        chunk-size              64

        device          /dev/hde7
        raid-disk               0
        device          /dev/hdg7
        raid-disk               1

# md device [dev 9, 6] /dev/md6 queried online
raiddev /dev/md6
        raid-level              5
        nr-raid-disks           3
        nr-spare-disks          0
        persistent-superblock   1
        chunk-size              64

        device          /dev/hde8
        raid-disk               0
        device          /dev/hdg8
        raid-disk               1
        device          /dev/hdh8
        raid-disk               2

[root@alpha root]#


--------------------------------
end-of-capture -----------------------------------------------

Cheers...Gord


