Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751538AbVHYFUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbVHYFUr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 01:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbVHYFUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 01:20:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54987 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S1751531AbVHYFUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 01:20:46 -0400
To: geert@linux-m68k.org, torvalds@osdl.org
Subject: [PATCH] (2/22) compile fixes for dmsound (static vs. extern)
Cc: linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Message-Id: <E1E8ADO-0005aQ-VH@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 25 Aug 2005 06:23:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sound/oss/dmasound/dmasound_atari.c has static expand_bal
sound/oss/dmasound/dmasound_q40.c has static expand_bal
sound/oss/dmasound/dmasound_awacs.c has non-static expand_bal
sound/oss/dmasound/trans_16.c uses expand_bal from dmasound_awacs.c
all 4 include dmasound.h; extern for expand_bal used to be there,
which is a bloody bad idea, considering _atari and _q40.  Moved the
extern to trans_16.c.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc7-dmasound-lvalues/sound/oss/dmasound/dmasound.h RC13-rc7-dmasound-extern/sound/oss/dmasound/dmasound.h
--- RC13-rc7-dmasound-lvalues/sound/oss/dmasound/dmasound.h	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc7-dmasound-extern/sound/oss/dmasound/dmasound.h	2005-08-25 00:54:05.000000000 -0400
@@ -270,7 +270,6 @@
 #define SW_INPUT_VOLUME_SCALE	4
 #define SW_INPUT_VOLUME_DEFAULT	(128 / SW_INPUT_VOLUME_SCALE)
 
-extern int expand_bal;	/* Balance factor for expanding (not volume!) */
 extern int expand_read_bal;	/* Balance factor for reading */
 extern uint software_input_volume; /* software implemented recording volume! */
 
diff -urN RC13-rc7-dmasound-lvalues/sound/oss/dmasound/trans_16.c RC13-rc7-dmasound-extern/sound/oss/dmasound/trans_16.c
--- RC13-rc7-dmasound-lvalues/sound/oss/dmasound/trans_16.c	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc7-dmasound-extern/sound/oss/dmasound/trans_16.c	2005-08-25 00:54:05.000000000 -0400
@@ -17,6 +17,7 @@
 #include <asm/uaccess.h>
 #include "dmasound.h"
 
+extern int expand_bal;	/* Balance factor for expanding (not volume!) */
 static short dmasound_alaw2dma16[] ;
 static short dmasound_ulaw2dma16[] ;
 
