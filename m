Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423139AbWJQGYL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423139AbWJQGYL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 02:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423140AbWJQGYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 02:24:11 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:2981 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1423139AbWJQGYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 02:24:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=MFllluEEMq3BY60s25pLx3YELMl1W/PpRv4G3YxOBDdseIEfeoKRpQtPqAt8F9uDFbHU//BnLwsv4R9frAqnC7twIfx+EaAmFARcpVB91qGj0z7XXMgEUst+YbisJpIJq2147EFyysrJhOgNgiZZY5ynWJ3rWw3SikAV1BWh4Uo=
Date: Tue, 17 Oct 2006 15:24:49 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] i2c: Fix return value check
Message-ID: <20061017062449.GA13100@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
	Jean Delvare <khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

class_device_create() returns error code as pointer on failure.
This patch checks the return value of class_device_create() by using IS_ERR().

Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Akinbou Mita <akinobu.mita@gmail.com>

 drivers/i2c/i2c-dev.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: 2.6-rc/drivers/i2c/i2c-dev.c
===================================================================
--- 2.6-rc.orig/drivers/i2c/i2c-dev.c
+++ 2.6-rc/drivers/i2c/i2c-dev.c
@@ -417,8 +417,8 @@ static int i2cdev_attach_adapter(struct 
 						 MKDEV(I2C_MAJOR, adap->nr),
 						 &adap->dev, "i2c-%d",
 						 adap->nr);
-	if (!i2c_dev->class_dev) {
-		res = -ENODEV;
+	if (IS_ERR(i2c_dev->class_dev)) {
+		res = PTR_ERR(i2c_dev->class_dev);
 		goto error;
 	}
 	res = class_device_create_file(i2c_dev->class_dev, &class_device_attr_name);
