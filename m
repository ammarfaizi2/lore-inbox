Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbVAGUR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbVAGUR2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 15:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbVAGURX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 15:17:23 -0500
Received: from fire.osdl.org ([65.172.181.4]:36258 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261577AbVAGUON (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 15:14:13 -0500
Message-ID: <41DEE347.7010504@osdl.org>
Date: Fri, 07 Jan 2005 11:30:15 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: markus.lidel@shadowconnect.com, akpm <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] i2o: fix init/exit section usage
Content-Type: multipart/mixed;
 boundary="------------050609010500080803090306"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050609010500080803090306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Fix 3 instances of bad calls to i2o_pci_free(), from init to exit
code sections:
Error: ./drivers/message/i2o/pci.o .init.text refers to 000000f7 
R_386_PC32        .exit.text
Error: ./drivers/message/i2o/pci.o .init.text refers to 000003bc 
R_386_PC32        .exit.text
Error: ./drivers/message/i2o/pci.o .init.text refers to 00000572 
R_386_PC32        .exit.text

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
  drivers/message/i2o/pci.c |    2 +-
  1 files changed, 1 insertion(+), 1 deletion(-)

---

--------------050609010500080803090306
Content-Type: text/x-patch;
 name="i2o_init_exit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2o_init_exit.patch"


diff -Naurp ./drivers/message/i2o/pci.c~i2o_initexit ./drivers/message/i2o/pci.c
--- ./drivers/message/i2o/pci.c~i2o_initexit	2004-12-24 13:35:50.000000000 -0800
+++ ./drivers/message/i2o/pci.c	2005-01-07 10:44:03.388412824 -0800
@@ -83,7 +83,7 @@ int i2o_dma_realloc(struct device *dev, 
  *	Remove all allocated DMA memory and unmap memory IO regions. If MTRR
  *	is enabled, also remove it again.
  */
-static void __devexit i2o_pci_free(struct i2o_controller *c)
+static void i2o_pci_free(struct i2o_controller *c)
 {
 	struct device *dev;
 

--------------050609010500080803090306--
