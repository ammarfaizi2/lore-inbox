Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263982AbTI2RoM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263979AbTI2Rn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:43:59 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:59064 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263976AbTI2RnC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:43:02 -0400
Subject: [PATCH 2/4] Fix atkbd_softrepeat kernel command line parameter.
In-Reply-To: <10648573712586@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Mon, 29 Sep 2003 19:42:55 +0200
Message-Id: <10648573751690@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1340.1.2, 2003-09-28 18:48:05+02:00, vojtech@suse.cz
  input: Fix atkbd_softrepeat kernel command line parameter.


 atkbd.c |    8 ++++++++
 1 files changed, 8 insertions(+)

===================================================================

diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Mon Sep 29 19:37:08 2003
+++ b/drivers/input/keyboard/atkbd.c	Mon Sep 29 19:37:08 2003
@@ -707,9 +707,17 @@
         if (ints[0] > 0) atkbd_reset = ints[1];
         return 1;
 }
+static int __init atkbd_setup_softrepeat(char *str)
+{
+        int ints[4];
+        str = get_options(str, ARRAY_SIZE(ints), ints);
+        if (ints[0] > 0) atkbd_softrepeat = ints[1];
+        return 1;
+}
 
 __setup("atkbd_set=", atkbd_setup_set);
 __setup("atkbd_reset", atkbd_setup_reset);
+__setup("atkbd_softrepeat=", atkbd_setup_softrepeat);
 #endif
 
 int __init atkbd_init(void)

