Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270212AbUJTAhB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270212AbUJTAhB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 20:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267856AbUJTAdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 20:33:50 -0400
Received: from mail.kroah.org ([69.55.234.183]:13748 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267923AbUJTATd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 20:19:33 -0400
Subject: Re: [PATCH] I2C update for 2.6.9
In-Reply-To: <10982315032767@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 19 Oct 2004 17:18:23 -0700
Message-Id: <10982315033266@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1832.73.4, 2004/09/08 12:35:04-07:00, margitsw@t-online.de

[PATCH] I2C: minor lm85 fix

Jean scribeth :
> Except lm85, but this should be fixed

Indeed, patch attached.


Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/lm85.c |    2 ++
 1 files changed, 2 insertions(+)


diff -Nru a/drivers/i2c/chips/lm85.c b/drivers/i2c/chips/lm85.c
--- a/drivers/i2c/chips/lm85.c	2004-10-19 16:55:47 -07:00
+++ b/drivers/i2c/chips/lm85.c	2004-10-19 16:55:47 -07:00
@@ -707,6 +707,8 @@
 
 int lm85_attach_adapter(struct i2c_adapter *adapter)
 {
+	if (!(adapter->class & I2C_CLASS_HWMON))
+		return 0;
 	return i2c_detect(adapter, &addr_data, lm85_detect);
 }
 

