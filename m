Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265366AbRGBRjS>; Mon, 2 Jul 2001 13:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265363AbRGBRjI>; Mon, 2 Jul 2001 13:39:08 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:26629 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S265355AbRGBRiz>; Mon, 2 Jul 2001 13:38:55 -0400
Date: Mon, 2 Jul 2001 19:38:47 +0200
From: Jan Kara <jack@suse.cz>
To: Cliff Albert <cliff@oisec.net>
Cc: linux-kernel@vger.kernel.org, meskes@debian.org, mvw@planets.elm.net,
        Alan.Cox@linux.org
Subject: Re: quotaoff OOPS (2.4.5-ac22)
Message-ID: <20010702193847.A31821@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010702093202.A26673@oisec.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010702093202.A26673@oisec.net>; from cliff@oisec.net on Mon, Jul 02, 2001 at 09:32:02AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

> After issuing quotaoff -a the kernel oopses. All filesystems which have quotas are ext2 and are using the new quota system.
> 
  Seems like missing part of patch from Al Viro.. Attached patch should fix
it.

								Honza

--
Jan Kara <jack@suse.cz>
SuSE Labs

--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dquot.c.diff"

--- linux/fs/dquot.c	Mon Jul  2 19:29:31 2001
+++ linux/fs/dquot.c	Mon Jul  2 19:30:37 2001
@@ -1889,7 +1889,7 @@
 }
 
 /* Function in inode.c - remove pointers to dquots in icache */
-extern void remove_dquot_ref(kdev_t, short);
+extern void remove_dquot_ref(struct super_block *, short);
 
 /*
  * Turn quota off on a device. type == -1 ==> quotaoff for all types (umount)
@@ -1913,7 +1913,7 @@
 		reset_enable_flags(dqopt, cnt);
 
 		/* Note: these are blocking operations */
-		remove_dquot_ref(sb->s_dev, cnt);
+		remove_dquot_ref(sb, cnt);
 		invalidate_dquots(sb->s_dev, cnt);
 		/* When invalidate is finished there are no users of any dquot of our interest... */
 		if (quotafile_info_dirty(sb_dqopt(sb)->info+cnt))

--6c2NcOVqGQ03X4Wi--
