Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbVILUPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbVILUPt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 16:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbVILUP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 16:15:26 -0400
Received: from mail.kroah.org ([69.55.234.183]:25797 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932203AbVILUPX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 16:15:23 -0400
Cc: ecashin@coraid.com
Subject: [PATCH] aoe [1/2]: support 16 AoE slot addresses per AoE shelf
In-Reply-To: <20050912201035.GA20330@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 12 Sep 2005 13:11:04 -0700
Message-Id: <11265558641200@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] aoe [1/2]: support 16 AoE slot addresses per AoE shelf

Change the number of supported AoE slot addresses per AoE shelf
address to 16.

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit e39526e6e7a96904c9f1c85375d49ff437c18c44
tree b90a15c53758c7ea625c874cd4044842a6039656
parent 0a25e4d5647003a32ba5496f9d0f40ba9c1e3863
author Ed L Cashin <ecashin@coraid.com> Fri, 19 Aug 2005 16:54:43 -0400
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 09 Sep 2005 14:23:16 -0700

 Documentation/aoe/mkshelf.sh |    6 ++++--
 drivers/block/aoe/aoe.h      |   10 +++++-----
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/aoe/mkshelf.sh b/Documentation/aoe/mkshelf.sh
--- a/Documentation/aoe/mkshelf.sh
+++ b/Documentation/aoe/mkshelf.sh
@@ -8,13 +8,15 @@ fi
 n_partitions=${n_partitions:-16}
 dir=$1
 shelf=$2
+nslots=16
+maxslot=`echo $nslots 1 - p | dc`
 MAJOR=152
 
 set -e
 
-minor=`echo 10 \* $shelf \* $n_partitions | bc`
+minor=`echo $nslots \* $shelf \* $n_partitions | bc`
 endp=`echo $n_partitions - 1 | bc`
-for slot in `seq 0 9`; do
+for slot in `seq 0 $maxslot`; do
 	for part in `seq 0 $endp`; do
 		name=e$shelf.$slot
 		test "$part" != "0" && name=${name}p$part
diff --git a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
--- a/drivers/block/aoe/aoe.h
+++ b/drivers/block/aoe/aoe.h
@@ -7,12 +7,12 @@
  * default is 16, which is 15 partitions plus the whole disk
  */
 #ifndef AOE_PARTITIONS
-#define AOE_PARTITIONS 16
+#define AOE_PARTITIONS (16)
 #endif
 
-#define SYSMINOR(aoemajor, aoeminor) ((aoemajor) * 10 + (aoeminor))
-#define AOEMAJOR(sysminor) ((sysminor) / 10)
-#define AOEMINOR(sysminor) ((sysminor) % 10)
+#define SYSMINOR(aoemajor, aoeminor) ((aoemajor) * NPERSHELF + (aoeminor))
+#define AOEMAJOR(sysminor) ((sysminor) / NPERSHELF)
+#define AOEMINOR(sysminor) ((sysminor) % NPERSHELF)
 #define WHITESPACE " \t\v\f\n"
 
 enum {
@@ -83,7 +83,7 @@ enum {
 
 enum {
 	MAXATADATA = 1024,
-	NPERSHELF = 10,
+	NPERSHELF = 16,		/* number of slots per shelf address */
 	FREETAG = -1,
 	MIN_BUFS = 8,
 };

