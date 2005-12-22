Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965091AbVLVE4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965091AbVLVE4H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 23:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965072AbVLVEvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 23:51:11 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:26064 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965079AbVLVEup
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 23:50:45 -0500
To: linux-m68k@vger.kernel.org
Subject: [PATCH 20/36] m68k: compile fixes for dmasound (static vs. extern)
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EpIPc-0004sO-Kt@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 22 Dec 2005 04:50:44 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1133440636 -0500

sound/oss/dmasound/dmasound_atari.c has static expand_bal
sound/oss/dmasound/dmasound_q40.c has static expand_bal
sound/oss/dmasound/dmasound_awacs.c has non-static expand_bal
sound/oss/dmasound/trans_16.c uses expand_bal from dmasound_awacs.c
all 4 include dmasound.h; extern for expand_bal used to be there,
which is a bloody bad idea, considering _atari and _q40.  Moved the
extern to trans_16.c.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 sound/oss/dmasound/dmasound.h |    1 -
 sound/oss/dmasound/trans_16.c |    1 +
 2 files changed, 1 insertions(+), 1 deletions(-)

b7b3e71a257ec79c4894ece1f65806cc1c9af4c2
diff --git a/sound/oss/dmasound/dmasound.h b/sound/oss/dmasound/dmasound.h
index 222014c..a1b0b92 100644
--- a/sound/oss/dmasound/dmasound.h
+++ b/sound/oss/dmasound/dmasound.h
@@ -270,7 +270,6 @@ extern int dmasound_catchRadius;
 #define SW_INPUT_VOLUME_SCALE	4
 #define SW_INPUT_VOLUME_DEFAULT	(128 / SW_INPUT_VOLUME_SCALE)
 
-extern int expand_bal;	/* Balance factor for expanding (not volume!) */
 extern int expand_read_bal;	/* Balance factor for reading */
 extern uint software_input_volume; /* software implemented recording volume! */
 
diff --git a/sound/oss/dmasound/trans_16.c b/sound/oss/dmasound/trans_16.c
index 23562e9..ca973ac 100644
--- a/sound/oss/dmasound/trans_16.c
+++ b/sound/oss/dmasound/trans_16.c
@@ -17,6 +17,7 @@
 #include <asm/uaccess.h>
 #include "dmasound.h"
 
+extern int expand_bal;	/* Balance factor for expanding (not volume!) */
 static short dmasound_alaw2dma16[] ;
 static short dmasound_ulaw2dma16[] ;
 
-- 
0.99.9.GIT

