Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbVFOGjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVFOGjH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 02:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbVFOGjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 02:39:07 -0400
Received: from smtp816.mail.sc5.yahoo.com ([66.163.170.2]:33701 "HELO
	smtp816.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261514AbVFOGi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 02:38:59 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH] ALPS: fix enabling hardware tapping
Date: Wed, 15 Jun 2005 01:38:49 -0500
User-Agent: KMail/1.8.1
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506150138.49880.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Vojtech,

It looks like logic for enabling hardware tapping in ALPS driver was
inverted and we enable it only if it was already enabled by BIOS or
firmware.

I have a confirmation from one user that the patch below fixes the
problem for him and it might be beneficial if we could get it into
2.6.12.

Thanks!

-- 
Dmitry

===================================================================

Input: ALPS - try enabling tap mode if it was disabled, not if
       it is already enabled.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/alps.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: work/drivers/input/mouse/alps.c
===================================================================
--- work.orig/drivers/input/mouse/alps.c
+++ work/drivers/input/mouse/alps.c
@@ -364,7 +364,7 @@ static int alps_reconnect(struct psmouse
 	if (alps_get_status(psmouse, param))
 		return -1;
 
-	if (param[0] & 0x04)
+	if (!(param[0] & 0x04))
 		alps_tap_mode(psmouse, 1);
 
 	if (alps_absolute_mode(psmouse)) {
