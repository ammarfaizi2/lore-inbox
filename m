Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265464AbUA0XjK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 18:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265658AbUA0Xg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 18:36:56 -0500
Received: from mail.kroah.org ([65.200.24.183]:37055 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265464AbUA0XeR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 18:34:17 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.2-rc2
In-Reply-To: <1075246453858@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 27 Jan 2004 15:34:13 -0800
Message-Id: <10752464533223@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1474.148.3, 2004/01/23 17:14:52-08:00, khali@linux-fr.org

[PATCH] I2C: Fix bus reset in i2c-philips-par

This patch fixes the bus reset in i2c-philips-par when it is loaded with
type!=0. For now, the reset is always made as is type==0. I guess that
this driver will be abandoned in a while, but it probably doesn't hurt
to fix that.


 drivers/i2c/busses/i2c-philips-par.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-philips-par.c b/drivers/i2c/busses/i2c-philips-par.c
--- a/drivers/i2c/busses/i2c-philips-par.c	Tue Jan 27 15:27:08 2004
+++ b/drivers/i2c/busses/i2c-philips-par.c	Tue Jan 27 15:27:08 2004
@@ -184,8 +184,8 @@
 		return;
 	}
 	/* reset hardware to sane state */
-	bit_lp_setsda(port, 1);
-	bit_lp_setscl(port, 1);
+	adapter->bit_lp_data.setsda(port, 1);
+	adapter->bit_lp_data.setscl(port, 1);
 	parport_release(adapter->pdev);
 
 	if (i2c_bit_add_bus(&adapter->adapter) < 0) {

