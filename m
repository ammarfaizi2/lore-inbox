Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264424AbUFGLzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264424AbUFGLzg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 07:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264414AbUFGLzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 07:55:36 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:49792 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264424AbUFGLzV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:55:21 -0400
To: torvalds@osdl.org, akpm@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
Message-Id: <10866093523469@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <10866093523713@twilight.ucw.cz>
Mime-Version: 1.0
Date: Mon, 7 Jun 2004 13:55:52 +0200
Subject: [PATCH 2/39] input: Profusion/ServerWorks chipset workaround in i8042.c for Ingo Molnar.
X-Mailer: gregkh_patchbomb_levon_offspring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input-for-linus

===================================================================

ChangeSet@1.1371.628.2, 2004-03-26 16:27:05+01:00, vojtech@suse.cz
  input: Profusion/ServerWorks chipset workaround in i8042.c for Ingo Molnar.


 i8042.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	2004-06-07 13:13:43 +02:00
+++ b/drivers/input/serio/i8042.c	2004-06-07 13:13:43 +02:00
@@ -474,8 +474,17 @@
 	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != 0xa9)
 		return -1;
 	param = 0xa4;
-	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param == 0x5b)
+	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param == 0x5b) {
+
+/*
+ * Do another loop test with the 0x5a value. Doing anything else upsets
+ * Profusion/ServerWorks OSB4 chipsets.
+ */
+
+		param = 0x5a;
+		i8042_command(&param, I8042_CMD_AUX_LOOP);
 		return -1;
+	}
 
 	if (mux_version)
 		*mux_version = ~param;

