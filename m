Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbUCWELN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 23:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbUCWELN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 23:11:13 -0500
Received: from web14914.mail.yahoo.com ([216.136.225.241]:18705 "HELO
	web14914.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261943AbUCWELL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 23:11:11 -0500
Message-ID: <20040323041110.9421.qmail@web14914.mail.yahoo.com>
Date: Mon, 22 Mar 2004 20:11:10 -0800 (PST)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: 2.6.5-rc2 keyboard breakage
To: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using 2.6.5-rc2 bitkeeper with Logitech PS/2 Internet keyboard on a Dell
PE400SC. I needed to backout this change to make my PS/2 keyboard work again. It
broke during the big input patch from a couple of days ago but I just got around
to debugging it. Without this change atkbd.c gets zeros back from the keyboard
during probe and won't recognize it.

===== serio.c 1.25 vs edited =====
--- 1.25/drivers/input/serio/serio.c    Wed Mar  3 05:50:17 2004
+++ edited/serio.c      Mon Mar 22 22:54:36 2004
@@ -195,9 +195,6 @@
                 ret = serio->dev->interrupt(serio, data, flags, regs);
        } else {
                if (!flags) {
-                       if ((serio->type == SERIO_8042 ||
-                               serio->type == SERIO_8042_XL) && (data != 0xaa))
-                                       return ret;
                        serio_rescan(serio);
                        ret = IRQ_HANDLED;
                }


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! Finance Tax Center - File online. File on time.
http://taxes.yahoo.com/filing.html
