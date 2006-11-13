Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754571AbWKMMYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754571AbWKMMYs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 07:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754554AbWKMMYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 07:24:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:20433 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1754558AbWKMMXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 07:23:45 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Hermann Pitton <hermann-pitton@arcor.de>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 2/8] V4L/DVB (4802): Cx88: fix remote control on WinFast
	2000XP Expert
Date: Mon, 13 Nov 2006 10:18:43 -0200
Message-id: <20061113121843.PS6051510002@infradead.org>
In-Reply-To: <20061113121504.PS7687690000@infradead.org>
References: <20061113121504.PS7687690000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Hermann Pitton <hermann-pitton@arcor.de>

fix remote control on WinFast 2000XP Expert by setting timing back to 1 ms,
like it was in the original patch by Robert Reid.

Signed-off-by: Hermann Pitton <hermann-pitton@arcor.de>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/cx88/cx88-input.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/media/video/cx88/cx88-input.c b/drivers/media/video/cx88/cx88-input.c
index ee48995..57e1c02 100644
--- a/drivers/media/video/cx88/cx88-input.c
+++ b/drivers/media/video/cx88/cx88-input.c
@@ -202,13 +202,19 @@ int cx88_ir_init(struct cx88_core *core,
 		ir->sampling = 1;
 		break;
 	case CX88_BOARD_WINFAST_DTV2000H:
-	case CX88_BOARD_WINFAST2000XP_EXPERT:
 		ir_codes = ir_codes_winfast;
 		ir->gpio_addr = MO_GP0_IO;
 		ir->mask_keycode = 0x8f8;
 		ir->mask_keyup = 0x100;
 		ir->polling = 50; /* ms */
 		break;
+	case CX88_BOARD_WINFAST2000XP_EXPERT:
+		ir_codes = ir_codes_winfast;
+		ir->gpio_addr = MO_GP0_IO;
+		ir->mask_keycode = 0x8f8;
+		ir->mask_keyup = 0x100;
+		ir->polling = 1; /* ms */
+		break;
 	case CX88_BOARD_IODATA_GVBCTV7E:
 		ir_codes = ir_codes_iodata_bctv7e;
 		ir->gpio_addr = MO_GP0_IO;
@@ -216,7 +222,7 @@ int cx88_ir_init(struct cx88_core *core,
 		ir->mask_keydown = 0x02;
 		ir->polling = 5; /* ms */
 		break;
-       case CX88_BOARD_PROLINK_PLAYTVPVR:
+	case CX88_BOARD_PROLINK_PLAYTVPVR:
 	case CX88_BOARD_PIXELVIEW_PLAYTV_ULTRA_PRO:
 		ir_codes = ir_codes_pixelview;
 		ir->gpio_addr = MO_GP1_IO;

