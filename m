Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbTIYQ4S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 12:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbTIYQyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 12:54:20 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:39127 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S261586AbTIYQug convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 12:50:36 -0400
Subject: [PATCH 7/8] Fix handling of rotated Synaptics touchpads.
In-Reply-To: <1064508612197@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Thu, 25 Sep 2003 18:50:12 +0200
Message-Id: <10645086122225@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org, dtor_core@ameritech.net, petero2@telia.com,
       Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1347, 2003-09-25 18:29:15+02:00, petero2@telia.com
  input: Fix broken handling of rotated Synaptics touchpads.
         The infoRot180 and infoPortrait bits are for information
         only. The touchpad uses the same X/Y coordinate system
         regardless of the orientation, so the software shouldn't
         care about these bits.


 synaptics.c |    5 +----
 1 files changed, 1 insertion(+), 4 deletions(-)

===================================================================

diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	Thu Sep 25 18:37:05 2003
+++ b/drivers/input/mouse/synaptics.c	Thu Sep 25 18:37:05 2003
@@ -528,10 +528,7 @@
 	/* Post events */
 	if (hw.z > 0) {
 		input_report_abs(dev, ABS_X, hw.x);
-		if (SYN_MODEL_ROT180(priv->model_id))
-			input_report_abs(dev, ABS_Y, YMAX_NOMINAL + YMIN_NOMINAL - hw.y);
-		else
-			input_report_abs(dev, ABS_Y, hw.y);
+		input_report_abs(dev, ABS_Y, YMAX_NOMINAL + YMIN_NOMINAL - hw.y);
 	}
 	input_report_abs(dev, ABS_PRESSURE, hw.z);
 

