Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267526AbUHWTtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267526AbUHWTtI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267522AbUHWTsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:48:07 -0400
Received: from mail.kroah.org ([69.55.234.183]:49347 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266849AbUHWSgW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:22 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <1093286084472@kroah.com>
Date: Mon, 23 Aug 2004 11:34:44 -0700
Message-Id: <10932860842880@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.54.8, 2004/08/02 16:11:29-07:00, nacc@us.ibm.com

[PATCH] I2C: scx200_acb: replace schedule_timeout() with msleep()

Uses msleep() instead of schedule_timeout() to guarantee
the task delays the requested time.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/scx200_acb.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)


diff -Nru a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
--- a/drivers/i2c/busses/scx200_acb.c	2004-08-23 11:07:02 -07:00
+++ b/drivers/i2c/busses/scx200_acb.c	2004-08-23 11:07:02 -07:00
@@ -32,6 +32,7 @@
 #include <linux/i2c.h>
 #include <linux/smp_lock.h>
 #include <linux/pci.h>
+#include <linux/delay.h>
 #include <asm/io.h>
 
 #include <linux/scx200.h>
@@ -254,7 +255,7 @@
 			scx200_acb_machine(iface, status);
 			return;
 		}
-		schedule_timeout(HZ/100+1);
+		msleep(10);
 	}
 
 	scx200_acb_timeout(iface);

