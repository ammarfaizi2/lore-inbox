Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266204AbUIEECT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266204AbUIEECT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 00:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266196AbUIEECS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 00:02:18 -0400
Received: from [61.48.52.95] ([61.48.52.95]:20472 "EHLO freya.yggdrasil.com")
	by vger.kernel.org with ESMTP id S266188AbUIEECF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 00:02:05 -0400
Date: Sun, 5 Sep 2004 11:57:30 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200409051857.i85IvUt06042@freya.yggdrasil.com>
To: janitor@sternwelten.at
Subject: [patch 2.6.9-rc1-bk11] riscom8: previous patch did not compile
Cc: linux-kernel@vger.kernel.org, pgmdsg@ibi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	linux-2.6.9-rc1-bk11/drivers/char/riscom8.c added
the patch "drivers/char/riscom8.c MIN/MAX removal", which
had a typo where one of the new min_t() calls is missing the
type parameter.  Because both of the parameters and the result
are all explicitly declared int on all architectures, I changed
it to use min() rather than min_t(int, ...).

	This is the third patch in bk11 that never could have compiled
anywhere.  Although I am glad to see patches being integrated into the
stock kernel more quickly, I would ask each submitter either

	(1) check that the patch being submitted has compiled somewhere, or
	(2) mention in the submission when this has not been done.

Signed-off-by: Adam J. Richter <adam@yggdrasil.com>
                    __     ______________ 
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l

--- linux-2.6.9-rc1-bk11/drivers/char/riscom8.c	2004-09-05 09:11:24.000000000 -0700
+++ linux/drivers/char/riscom8.c	2004-09-05 11:35:58.000000000 -0700
@@ -1174,8 +1174,8 @@
 			}
 
 			cli();
-			c = min_t(c, min(SERIAL_XMIT_SIZE - port->xmit_cnt - 1,
-					 SERIAL_XMIT_SIZE - port->xmit_head));
+			c = min(c, min(SERIAL_XMIT_SIZE - port->xmit_cnt - 1,
+				       SERIAL_XMIT_SIZE - port->xmit_head));
 			memcpy(port->xmit_buf + port->xmit_head, tmp_buf, c);
 			port->xmit_head = (port->xmit_head + c) & (SERIAL_XMIT_SIZE-1);
 			port->xmit_cnt += c;
