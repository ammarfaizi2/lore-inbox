Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263293AbTESW5k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 18:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263311AbTESW5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 18:57:40 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:21731 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263293AbTESW5g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 18:57:36 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1053385947386@kroah.com>
Subject: Re: [PATCH] Yet more i2c driver changes for 2.5.69
In-Reply-To: <1053385947756@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 19 May 2003 16:12:27 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1093.2.3, 2003/05/19 10:37:20-07:00, warp@mercury.d2dc.net

[PATCH] I2C: And yet another it87 patch.

Trivial, but important.

Somehow in the patching the bk tree somehow got two memset's to clear
new_client in it87_detect, normally while this would be bad, it would
not be critical.

However one of the two happens BEFORE the variable is set, and thus
things go badly.


 drivers/i2c/chips/it87.c |    1 -
 1 files changed, 1 deletion(-)


diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Mon May 19 15:58:52 2003
+++ b/drivers/i2c/chips/it87.c	Mon May 19 15:58:52 2003
@@ -630,7 +630,6 @@
 			}
 		}
 	}
-	memset (new_client, 0x00, sizeof(struct i2c_client) + sizeof(struct it87_data));
 
 	/* OK. For now, we presume we have a valid client. We now create the
 	   client structure, even though we cannot fill it completely yet.

