Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965074AbWACX2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965074AbWACX2I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbWACX2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:28:06 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:63195 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965069AbWACX2B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:28:01 -0500
To: torvalds@osdl.org
Subject: [PATCH 19/41] m68k: compile fixes for dmasound (static vs. extern)
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Message-Id: <E1EtvZQ-0003NB-Ji@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 23:28:00 +0000
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

717f7904fb5e4fe3fb1eea98f6b8826ae12b3053
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

