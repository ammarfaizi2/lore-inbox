Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbVA2TIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbVA2TIi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 14:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVA2TIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 14:08:38 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:59086 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261530AbVA2TIF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 14:08:05 -0500
Subject: [PATCH 1/3] Fix MUX mode disabling.
In-Reply-To: <20050129164450.GA14053@ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sat, 29 Jan 2005 17:45:28 +0100
Message-Id: <1107017128686@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/for-linus

===================================================================

ChangeSet@1.1977.1.1, 2005-01-28 21:11:52+01:00, vojtech@silver.ucw.cz
  input: Fix MUX mode disabling.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 i8042.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	2005-01-29 17:37:27 +01:00
+++ b/drivers/input/serio/i8042.c	2005-01-29 17:37:27 +01:00
@@ -482,7 +482,7 @@
 	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != 0x0f)
 		return -1;
 	param = mode ? 0x56 : 0xf6;
-	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != 0xa9)
+	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != (mode ? 0xa9 : 0x09))
 		return -1;
 	param = mode ? 0xa4 : 0xa5;
 	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param == (mode ? 0x5b : 0x5a))
@@ -787,7 +787,8 @@
  * Disable MUX mode if present.
  */
 
-	i8042_set_mux_mode(0, NULL);
+	if (i8042_mux_present)
+		i8042_set_mux_mode(0, NULL);
 
 /*
  * Restore the original control register setting.

