Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263276AbRFEHjw>; Tue, 5 Jun 2001 03:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263277AbRFEHjn>; Tue, 5 Jun 2001 03:39:43 -0400
Received: from [210.177.173.13] ([210.177.173.13]:13477 "EHLO
	hqmail.vtc.edu.hk") by vger.kernel.org with ESMTP
	id <S263276AbRFEHje>; Tue, 5 Jun 2001 03:39:34 -0400
Message-ID: <3B1C8C1B.E3946FE1@vtc.edu.hk>
Date: Tue, 05 Jun 2001 15:36:59 +0800
From: Nick Urbanik <nicku@vtc.edu.hk>
Organization: Institute of Vocational Education (Tsing Yi)
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Cannot mount old ext2 cdrom, but e2fsck shows no problems
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear folks,

I made 18 ext2 cdroms in October 1998 using an old (new at the time) Red
Hat system.  Now I can't mount them.  e2fsck shows no problems.  I also
can dd them to a file, then mount the file.  But I want to be able to
simply access them directly.  Current system: RH 7.1 with all updates.

Sorry, I can't remember the exact command I used to create the images.

I also want to better understand the output of dumpe2fs, and how to
relate this to mount.

I will be very grateful for any help that increases my understanding of
what is going on.

$ sudo mount -t ext2 /dev/scd0 /cdrom -o ro
mount: wrong fs type, bad option, bad superblock on /dev/scd0,
       or too many mounted file systems

Other symptoms:

$ sudo fdisk -l /dev/scd0
Note: sector size is 2048 (not 512)

Disk /dev/scd0: 0 heads, 0 sectors, 0 cylinders
Units = cylinders of 1 * 2048 bytes

Disk /dev/scd0 doesn't contain a valid partition table

$ e2fsck -v -n /dev/scd0 2>&1 | tee  e2fsck-v-n-dev-scd0
e2fsck 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
/dev/scd0 has gone too long without being checked, check forced.
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information

   12714 inodes used (7%)
      78 non-contiguous inodes (0.6%)
         # of inodes with ind/dind/tind blocks: 2692/233/0
  523394 blocks used (78%)
       0 bad blocks

   11306 regular files
    1117 directories
       0 character device files
       0 block device files
       0 fifos
       0 links
     282 symbolic links (282 fast symbolic links)
       0 sockets
--------
   12705 files

$ dumpe2fs -h /dev/scd0
dumpe2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
Filesystem volume name:   <none>
Last mounted on:          <not available>
Filesystem UUID:          7eb1b040-59f7-11d2-9e35-002018530df2
Filesystem magic number:  0xEF53
Filesystem revision #:    0 (original)
Filesystem features:     (none)
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              166624
Block count:              665600
Reserved block count:     33280
Free blocks:              142206
Free inodes:              153910
First block:              1
Block size:               1024
Fragment size:            1024
Blocks per group:         8192
Fragments per group:      8192
Inodes per group:         2032
Inode blocks per group:   254
Last mount time:          Fri Oct  2 21:06:45 1998
Last write time:          Fri Oct  2 23:53:28 1998
Mount count:              3
Maximum mount count:      20
Last checked:             Fri Oct  2 20:57:46 1998
Check interval:           15552000 (6 months)
Next check after:         Wed Mar 31 20:57:46 1999
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)

(I originally sent this to the Red Hat list, but there was no response).

--
Nick Urbanik, Dept. of Information & Communications Technology
Hong Kong Institute of Vocational Education (Tsing Yi)
email: nicku@vtc.edu.hk
Tel:   (852) 2436 8576, (852) 2436 8579   Fax: (852) 2436 8526
pgp ID: 7529555D fingerprint: 53 B6 6D 73 52 EE 1F EE EC F8 21 98 45 1C
23 7B
