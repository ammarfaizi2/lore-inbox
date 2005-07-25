Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbVGYGqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbVGYGqE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 02:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbVGYFyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 01:54:47 -0400
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:50351 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261640AbVGYFxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 01:53:21 -0400
Message-Id: <20050725054533.550847000.dtor_core@ameritech.net>
References: <20050725053449.483098000.dtor_core@ameritech.net>
Date: Mon, 25 Jul 2005 00:35:10 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 21/24] psmouse: wheel mice always have middle button
Content-Disposition: inline; filename=psmouse-wheel-mice-have-middle-button.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vojtech Pavlik <vojtech@suse.cz>

Input: psmouse - wheel mice (imps, exps) always have 3rd button

There are wheel mice that respond to Logitech probes and report
that they have only 2 buttons (such as e-Aser mouse) and this
stops the wheel from being used as a middle button. Change the
driver to always report BTN_MIDDLE capability if a wheel is
present.

Also, never reset BTN_RIGHT capability in logips2pp code - there
are no Logitech mice that have only one button and if some other
mice happen to respond to Logitech's query we could do the wrong
thing.

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/logips2pp.c    |    2 --
 drivers/input/mouse/psmouse-base.c |    2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: work/drivers/input/mouse/logips2pp.c
===================================================================
--- work.orig/drivers/input/mouse/logips2pp.c
+++ work/drivers/input/mouse/logips2pp.c
@@ -385,8 +385,6 @@ int ps2pp_init(struct psmouse *psmouse, 
 
 		if (buttons < 3)
 			clear_bit(BTN_MIDDLE, psmouse->dev.keybit);
-		if (buttons < 2)
-			clear_bit(BTN_RIGHT, psmouse->dev.keybit);
 
 		if (model_info)
 			ps2pp_set_model_properties(psmouse, model_info, use_ps2pp);
Index: work/drivers/input/mouse/psmouse-base.c
===================================================================
--- work.orig/drivers/input/mouse/psmouse-base.c
+++ work/drivers/input/mouse/psmouse-base.c
@@ -344,6 +344,7 @@ static int intellimouse_detect(struct ps
 		return -1;
 
 	if (set_properties) {
+		set_bit(BTN_MIDDLE, psmouse->dev.keybit);
 		set_bit(REL_WHEEL, psmouse->dev.relbit);
 
 		if (!psmouse->vendor) psmouse->vendor = "Generic";
@@ -376,6 +377,7 @@ static int im_explorer_detect(struct psm
 		return -1;
 
 	if (set_properties) {
+		set_bit(BTN_MIDDLE, psmouse->dev.keybit);
 		set_bit(REL_WHEEL, psmouse->dev.relbit);
 		set_bit(BTN_SIDE, psmouse->dev.keybit);
 		set_bit(BTN_EXTRA, psmouse->dev.keybit);

