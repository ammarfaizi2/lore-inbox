Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWGXXBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWGXXBh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 19:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWGXXBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 19:01:37 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:24291 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932317AbWGXXBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 19:01:36 -0400
From: Daniel Drake <dsd@gentoo.org>
To: dmitry.torokhov@gmail.com
Cc: linux-input@atrey.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org
Cc: roberto.castagnola@gmail.com
Subject: [PATCH] logips2pp: Fix MX300 button layout
Message-Id: <20060724230234.81751812912@zog.reactivated.net>
Date: Tue, 25 Jul 2006 00:02:34 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Based on a patch from Castagnola Roberto <roberto.castagnola@gmail.com>

Firstly, the kernel lists that the device has an EXTRA_BTN - this is not true.
This is a simple wheel mouse with an additional task-switcher button.

Secondly, the task button is registered as the side button in hardware. This
patch allows that button to be used.

Signed-off-by: Daniel Drake <dsd@gentoo.org>

Index: linux/drivers/input/mouse/logips2pp.c
===================================================================
--- linux.orig/drivers/input/mouse/logips2pp.c
+++ linux/drivers/input/mouse/logips2pp.c
@@ -238,8 +238,7 @@ static struct ps2pp_info *get_model_info
 		{ 100,	PS2PP_KIND_MX,					/* MX510 */
 				PS2PP_WHEEL | PS2PP_SIDE_BTN | PS2PP_TASK_BTN |
 				PS2PP_EXTRA_BTN | PS2PP_NAV_BTN },
-		{ 111,  PS2PP_KIND_MX,					/* MX300 */
-				PS2PP_WHEEL | PS2PP_EXTRA_BTN | PS2PP_TASK_BTN },
+		{ 111,  PS2PP_KIND_MX,	PS2PP_WHEEL | SIDE_BTN }, 	/* MX300 reports task button as side */
 		{ 112,	PS2PP_KIND_MX,					/* MX500 */
 				PS2PP_WHEEL | PS2PP_SIDE_BTN | PS2PP_TASK_BTN |
 				PS2PP_EXTRA_BTN | PS2PP_NAV_BTN },
