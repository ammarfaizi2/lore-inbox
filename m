Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262856AbVAFQyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262856AbVAFQyr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 11:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262881AbVAFQyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 11:54:46 -0500
Received: from av3-2-sn3.vrr.skanova.net ([81.228.9.110]:50134 "EHLO
	av3-2-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S262856AbVAFQyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 11:54:44 -0500
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] ALPS touchpad detection fix
From: Peter Osterlund <petero2@telia.com>
Date: 06 Jan 2005 17:54:33 +0100
Message-ID: <m3wtuqxzue.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My ALPS touchpad is not recognized because the device gets confused by
the Kensington ThinkingMouse probe.  It responds with "00 00 14"
instead of the expected "00 00 64" to the "E6 report".

Resetting the device before attempting the ALPS probe fixes the
problem.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 linux-petero/drivers/input/mouse/psmouse-base.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN drivers/input/mouse/psmouse-base.c~alps-fix drivers/input/mouse/psmouse-base.c
--- linux/drivers/input/mouse/psmouse-base.c~alps-fix	2005-01-06 17:33:15.000000000 +0100
+++ linux-petero/drivers/input/mouse/psmouse-base.c	2005-01-06 17:33:46.000000000 +0100
@@ -451,6 +451,7 @@ static int psmouse_extensions(struct psm
 /*
  * Try ALPS TouchPad
  */
+	ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS);
 	if (max_proto > PSMOUSE_IMEX && alps_detect(psmouse, set_properties) == 0) {
 		if (!set_properties || alps_init(psmouse) == 0)
 			return PSMOUSE_ALPS;
_

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
