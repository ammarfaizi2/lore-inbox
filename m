Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbTHSWsO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 18:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbTHSWsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 18:48:14 -0400
Received: from mta02-svc.ntlworld.com ([62.253.162.42]:60546 "EHLO
	mta02-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S261322AbTHSWsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 18:48:09 -0400
Subject: NTFS bugfix against 2.4.22-rc2-ac3
From: Richard Russon <ntfs@flatcap.org>
To: Alan Cox <alan@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1061333284.24761.5.camel@ipa.flatcap.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 19 Aug 2003 23:48:04 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

This patch fixes some debug-only macros which have the wrong number of parameters.
It is in addition to djgera's recent bugfix (to fix compilation warnings).
His patch didn't create any new bugs, but it did transmute a few existing ones.

Cheers,
  FlatCap / Richard Russon
  ntfs@flatcap.org


diff -urN linux-2.4.22-rc2-ac3/fs/ntfs/dir.c linux-2.4.22-rc2-ac3-ntfs/fs/ntfs/dir.c
--- linux-2.4.22-rc2-ac3/fs/ntfs/dir.c	2003-08-19 13:52:13.000000000 +0100
+++ linux-2.4.22-rc2-ac3-ntfs/fs/ntfs/dir.c	2003-08-19 13:52:48.000000000 +0100
@@ -881,8 +881,8 @@
 			/* filldir signalled us to stop. */
 			ntfs_debug(DEBUG_DIR3, "%s(): Unsorted 6: cb returned "
 					"%i, returning 0, p_high 0x%x, "
-					"p_low 0x%x.\n", __FUNCTION__, *p_high,
-					*p_low);
+					"p_low 0x%x.\n", __FUNCTION__, err,
+					*p_high, *p_low);
 			ntfs_free(buf);
 			return 0;
 		}
diff -urN linux-2.4.22-rc2-ac3/fs/ntfs/inode.c linux-2.4.22-rc2-ac3-ntfs/fs/ntfs/inode.c
--- linux-2.4.22-rc2-ac3/fs/ntfs/inode.c	2003-08-19 13:52:13.000000000 +0100
+++ linux-2.4.22-rc2-ac3-ntfs/fs/ntfs/inode.c	2003-08-19 13:52:48.000000000 +0100
@@ -1407,7 +1407,7 @@
 	}
 	/* Reuse rl_size as the current position index into rl. */
 	rl_size = *r1len - 1;
-	ntfs_debug(DEBUG_OTHER, "%s(): rl_size = %i.\n", __FUNCTION__);
+	ntfs_debug(DEBUG_OTHER, "%s(): rl_size = %i.\n", __FUNCTION__,rl_size);
 	/* Coalesce neighbouring elements, if present. */
 	rl2_pos = 0;
 	if (rl[rl_size].lcn + rl[rl_size].len == rl2[rl2_pos].lcn) {
diff -urN linux-2.4.22-rc2-ac3/fs/ntfs/super.c linux-2.4.22-rc2-ac3-ntfs/fs/ntfs/super.c
--- linux-2.4.22-rc2-ac3/fs/ntfs/super.c	2003-08-19 13:52:13.000000000 +0100
+++ linux-2.4.22-rc2-ac3-ntfs/fs/ntfs/super.c	2003-08-19 13:52:48.000000000 +0100
@@ -1013,7 +1013,8 @@
 			ntfs_debug(DEBUG_OTHER, "%s(): Continuing "
 					"outer while loop, pass = 2, "
 					"zone_start = 0x%x, zone_end = 0x%x, "
-					"buf_pos = 0x%x.\n", __FUNCTION__);
+					"buf_pos = 0x%x.\n", __FUNCTION__,
+					zone_start, zone_end, buf_pos);
 			continue;
 		} /* pass == 2 */
 done_zones_check:
@@ -1212,9 +1213,8 @@
 				"= 0x%x, continuing outer while loop.\n",
 				__FUNCTION__, mft_zone_size,
 				vol->mft_zone_start, vol->mft_zone_end,
-				vol->mft_zone_pos, search_zone, pass,
-				done_zones, zone_start, zone_end,
-				vol->data1_zone_pos);
+				vol->mft_zone_pos, done_zones, zone_start,
+				zone_end, vol->data1_zone_pos);
 	}
 	ntfs_debug(DEBUG_OTHER, "%s(): After outer while loop.\n",
 			__FUNCTION__);




