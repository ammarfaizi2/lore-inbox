Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265396AbUG2O0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265396AbUG2O0h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 10:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264763AbUG2OJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:09:15 -0400
Received: from styx.suse.cz ([82.119.242.94]:32662 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S265074AbUG2OIO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:14 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 47/47] Check the range for HIDIOC?USAGES num_values.
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:56 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <10911101963121@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <1091110196143@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1859, 2004-07-29 14:13:12+02:00, vojtech@suse.cz
  input: Check the range for HIDIOC?USAGES num_values.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 hiddev.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

===================================================================

diff -Nru a/drivers/usb/input/hiddev.c b/drivers/usb/input/hiddev.c
--- a/drivers/usb/input/hiddev.c	Thu Jul 29 14:38:23 2004
+++ b/drivers/usb/input/hiddev.c	Thu Jul 29 14:38:23 2004
@@ -633,14 +633,11 @@
 			} else if (uref->usage_index >= field->report_count)
 				goto inval;
 
-			else if ((cmd == HIDIOCGUSAGES ||
-				  cmd == HIDIOCSUSAGES) &&
-				 (uref->usage_index + uref_multi->num_values >=
-				  field->report_count ||
-				  uref->usage_index + uref_multi->num_values <
-				  uref->usage_index))
+			else if ((cmd == HIDIOCGUSAGES || cmd == HIDIOCSUSAGES) &&
+				 (uref_multi->num_values >= HID_MAX_MULTI_USAGES ||
+				  uref->usage_index + uref_multi->num_values >= field->report_count ||
+				  uref->usage_index + uref_multi->num_values < uref->usage_index))
 				goto inval;
-
 			}
 
 		switch (cmd) {

