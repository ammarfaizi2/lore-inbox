Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262795AbVFVG5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbVFVG5G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 02:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbVFVGyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 02:54:08 -0400
Received: from mail.kroah.org ([69.55.234.183]:16796 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262789AbVFVFWA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:22:00 -0400
Cc: khali@linux-fr.org
Subject: [PATCH] I2C: Fix bugs in the new w83627ehf driver
In-Reply-To: <11194174633539@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 21 Jun 2005 22:17:43 -0700
Message-Id: <11194174633368@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] I2C: Fix bugs in the new w83627ehf driver

These are the fixes for the bug you spotted in my new w83627ehf driver:
	- Explicit division by 0.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit b9110b1c893f45ec66ae39e359decdfad84525be
tree 0fcb89b2f770df7995445b4e74251549bea6baf6
parent 08e7e2789e0da49eadeb17121e24af22efeee84b
author Jean Delvare <khali@linux-fr.org> Mon, 02 May 2005 23:08:22 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Tue, 21 Jun 2005 21:51:54 -0700

 drivers/i2c/chips/w83627ehf.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/chips/w83627ehf.c b/drivers/i2c/chips/w83627ehf.c
--- a/drivers/i2c/chips/w83627ehf.c
+++ b/drivers/i2c/chips/w83627ehf.c
@@ -450,7 +450,7 @@ store_fan_min(struct device *dev, const 
 		data->fan_min[nr] = 1;
 		new_div = 0; /* 1 == (1 << 0) */
 		dev_warn(dev, "fan%u low limit %u above maximum %u, set to "
-			 "maximum\n", nr + 1, val, fan_from_reg(1, 0));
+			 "maximum\n", nr + 1, val, fan_from_reg(1, 1));
 	} else {
 		/* Automatically pick the best divider, i.e. the one such
 		   that the min limit will correspond to a register value

