Return-Path: <linux-kernel-owner+w=401wt.eu-S1762418AbWLJTay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762418AbWLJTay (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 14:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762420AbWLJTay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 14:30:54 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:55326 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762418AbWLJTax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 14:30:53 -0500
Date: Sun, 10 Dec 2006 19:30:49 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       markus.lidel@shadowconnect.com
Subject: [PATCH] i2o_exec_exit and i2o_driver_exit should not be __exit.
Message-ID: <20061210193049.GA32431@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i2o_exec_exit and i2o_driver_exit were marked as __exit which is a bug
because both are invoked from __init and __exit functions.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/drivers/message/i2o/core.h b/drivers/message/i2o/core.h
index dc388a3..cbe384f 100644
--- a/drivers/message/i2o/core.h
+++ b/drivers/message/i2o/core.h
@@ -18,7 +18,7 @@ extern struct i2o_driver i2o_exec_driver
 extern int i2o_exec_lct_get(struct i2o_controller *);
 
 extern int __init i2o_exec_init(void);
-extern void __exit i2o_exec_exit(void);
+extern void i2o_exec_exit(void);
 
 /* driver */
 extern struct bus_type i2o_bus_type;
@@ -26,7 +26,7 @@ extern struct bus_type i2o_bus_type;
 extern int i2o_driver_dispatch(struct i2o_controller *, u32);
 
 extern int __init i2o_driver_init(void);
-extern void __exit i2o_driver_exit(void);
+extern void i2o_driver_exit(void);
 
 /* PCI */
 extern int __init i2o_pci_init(void);
diff --git a/drivers/message/i2o/driver.c b/drivers/message/i2o/driver.c
index 9104b65..d3235f2 100644
--- a/drivers/message/i2o/driver.c
+++ b/drivers/message/i2o/driver.c
@@ -362,7 +362,7 @@ int __init i2o_driver_init(void)
  *
  *	Unregisters the I2O bus and frees driver array.
  */
-void __exit i2o_driver_exit(void)
+void i2o_driver_exit(void)
 {
 	bus_unregister(&i2o_bus_type);
 	kfree(i2o_drivers);
diff --git a/drivers/message/i2o/exec-osm.c b/drivers/message/i2o/exec-osm.c
index 902753b..a539d3b 100644
--- a/drivers/message/i2o/exec-osm.c
+++ b/drivers/message/i2o/exec-osm.c
@@ -595,7 +595,7 @@ int __init i2o_exec_init(void)
  *
  *	Unregisters the Exec OSM from the I2O core.
  */
-void __exit i2o_exec_exit(void)
+void i2o_exec_exit(void)
 {
 	i2o_driver_unregister(&i2o_exec_driver);
 };
