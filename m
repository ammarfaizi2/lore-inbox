Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbTIWAET (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 20:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263073AbTIWADs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 20:03:48 -0400
Received: from mail.kroah.org ([65.200.24.183]:32417 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262896AbTIVXbd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 19:31:33 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1064273428551@kroah.com>
Subject: Re: [PATCH] i2c driver fixes for 2.6.0-test5
In-Reply-To: <10642734271572@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 22 Sep 2003 16:30:28 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1315.1.25, 2003/09/22 15:11:24-07:00, greg@kroah.com

[PATCH] I2C: remove check_region usage and warning from i2c-sensor


 drivers/i2c/i2c-sensor.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)


diff -Nru a/drivers/i2c/i2c-sensor.c b/drivers/i2c/i2c-sensor.c
--- a/drivers/i2c/i2c-sensor.c	Mon Sep 22 16:11:52 2003
+++ b/drivers/i2c/i2c-sensor.c	Mon Sep 22 16:11:52 2003
@@ -50,8 +50,9 @@
 		return -1;
 
 	for (addr = 0x00; addr <= (is_isa ? 0xffff : 0x7f); addr++) {
-		/* XXX: WTF is going on here??? */
-		if ((is_isa && check_region(addr, 1)) ||
+		void *region_used = request_region(addr, 1, "foo");
+		release_region(addr, 1);
+		if ((is_isa && (region_used == NULL)) ||
 		    (!is_isa && i2c_check_addr(adapter, addr)))
 			continue;
 

