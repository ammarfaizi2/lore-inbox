Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbTIYVvs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 17:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbTIYVus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 17:50:48 -0400
Received: from mail.kroah.org ([65.200.24.183]:31900 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261908AbTIYVub convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 17:50:31 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10645266091820@kroah.com>
Subject: [PATCH] More i2c driver fixes for 2.6.0-test5
In-Reply-To: <20030925214838.GA30072@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 25 Sep 2003 14:50:09 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1325.4.1, 2003/09/23 13:54:31-07:00, greg@kroah.com

[PATCH] I2C: remove the isa address check alltogether.


 drivers/i2c/i2c-sensor.c |    5 +----
 1 files changed, 1 insertion(+), 4 deletions(-)


diff -Nru a/drivers/i2c/i2c-sensor.c b/drivers/i2c/i2c-sensor.c
--- a/drivers/i2c/i2c-sensor.c	Thu Sep 25 14:50:07 2003
+++ b/drivers/i2c/i2c-sensor.c	Thu Sep 25 14:50:07 2003
@@ -50,10 +50,7 @@
 		return -1;
 
 	for (addr = 0x00; addr <= (is_isa ? 0xffff : 0x7f); addr++) {
-		void *region_used = request_region(addr, 1, "foo");
-		release_region(addr, 1);
-		if ((is_isa && (region_used == NULL)) ||
-		    (!is_isa && i2c_check_addr(adapter, addr)))
+		if (!is_isa && i2c_check_addr(adapter, addr))
 			continue;
 
 		/* If it is in one of the force entries, we don't do any

