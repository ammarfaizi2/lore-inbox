Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbTJUJiT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 05:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbTJUJhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 05:37:09 -0400
Received: from mail.convergence.de ([212.84.236.4]:34495 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S262873AbTJUJgz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 05:36:55 -0400
Subject: [PATCH 2/3] Fix bug in saa7146 analog tv i2c-handling
In-Reply-To: <10667290141444@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Tue, 21 Oct 2003 11:36:54 +0200
Message-Id: <1066729014790@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold <hunold@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [V4L] remove cruft, add I2C_ADAP_CLASS_TV_ANALOG identifier for analog tv i2c handler
diff -ura xx-linux-2.6.0-test8/drivers/media/common/saa7146_i2c.c linux-2.6.0-test8-p/drivers/media/common/saa7146_i2c.c
--- xx-linux-2.6.0-test8/drivers/media/common/saa7146_i2c.c	2003-10-09 10:39:08.000000000 +0200
+++ linux-2.6.0-test8-p/drivers/media/common/saa7146_i2c.c	2003-10-21 11:21:36.000000000 +0200
@@ -409,11 +409,8 @@
 	if( NULL != i2c_adapter ) {
 		memset(i2c_adapter,0,sizeof(struct i2c_adapter));
 		strcpy(i2c_adapter->name, dev->name);	
-#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0))
-		i2c_adapter->data = dev;
-#else
 		i2c_set_adapdata(i2c_adapter,dev);
-#endif
+		i2c_adapter->class	   = I2C_ADAP_CLASS_TV_ANALOG;
 		i2c_adapter->algo	   = &saa7146_algo;
 		i2c_adapter->algo_data     = NULL;
 		i2c_adapter->id 	   = I2C_ALGO_SAA7146;

