Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275126AbRKSIcS>; Mon, 19 Nov 2001 03:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275012AbRKSIcI>; Mon, 19 Nov 2001 03:32:08 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:26614 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S274368AbRKSIb7>;
	Mon, 19 Nov 2001 03:31:59 -0500
Date: Mon, 19 Nov 2001 01:31:52 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: viro@math.psu.edu, lvm-devel@sistina.com
Subject: [PATCH] undo LVM change from merge
Message-ID: <20011119013151.Z1308@lynx.no>
Mail-Followup-To: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, viro@math.psu.edu,
	lvm-devel@sistina.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, Alan, Al,
it appears that when merging Alan's updated LVM code into mainline, it
reverted a change (from Al to avoid race conditions with block device
modules, I think).  The patch fragment below should be re-applied:

@@ -400,6 +400,7 @@
 /* block device operations structure needed for 2.3.38? and above */
 struct block_device_operations lvm_blk_dops =
 {
+       owner:          THIS_MODULE,
        open:           lvm_blk_open,
        release:        lvm_blk_close,
        ioctl:          lvm_blk_ioctl,

It isn't in the LVM CVS yet, but if it should be I will put it there so
we don't lose it again.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

