Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263187AbTDCAD5>; Wed, 2 Apr 2003 19:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263203AbTDCADS>; Wed, 2 Apr 2003 19:03:18 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:4058 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263212AbTDCACN> convert rfc822-to-8bit;
	Wed, 2 Apr 2003 19:02:13 -0500
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10493289572106@kroah.com>
Subject: Re: [PATCH] More i2c driver changes for 2.5.66
In-Reply-To: <10493289572563@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 2 Apr 2003 16:15:57 -0800
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.977.29.3, 2003/03/31 15:25:48-08:00, greg@kroah.com

[PATCH] i2c: fix memleak caused by my last patch fo the adv7175.c driver


 drivers/media/video/adv7175.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/media/video/adv7175.c b/drivers/media/video/adv7175.c
--- a/drivers/media/video/adv7175.c	Wed Apr  2 16:01:53 2003
+++ b/drivers/media/video/adv7175.c	Wed Apr  2 16:01:53 2003
@@ -231,7 +231,7 @@
 static int adv717x_detach(struct i2c_client *client)
 {
 	i2c_detach_client(client);
-	i2c_get_clientdata(client);
+	kfree(i2c_get_clientdata(client));
 	kfree(client);
 	return 0;
 }

