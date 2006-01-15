Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWAOTQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWAOTQJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 14:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWAOTQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 14:16:09 -0500
Received: from ns2.suse.de ([195.135.220.15]:42168 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750799AbWAOTQI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 14:16:08 -0500
From: Andreas Schwab <schwab@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Fix char vs. __s8 clash in ufs
X-Yow: HELLO, little boys!   Gimme a MINT TULIP!!  Let's do the BOSSA NOVA!!
Date: Sun, 15 Jan 2006 20:16:07 +0100
Message-ID: <jelkxhs3ns.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes this warning:

fs/ufs/super.c: In function ‘ufs_fill_super’:
fs/ufs/super.c:858: warning: case label value exceeds maximum value for type

which happens because __s8 != char.  These macros are used for struct
ufs_super_block.fs_clean which is declared as __s8.

Signed-off-by: Andreas Schwab <schwab@suse.de>

--- linux-2.6.15/include/linux/ufs_fs.h.~1~	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6.15/include/linux/ufs_fs.h	2006-01-15 20:10:47.002210901 +0100
@@ -148,11 +148,11 @@ typedef __u16 __bitwise __fs16;
 #define UFS_USEEFT  ((__u16)65535)
 
 #define UFS_FSOK      0x7c269d38
-#define UFS_FSACTIVE  ((char)0x00)
-#define UFS_FSCLEAN   ((char)0x01)
-#define UFS_FSSTABLE  ((char)0x02)
-#define UFS_FSOSF1    ((char)0x03)	/* is this correct for DEC OSF/1? */
-#define UFS_FSBAD     ((char)0xff)
+#define UFS_FSACTIVE  ((__s8)0x00)
+#define UFS_FSCLEAN   ((__s8)0x01)
+#define UFS_FSSTABLE  ((__s8)0x02)
+#define UFS_FSOSF1    ((__s8)0x03)	/* is this correct for DEC OSF/1? */
+#define UFS_FSBAD     ((__s8)0xff)
 
 /* From here to next blank line, s_flags for ufs_sb_info */
 /* directory entry encoding */

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
