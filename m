Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265196AbTAAXdO>; Wed, 1 Jan 2003 18:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265211AbTAAXdO>; Wed, 1 Jan 2003 18:33:14 -0500
Received: from pd208.katowice.sdi.tpnet.pl ([213.76.228.208]:40592 "EHLO finwe")
	by vger.kernel.org with ESMTP id <S265196AbTAAXdL>;
	Wed, 1 Jan 2003 18:33:11 -0500
Date: Thu, 2 Jan 2003 00:41:41 +0100
From: Jacek Kawa <jfk@zeus.polsl.gliwice.pl>
To: linux-kernel@vger.kernel.org
Subject: ext3 fs corruption, Linux 2.4.20 (patched)
Message-ID: <20030101234141.GA21639@finwe.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: Kreatorzy Kreacji Bialej
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I've got latest 2.4.20 with ext3 patches
(http://www.uwsg.indiana.edu/hypermail/linux/kernel/0212.1/1698.html)
and preempt patch. 

Description:
------------

Something bad (during reboot; probably problem with apm) happened yesterday and rootfs 
was not clearly umounted. 

According to logs fs had been recovered, but few files from /lib, /bin
and /etc were corrupted. I booted from cd and run e2fsck (1.27); fs was marked clean, 
so I had to use -f. I got few "DTIME" errors (I skipped them) and many "duplicate 
inode(block?) record". I'm afraid I answered <y> few times, before I realized, that 
e2fsck might have not been up to date and broke process, then I dd-ed partition, found 
working system with newer e2fsck and here is output:

<e2fsck -v -n -f /dev/hda>

Pass 1: Checking inodes, blocks, and sizes
Deleted inode 26257 has zero dtime.  Fix? no

Special (device/socket/fifo) inode 26260 has non-zero size.  Fix? no

Deleted inode 26261 has zero dtime.  Fix? no

Inode 26262 is in use, but has dtime set.  Fix? no

Inode 26263 is in use, but has dtime set.  Fix? no

Inode 26263 has imagic flag set.  Clear? no

Inode 26264 is in use, but has dtime set.  Fix? no

Inode 26264 has imagic flag set.  Clear? no

Inode 26260, i_size is 4624369984565411840, should be 0.  Fix? no

Inode 26258, i_size is 322122547275, should be 0.  Fix? no

Inode 26264, i_size is 142693709880, should be 0.  Fix? no

Inode 26264, i_blocks is 1768189039, should be 0.  Fix? no

Inode 26263, i_size is 3543615398094045184, should be 0.  Fix? no

Inode 26263, i_blocks is 25, should be 0.  Fix? no

Inode 26262 has compression flag set on filesystem without compression support.  Clear? no

Inode 26262, i_size is 13835032388699190200, should be 0.  Fix? no

Inode 26262, i_blocks is 141844880, should be 0.  Fix? no

Pass 2: Checking directory structure
Inode 26258 (/bin/run-parts) has a bad mode (0113).
Clear? no

i_faddr for inode 26258 (/bin/run-parts) is 75, should be zero.
Clear? no

i_frag for inode 26258 (/bin/run-parts) is 70, should be zero.
Clear? no

i_file_acl for inode 26258 (/bin/run-parts) is 120, should be zero.
Clear? no

Entry 'run-parts' in /bin (26209) has an incorrect filetype (was 1, should be 0).
Fix? no

Entry 'chown' in /bin (26209) has deleted/unused inode 26259.  Clear? no

Inode 26262 (/bin/cp) has a bad mode (00).
Clear? no

i_faddr for inode 26262 (/bin/cp) is 141187524, should be zero.
Clear? no

i_file_acl for inode 26262 (/bin/cp) is 135900092, should be zero.
Clear? no

Extended attribute block for inode 26262 (/bin/cp) is is invalid (135900092).
Clear? no

Entry 'cp' in /bin (26209) has an incorrect filetype (was 1, should be 0).
Fix? no

Entry 'su' in /bin (26209) has deleted/unused inode 26261.  Clear? no

Entry 'ping' in /bin (26209) has an incorrect filetype (was 1, should be 6).
Fix? no

Inode 26264 (/bin/date) is an illegal block device.
Clear? no

i_faddr for inode 26264 (/bin/date) is 141969288, should be zero.
Clear? no

i_frag for inode 26264 (/bin/date) is 100, should be zero.
Clear? no

i_fsize for inode 26264 (/bin/date) is 97, should be zero.
Clear? no

i_file_acl for inode 26264 (/bin/date) is 12589, should be zero.
Clear? no

Entry 'date' in /bin (26209) has an incorrect filetype (was 1, should be 0).
Fix? no

Inode 26263 (/bin/more) has a bad mode (071).
Clear? no

i_faddr for inode 26263 (/bin/more) is 808529200, should be zero.
Clear? no

i_frag for inode 26263 (/bin/more) is 48, should be zero.
Clear? no

i_fsize for inode 26263 (/bin/more) is 45, should be zero.
Clear? no

i_file_acl for inode 26263 (/bin/more) is 1634938220, should be zero.
Clear? no

Extended attribute block for inode 26263 (/bin/more) is is invalid (1634938220).
Clear? no

Entry 'more' in /bin (26209) has an incorrect filetype (was 1, should be 0).
Fix? no

Entry 'libe2p.so.2' in /lib (40380) has an incorrect filetype (was 7, should be 1).
Fix? no

Entry 'libdb.so.2' in /lib (40380) has an incorrect filetype (was 7, should be 1).
Fix? no

Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Inode 26258 ref count is 16418, should be 1.  Fix? no

Inode 26260 ref count is 16420, should be 1.  Fix? no

Inode 26262 ref count is 2164, should be 1.  Fix? no

Inode 26263 ref count is 2154, should be 1.  Fix? no

Inode 26264 ref count is 25133, should be 1.  Fix? no

Pass 5: Checking group summary information
Block bitmap differences:  +273 +(366--368) +(375--378) +385 +690 -(106787--106813) -(106856--106871) -(107206--107234) -(107897--107971) -(107988--107990) -(109431--109451) -(109485--109487) -(164257--164259) -(164280--164283) -(164426--164441) -164516 -164527 -(168356--168374)
Fix? no

Inode bitmap differences:  -26259 -26261
Fix? no


root: ********** WARNING: Filesystem still has errors **********


    9175 inodes used (13%)
     271 non-contiguous inodes (3.0%)
         # of inodes with ind/dind/tind blocks: 573/19/4
   59790 blocks used (22%)
       0 bad blocks
       0 large files

    3343 regular files
    1015 directories
     964 character device files
    3254 block device files
      10 fifos
      11 links
     573 symbolic links (570 fast symbolic links)
       1 sockets
--------
    9177 files


</quote>


System:
-------
Debian SID; 
tune2fs: 1.32 (09-Nov-2002)
gcc:     2.95.4

config, dmesg and related logs:

http://zeus.polsl.gliwice.pl/~jfk/kernel/dmesg.gz
http://zeus.polsl.gliwice.pl/~jfk/kernel/config.gz
http://zeus.polsl.gliwice.pl/~jfk/kernel/logs.gz

#uname -a
Linux finwe 2.4.20+p #1 wto gru 17 20:44:10 CET 2002 i686 unknown unknown GNU/Linux

Patches:

sync_fs.patch
sync_fs-fix.patch
ext3-use-after-free.patch
preempt-kernel-rml-2.4.20-1.patch

#cat /proc/partitions

major minor  #blocks  name

  22    64     662874 hdd
   3     0   30015216 hda
   3     1      24066 hda1
   3     2     265072 hda2 <- root fs
   3     3          1 hda3
   3     4   12096945 hda4
   3     5     128488 hda5
   3     6    3076416 hda6
   3     7    1028128 hda7
   3     8    2048256 hda8
   3     9    2562336 hda9
   3    10     730926 hda10
   3    11    8048533 hda11


/etc/fstab hda and Linux related:

/dev/hda2	/		ext3	defaults,errors=remount-ro	0	1
/dev/hda5	none		swap	sw				0	0
/dev/hda1 	/boot 		ext2 	defaults,ro			0	2
/dev/hda6 	/usr 		ext3	defaults,ro			0	2
/dev/hda7 	/var 		ext3 	defaults,nosuid,nodev		0	2
/dev/hda8 	/pub 		ext3 	defaults,nosuid,nodev		0	2
/dev/hda9 	/home 		ext3 	defaults,nosuid,nodev		0	2
/dev/hda10 	/disc		ext3	defaults,ro			0	0


 Happy New Year ! :-)


PS. e2fsck did not help much with corrupted binaries, but I've got
    everything working now  :)

PPS. I still have dd-image of corrupted fs.

PPPS. Sorry if my English is as bad as I think it is.

-- 
Jacek Kawa, jfk@zeus.polsl.gliwice.pl
