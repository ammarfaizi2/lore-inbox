Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266860AbRGKWne>; Wed, 11 Jul 2001 18:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266854AbRGKWnY>; Wed, 11 Jul 2001 18:43:24 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:61431 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S266846AbRGKWnV>; Wed, 11 Jul 2001 18:43:21 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200107112242.f6BMg1M8009860@webber.adilger.int>
Subject: [PATCH] comment out obsolete ext2 code
To: torvalds@transmeta.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Wed, 11 Jul 2001 16:42:01 -0600 (MDT)
CC: Linux kernel development list <linux-kernel@vger.kernel.org>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch comments out code in ext2 which is obsolete, or was never used
in the first place (i.e. future vision stuff, etc).  In particular, the
inode->i_attr_flags field is not used anywhere else in the kernel, and it
is only set, but not referenced in the ext2 code.  It could probably be
deleted entirely (saving 4 bytes in struct inode).

Similarly, the ext2_notify_change() function is not currently in use (but
it may be needed at some time in the future).  However, per previous
discussions with Stephen on ext2-devel, the 2.4 code is buggy (2.2 code
was fixed), so even though it is currently unused I have fixed it.  The
brokenness in question also relates to i_attr_flags, so it could also
be deleted entirely if that is the goal.

There are a couple of other obsolete bits not removed by this patch,
namely i_osync, and i_new_inode in ext2_inode_info.  Another day...

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
