Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267051AbRGIMXq>; Mon, 9 Jul 2001 08:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267050AbRGIMXg>; Mon, 9 Jul 2001 08:23:36 -0400
Received: from mail2.mx.voyager.net ([216.93.66.201]:8 "EHLO
	mail2.mx.voyager.net") by vger.kernel.org with ESMTP
	id <S267049AbRGIMXZ>; Mon, 9 Jul 2001 08:23:25 -0400
Message-ID: <3B49A3DB.A7FC143F@megsinet.net>
Date: Mon, 09 Jul 2001 07:30:19 -0500
From: "M.H.VanLeeuwen" <vanl@megsinet.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: andre@linux-ide.org
CC: linux-kernel@vger.kernel.org
Subject: Re: Does kernel require IDE enabled in BIOS to access HD, FS errors?
In-Reply-To: <3B492324.E36B86AF@linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre,

Yes, I'd be willing to test ideas / apply any patches you'd like to try.

I was running something like this to verify corruption:

while true ; do mount /dev/hdc1 /misc ;time cp -a /usr/local/soffice52 /misc ; \
             cd /misc && md5sum --check /tmp/soffice.md5 ; cd ; umount /misc; \
             e2fsck -f -y /dev/hdc1 ; done

md5sum reported errors on the order of 28-37 corrupted files out of 576 files
copy time ~11 minutes

with dd if=/dev/zero of=/dev/null running on another terminal, 
md5sum only reported 3-8 files corrupted.
copy time ~2.5 minutes

Thanks
Martin

BTW:

here is one of the many and more verbose reports of FS corruption from e2fsck:

e2fsck 1.20, 25-May-2001 for EXT2 FS 0.5b, 95/08/09
Pass 1: Checking inodes, blocks, and sizes
Inode 44863, i_size is 56832, should be 3502080.  Fix? yes
 
Inode 44863, i_blocks is 120, should be 144.  Fix? yes
 
Duplicate blocks found... invoking duplicate block passes.
Pass 1B: Rescan for duplicate/bad blocks
Duplicate/bad block(s) in inode 15303: 37632
Duplicate/bad block(s) in inode 44863: 37632 113 16
Pass 1C: Scan directories for inodes with dup blocks.
Pass 1D: Reconciling duplicate blocks
(There are 2 inodes containing duplicate/bad blocks.)
 
File /office52/share/basic/template.sbl (inode #44863, mod time Mon May  8 01:20:00 2000)
  has 3 duplicate block(s), shared with 2 file(s):
        <filesystem metadata>
        /office52/share/gallery/clipart/glas.wmf (inode #15303, mod time Mon May  8 01:20:00 2000)
Clone duplicate/bad blocks? yes
 
File /office52/share/gallery/clipart/glas.wmf (inode #15303, mod time Mon May  8 01:20:00 2000)
  has 1 duplicate block(s), shared with 2 file(s):
        <filesystem metadata>
        /office52/share/basic/template.sbl (inode #44863, mod time Mon May  8 01:20:00 2000)
Duplicated blocks already reassigned or cloned.
 
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
Free blocks count wrong for group #0 (30518, counted=30515).
Fix? yes
 
Free blocks count wrong (140220, counted=140217).
Fix? yes
 
 
/dev/hda1: ***** FILE SYSTEM WAS MODIFIED *****
/dev/hda1: 3036/104384 files (0.1% non-contiguous), 68179/208396 blocks


andre@linux-ide.org wrote:
> 
> Martin, you have an old beast that there are problems in how the chipset
> was deployed.
> How are you confirming the corruption against the various layers in the
> kernel?
> If you would like patches & tests to verify I will send them to you.
> 
> Cheers
> 
> --
> Andre Hedrick
> Linux ATA Development
> ASL Kernel Development
> -----------------------------------------------------------------------------
> ASL, Inc.                                     Toll free: 1-877-ASL-3535
> 1757 Houret Court                             Fax: 1-408-941-2071
> Milpitas, CA 95035                            Web: www.aslab.com
