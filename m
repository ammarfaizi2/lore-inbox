Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbVGYF73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbVGYF73 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 01:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVGYF5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 01:57:33 -0400
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:62383 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261713AbVGYFzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 01:55:44 -0400
Message-Id: <20050725054532.703755000.dtor_core@ameritech.net>
References: <20050725053449.483098000.dtor_core@ameritech.net>
Date: Mon, 25 Jul 2005 00:35:04 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 15/24] ALPS: Fix resume for DualPoints
Content-Disposition: inline; filename=alps-dualpoint-resume-fix.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Moore <dcm@MIT.EDU>

Input: ALPS - fix resume (for DualPoints)

The driver would not reset pass-through mode when performing
resume of a DualPoint touchpad causing it to stop working
until next reboot.

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/alps.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: work/drivers/input/mouse/alps.c
===================================================================
--- work.orig/drivers/input/mouse/alps.c
+++ work/drivers/input/mouse/alps.c
@@ -358,7 +358,7 @@ static int alps_reconnect(struct psmouse
 	if (!(priv->i = alps_get_model(psmouse, &version)))
 		return -1;
 
-	if (priv->i->flags & ALPS_PASS && alps_passthrough_mode(psmouse, 1))
+	if ((priv->i->flags & ALPS_PASS) && alps_passthrough_mode(psmouse, 1))
 		return -1;
 
 	if (alps_get_status(psmouse, param))
@@ -372,7 +372,7 @@ static int alps_reconnect(struct psmouse
 		return -1;
 	}
 
-	if (priv->i->flags == ALPS_PASS && alps_passthrough_mode(psmouse, 0))
+	if ((priv->i->flags & ALPS_PASS) && alps_passthrough_mode(psmouse, 0))
 		return -1;
 
 	return 0;

