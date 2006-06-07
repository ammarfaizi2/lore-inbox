Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWFGRee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWFGRee (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 13:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWFGRed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 13:34:33 -0400
Received: from [213.91.247.3] ([213.91.247.3]:774 "EHLO l.himel.bg")
	by vger.kernel.org with ESMTP id S932364AbWFGRec (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 13:34:32 -0400
Date: Wed, 7 Jun 2006 20:33:57 +0300
From: Alexander Atanasov <alex@ssi.bg>
To: khali@linux-fr.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] I2C block read
Message-Id: <20060607203357.64432ad8.alex@ssi.bg>
X-Mailer: Sylpheed version 2.1.5 (GTK+ 2.6.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

	When doing i2c block read the lenght is passed as the first byte of the buffer,
so we must copy it from user otherwise temp is uninitialized.

Signed-off-by: Alexander Atanasov <alex@ssi.bg>

--
have fun,
alex


--- drivers/i2c/i2c-dev.c.orig	2006-01-04 02:00:00.000000000 +0200
+++ drivers/i2c/i2c-dev.c	2006-06-07 19:46:08.000000000 +0300
@@ -337,6 +337,7 @@
 
 		if ((data_arg.size == I2C_SMBUS_PROC_CALL) || 
 		    (data_arg.size == I2C_SMBUS_BLOCK_PROC_CALL) || 
+		    (data_arg.size == I2C_SMBUS_BLOCK_DATA) ||
 		    (data_arg.read_write == I2C_SMBUS_WRITE)) {
 			if (copy_from_user(&temp, data_arg.data, datasize))
 				return -EFAULT;
