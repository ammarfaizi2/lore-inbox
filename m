Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbVDKDc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbVDKDc6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 23:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbVDKDc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 23:32:58 -0400
Received: from fire.osdl.org ([65.172.181.4]:63383 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261679AbVDKDcy (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 23:32:54 -0400
Date: Sun, 10 Apr 2005 20:32:44 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Derek Cheung" <derek.cheung@sympatico.ca>
Cc: greg@kroah.com, akpm@osdl.org, Linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel 2.6.11.6 -  I2C adaptor for ColdFire 5282 CPU
Message-Id: <20050410203244.511ae8c9.rddunlap@osdl.org>
In-Reply-To: <000801c53ded$04428920$1501a8c0@Mainframe>
References: <42535AF1.5080008@osdl.org>
	<000801c53ded$04428920$1501a8c0@Mainframe>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Apr 2005 12:47:42 -0400 Derek Cheung wrote:

| Enclosed please find the updated patch that incorporates changes for all
| the comments I received.

(yes, almost all)

| The volatile declaration in the m528xsim.h is needed because the
| declaration refers to the ColdFire 5282 register mapping. The volatile
| declaration is actually not needed in my I2C driver but someone may
| include the m528xsim.h file in his/her applications and we need to force
| the compiler not to do any optimization on the register mapping.

Did you also send it to the I2C mailing list like Greg asked you to do?

More comments:

diffstat summary, like so, would be nice:
 drivers/i2c/busses/Kconfig       |   10
 drivers/i2c/busses/Makefile      |    2
 drivers/i2c/busses/i2c-mcf5282.c |  419 +++++++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-mcf5282.h |   46 ++++
 include/asm-m68knommu/m528xsim.h |   42 +++
 5 files changed, 519 insertions(+)


+	int i, len, rc = 0;
+        u8 rxData, tempRxData[2];
Use tabs, not spaces.  Happens other places too.

+        switch (size) {
+                case I2C_SMBUS_QUICK:
Don't need to indent case statements... (repeating myself).

+                case I2C_SMBUS_PROC_CALL:
+			/* dev_info(&adap->dev, "size = 
+				I2C_SMBUS_PROC_CALL \n"); */
No break needed here ?
+        	case I2C_SMBUS_WORD_DATA:

+	if (rc < 0) 
+		return -1;
+	else
+        	return 0;
There are several of these.  Why not just return rc ?


Kconfig says that the module (if selected) will be called
i2c-mcf5282lite, but Makefile builds
+obj-$(CONFIG_I2C_MCF5282LITE)   += i2c-mcf5282.o
(i.e., no "lite").


---
~Randy
