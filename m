Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbVIJWlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbVIJWlF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 18:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbVIJWd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 18:33:59 -0400
Received: from styx.suse.cz ([82.119.242.94]:13988 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932343AbVIJWdt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 18:33:49 -0400
Subject: [PATCH 3/26] ALPS - fix wheel decoding
In-Reply-To: <112639165121@midnight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sun, 11 Sep 2005 00:34:11 +0200
Message-Id: <11263916512254@midnight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] Input: ALPS - fix wheel decoding
From: Vojtech Pavlik <vojtech@suse.cz>
Date: 1125816043 -0500

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

---

 drivers/input/mouse/alps.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

e6c047b98bbd09473c586744c681e877ebf954ff
diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -170,7 +170,7 @@ static void alps_process_packet(struct p
 	input_report_key(dev, BTN_TOOL_FINGER, z > 0);
 
 	if (priv->i->flags & ALPS_WHEEL)
-		input_report_rel(dev, REL_WHEEL, ((packet[0] >> 4) & 0x07) | ((packet[2] >> 2) & 0x08));
+		input_report_rel(dev, REL_WHEEL, ((packet[2] << 1) & 0x08) - ((packet[0] >> 4) & 0x07));
 
 	if (priv->i->flags & (ALPS_FW_BK_1 | ALPS_FW_BK_2)) {
 		input_report_key(dev, BTN_FORWARD, forward);

