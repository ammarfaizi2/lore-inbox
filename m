Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbTEGATO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 20:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbTEGATO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 20:19:14 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:14465 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262119AbTEGATK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 20:19:10 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1052267615977@kroah.com>
Subject: Re: [PATCH] i2c driver changes for 2.5.69
In-Reply-To: <1052267615252@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 6 May 2003 17:33:35 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1042.48.2, 2003/04/25 16:11:23-07:00, greg@kroah.com

[PATCH] i2c: fix oops on startup of it87 driver.


 drivers/i2c/chips/it87.c |    2 ++
 1 files changed, 2 insertions(+)


diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Tue May  6 17:25:00 2003
+++ b/drivers/i2c/chips/it87.c	Tue May  6 17:25:00 2003
@@ -585,6 +585,8 @@
 		err = -ENOMEM;
 		goto ERROR1;
 	}
+	memset(new_client, 0x00, sizeof(struct i2c_client) +
+				 sizeof(struct it87_data));
 
 	data = (struct it87_data *) (new_client + 1);
 	if (is_isa)

