Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263250AbVCDVXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263250AbVCDVXw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 16:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263202AbVCDVF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 16:05:28 -0500
Received: from mail.kroah.org ([69.55.234.183]:13474 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263155AbVCDUyg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:36 -0500
Cc: johnpol@2ka.mipt.ru
Subject: [PATCH] w1: Core cleanup 1/2
In-Reply-To: <11099687822751@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:39:42 -0800
Message-Id: <11099687824109@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2082, 2005/03/02 16:58:52-08:00, johnpol@2ka.mipt.ru

[PATCH] w1: Core cleanup 1/2

Trivial cleanups, mostly static/non static, removed unneded exports.
It fuzzes a bit, sorry, patch is quite old.

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/w1/w1.c        |   23 ++++++++++-------------
 drivers/w1/w1_family.c |    2 --
 drivers/w1/w1_int.c    |    3 ---
 3 files changed, 10 insertions(+), 18 deletions(-)


diff -Nru a/drivers/w1/w1.c b/drivers/w1/w1.c
--- a/drivers/w1/w1.c	2005-03-04 12:38:12 -08:00
+++ b/drivers/w1/w1.c	2005-03-04 12:38:12 -08:00
@@ -19,8 +19,6 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 
-#include <asm/atomic.h>
-
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -33,6 +31,8 @@
 #include <linux/slab.h>
 #include <linux/sched.h>
 
+#include <asm/atomic.h>
+
 #include "w1.h"
 #include "w1_io.h"
 #include "w1_log.h"
@@ -100,7 +100,7 @@
 	return sprintf(buf, "No family registered.\n");
 }
 
-struct bus_type w1_bus_type = {
+static struct bus_type w1_bus_type = {
 	.name = "w1",
 	.match = w1_master_match,
 };
@@ -138,7 +138,7 @@
 	.show = &w1_default_read_name,
 };
 
-ssize_t w1_master_attribute_show_name(struct device *dev, char *buf)
+static ssize_t w1_master_attribute_show_name(struct device *dev, char *buf)
 {
 	struct w1_master *md = container_of (dev, struct w1_master, dev);
 	ssize_t count;
@@ -153,7 +153,7 @@
 	return count;
 }
 
-ssize_t w1_master_attribute_show_pointer(struct device *dev, char *buf)
+static ssize_t w1_master_attribute_show_pointer(struct device *dev, char *buf)
 {
 	struct w1_master *md = container_of(dev, struct w1_master, dev);
 	ssize_t count;
@@ -167,14 +167,14 @@
 	return count;
 }
 
-ssize_t w1_master_attribute_show_timeout(struct device *dev, char *buf)
+static ssize_t w1_master_attribute_show_timeout(struct device *dev, char *buf)
 {
 	ssize_t count;
 	count = sprintf(buf, "%d\n", w1_timeout);
 	return count;
 }
 
-ssize_t w1_master_attribute_show_max_slave_count(struct device *dev, char *buf)
+static ssize_t w1_master_attribute_show_max_slave_count(struct device *dev, char *buf)
 {
 	struct w1_master *md = container_of(dev, struct w1_master, dev);
 	ssize_t count;
@@ -188,7 +188,7 @@
 	return count;
 }
 
-ssize_t w1_master_attribute_show_attempts(struct device *dev, char *buf)
+static ssize_t w1_master_attribute_show_attempts(struct device *dev, char *buf)
 {
 	struct w1_master *md = container_of(dev, struct w1_master, dev);
 	ssize_t count;
@@ -202,7 +202,7 @@
 	return count;
 }
 
-ssize_t w1_master_attribute_show_slave_count(struct device *dev, char *buf)
+static ssize_t w1_master_attribute_show_slave_count(struct device *dev, char *buf)
 {
 	struct w1_master *md = container_of(dev, struct w1_master, dev);
 	ssize_t count;
@@ -216,7 +216,7 @@
 	return count;
 }
 
-ssize_t w1_master_attribute_show_slaves(struct device *dev, char *buf)
+static ssize_t w1_master_attribute_show_slaves(struct device *dev, char *buf)
 
 {
 	struct w1_master *md = container_of(dev, struct w1_master, dev);
@@ -839,6 +839,3 @@
 
 module_init(w1_init);
 module_exit(w1_fini);
-
-EXPORT_SYMBOL(w1_create_master_attributes);
-EXPORT_SYMBOL(w1_destroy_master_attributes);
diff -Nru a/drivers/w1/w1_family.c b/drivers/w1/w1_family.c
--- a/drivers/w1/w1_family.c	2005-03-04 12:38:12 -08:00
+++ b/drivers/w1/w1_family.c	2005-03-04 12:38:12 -08:00
@@ -143,8 +143,6 @@
 
 EXPORT_SYMBOL(w1_family_get);
 EXPORT_SYMBOL(w1_family_put);
-EXPORT_SYMBOL(__w1_family_get);
-EXPORT_SYMBOL(__w1_family_put);
 EXPORT_SYMBOL(w1_family_registered);
 EXPORT_SYMBOL(w1_unregister_family);
 EXPORT_SYMBOL(w1_register_family);
diff -Nru a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
--- a/drivers/w1/w1_int.c	2005-03-04 12:38:12 -08:00
+++ b/drivers/w1/w1_int.c	2005-03-04 12:38:12 -08:00
@@ -217,8 +217,5 @@
 	__w1_remove_master_device(dev);
 }
 
-EXPORT_SYMBOL(w1_alloc_dev);
-EXPORT_SYMBOL(w1_free_dev);
 EXPORT_SYMBOL(w1_add_master_device);
 EXPORT_SYMBOL(w1_remove_master_device);
-EXPORT_SYMBOL(__w1_remove_master_device);

