Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267439AbUG2OrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267439AbUG2OrO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 10:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267504AbUG2OqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:46:11 -0400
Received: from styx.suse.cz ([82.119.242.94]:22422 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264917AbUG2OIK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:10 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 21/47] Remove OSB4/Profusion hack in i8042
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:55 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <10911101951620@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <10911101951574@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1722.110.26, 2004-06-06 20:13:56+02:00, vojtech@suse.cz
  input: Remove OSB4/Profusion hack in i8042, as it's handled by
         DMI blacklist now.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 i8042.c |   11 +----------
 1 files changed, 1 insertion(+), 10 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Thu Jul 29 14:40:42 2004
+++ b/drivers/input/serio/i8042.c	Thu Jul 29 14:40:42 2004
@@ -481,17 +481,8 @@
 	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != 0xa9)
 		return -1;
 	param = 0xa4;
-	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param == 0x5b) {
-
-/*
- * Do another loop test with the 0x5a value. Doing anything else upsets
- * Profusion/ServerWorks OSB4 chipsets.
- */
-
-		param = 0x5a;
-		i8042_command(&param, I8042_CMD_AUX_LOOP);
+	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param == 0x5b)
 		return -1;
-	}
 
 	if (mux_version)
 		*mux_version = ~param;

