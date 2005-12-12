Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbVLLXvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbVLLXvr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 18:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbVLLXvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 18:51:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55971 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932271AbVLLXqt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 18:46:49 -0500
Date: Mon, 12 Dec 2005 23:45:47 GMT
Message-Id: <200512122345.jBCNjl4F009039@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 7/19] MUTEX: Drivers F-H changes
In-Reply-To: <dhowells1134431145@warthog.cambridge.redhat.com>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch modifies the files of the drivers/f* thru drivers/h* to use
the new mutex functions.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 mutex-drivers-FtoH-2615rc5.diff
 drivers/fc4/fc.c           |    8 ++++----
 drivers/firmware/dcdbas.c  |    2 +-
 drivers/hwmon/adm1021.c    |    2 +-
 drivers/hwmon/adm1025.c    |    2 +-
 drivers/hwmon/adm1026.c    |    4 ++--
 drivers/hwmon/adm1031.c    |    2 +-
 drivers/hwmon/adm9240.c    |    2 +-
 drivers/hwmon/asb100.c     |    4 ++--
 drivers/hwmon/atxp1.c      |    2 +-
 drivers/hwmon/ds1621.c     |    2 +-
 drivers/hwmon/fscher.c     |    2 +-
 drivers/hwmon/fscpos.c     |    2 +-
 drivers/hwmon/gl518sm.c    |    2 +-
 drivers/hwmon/gl520sm.c    |    2 +-
 drivers/hwmon/it87.c       |    4 ++--
 drivers/hwmon/lm63.c       |    2 +-
 drivers/hwmon/lm75.c       |    2 +-
 drivers/hwmon/lm77.c       |    2 +-
 drivers/hwmon/lm78.c       |    4 ++--
 drivers/hwmon/lm80.c       |    2 +-
 drivers/hwmon/lm83.c       |    2 +-
 drivers/hwmon/lm85.c       |    4 ++--
 drivers/hwmon/lm87.c       |    2 +-
 drivers/hwmon/lm90.c       |    2 +-
 drivers/hwmon/lm92.c       |    2 +-
 drivers/hwmon/max1619.c    |    2 +-
 drivers/hwmon/pc87360.c    |    4 ++--
 drivers/hwmon/sis5595.c    |    4 ++--
 drivers/hwmon/smsc47b397.c |    4 ++--
 drivers/hwmon/smsc47m1.c   |    4 ++--
 drivers/hwmon/via686a.c    |    2 +-
 drivers/hwmon/w83627ehf.c  |    4 ++--
 drivers/hwmon/w83627hf.c   |    4 ++--
 drivers/hwmon/w83781d.c    |    4 ++--
 drivers/hwmon/w83792d.c    |    4 ++--
 drivers/hwmon/w83l785ts.c  |    2 +-
 36 files changed, 52 insertions(+), 52 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/fc4/fc.c linux-2.6.15-rc5-mutex/drivers/fc4/fc.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/fc4/fc.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/fc4/fc.c	2005-12-12 22:08:48.000000000 +0000
@@ -36,7 +36,7 @@
 
 #include <asm/pgtable.h>
 #include <asm/irq.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 #include "fcp_impl.h"
 #include <scsi/scsi_host.h>
 
@@ -106,7 +106,7 @@ fc_channel *fc_channels = NULL;
 #define LSMAGIC	620829043
 typedef struct {
 	/* Must be first */
-	struct semaphore sem;
+	struct mutex sem;
 	int magic;
 	int count;
 	logi *logi;
@@ -119,7 +119,7 @@ typedef struct {
 #define LSOMAGIC 654907799
 typedef struct {
 	/* Must be first */
-	struct semaphore sem;
+	struct mutex sem;
 	int magic;
 	int count;
 	fcp_cmnd *fcmds;
@@ -130,7 +130,7 @@ typedef struct {
 #define LSEMAGIC 84482456
 typedef struct {
 	/* Must be first */
-	struct semaphore sem;
+	struct mutex sem;
 	int magic;
 	int status;
 	struct timer_list timer;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/firmware/dcdbas.c linux-2.6.15-rc5-mutex/drivers/firmware/dcdbas.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/firmware/dcdbas.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/firmware/dcdbas.c	2005-12-12 22:08:48.000000000 +0000
@@ -34,7 +34,7 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <asm/io.h>
-#include <asm/semaphore.h>
+#include <linux/semaphore.h>
 
 #include "dcdbas.h"
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/adm1021.c linux-2.6.15-rc5-mutex/drivers/hwmon/adm1021.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/adm1021.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/hwmon/adm1021.c	2005-12-12 21:36:44.000000000 +0000
@@ -92,7 +92,7 @@ struct adm1021_data {
 	struct class_device *class_dev;
 	enum chips type;
 
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/adm1025.c linux-2.6.15-rc5-mutex/drivers/hwmon/adm1025.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/adm1025.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/hwmon/adm1025.c	2005-12-12 21:36:59.000000000 +0000
@@ -133,7 +133,7 @@ static struct i2c_driver adm1025_driver 
 struct adm1025_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/adm1026.c linux-2.6.15-rc5-mutex/drivers/hwmon/adm1026.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/adm1026.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/hwmon/adm1026.c	2005-12-12 21:46:25.000000000 +0000
@@ -260,10 +260,10 @@ struct pwm_data {
 struct adm1026_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore lock;
+	struct mutex lock;
 	enum chips type;
 
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	int valid;		/* !=0 if following fields are valid */
 	unsigned long last_reading;	/* In jiffies */
 	unsigned long last_config;	/* In jiffies */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/adm1031.c linux-2.6.15-rc5-mutex/drivers/hwmon/adm1031.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/adm1031.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/hwmon/adm1031.c	2005-12-12 21:35:55.000000000 +0000
@@ -70,7 +70,7 @@ typedef u8 auto_chan_table_t[8][2];
 struct adm1031_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	int chip_type;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/adm9240.c linux-2.6.15-rc5-mutex/drivers/hwmon/adm9240.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/adm9240.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/hwmon/adm9240.c	2005-12-12 21:34:47.000000000 +0000
@@ -150,7 +150,7 @@ struct adm9240_data {
 	enum chips type;
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid;
 	unsigned long last_updated_measure;
 	unsigned long last_updated_config;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/asb100.c linux-2.6.15-rc5-mutex/drivers/hwmon/asb100.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/asb100.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/hwmon/asb100.c	2005-12-12 21:36:30.000000000 +0000
@@ -182,10 +182,10 @@ static u8 DIV_TO_REG(long val)
 struct asb100_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore lock;
+	struct mutex lock;
 	enum chips type;
 
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	unsigned long last_updated;	/* In jiffies */
 
 	/* array of 2 pointers to subclients */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/atxp1.c linux-2.6.15-rc5-mutex/drivers/hwmon/atxp1.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/atxp1.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/hwmon/atxp1.c	2005-12-12 21:32:52.000000000 +0000
@@ -60,7 +60,7 @@ static struct i2c_driver atxp1_driver = 
 struct atxp1_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	unsigned long last_updated;
 	u8 valid;
 	struct {
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/ds1621.c linux-2.6.15-rc5-mutex/drivers/hwmon/ds1621.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/ds1621.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/hwmon/ds1621.c	2005-12-12 21:36:07.000000000 +0000
@@ -72,7 +72,7 @@ MODULE_PARM_DESC(polarity, "Output's pol
 struct ds1621_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid;			/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/fscher.c linux-2.6.15-rc5-mutex/drivers/hwmon/fscher.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/fscher.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/hwmon/fscher.c	2005-12-12 21:36:23.000000000 +0000
@@ -133,7 +133,7 @@ static struct i2c_driver fscher_driver =
 struct fscher_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/fscpos.c linux-2.6.15-rc5-mutex/drivers/hwmon/fscpos.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/fscpos.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/hwmon/fscpos.c	2005-12-12 21:32:08.000000000 +0000
@@ -114,7 +114,7 @@ static struct i2c_driver fscpos_driver =
 struct fscpos_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid; 		/* 0 until following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/gl518sm.c linux-2.6.15-rc5-mutex/drivers/hwmon/gl518sm.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/gl518sm.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/hwmon/gl518sm.c	2005-12-12 21:36:40.000000000 +0000
@@ -120,7 +120,7 @@ struct gl518_data {
 	struct class_device *class_dev;
 	enum chips type;
 
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/gl520sm.c linux-2.6.15-rc5-mutex/drivers/hwmon/gl520sm.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/gl520sm.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/hwmon/gl520sm.c	2005-12-12 21:34:43.000000000 +0000
@@ -121,7 +121,7 @@ static struct i2c_driver gl520_driver = 
 struct gl520_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid;		/* zero until the following fields are valid */
 	unsigned long last_updated;	/* in jiffies */
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/it87.c linux-2.6.15-rc5-mutex/drivers/hwmon/it87.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/it87.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/hwmon/it87.c	2005-12-12 21:36:10.000000000 +0000
@@ -195,10 +195,10 @@ static int DIV_TO_REG(int val)
 struct it87_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore lock;
+	struct mutex lock;
 	enum chips type;
 
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/lm63.c linux-2.6.15-rc5-mutex/drivers/hwmon/lm63.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/lm63.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/hwmon/lm63.c	2005-12-12 21:34:13.000000000 +0000
@@ -153,7 +153,7 @@ static struct i2c_driver lm63_driver = {
 struct lm63_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/lm75.c linux-2.6.15-rc5-mutex/drivers/hwmon/lm75.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/lm75.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/hwmon/lm75.c	2005-12-12 21:36:04.000000000 +0000
@@ -47,7 +47,7 @@ I2C_CLIENT_INSMOD_1(lm75);
 struct lm75_data {
 	struct i2c_client	client;
 	struct class_device *class_dev;
-	struct semaphore	update_lock;
+	struct mutex		update_lock;
 	char			valid;		/* !=0 if following fields are valid */
 	unsigned long		last_updated;	/* In jiffies */
 	u16			temp_input;	/* Register values */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/lm77.c linux-2.6.15-rc5-mutex/drivers/hwmon/lm77.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/lm77.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/hwmon/lm77.c	2005-12-12 21:32:04.000000000 +0000
@@ -51,7 +51,7 @@ I2C_CLIENT_INSMOD_1(lm77);
 struct lm77_data {
 	struct i2c_client	client;
 	struct class_device *class_dev;
-	struct semaphore	update_lock;
+	struct mutex		update_lock;
 	char			valid;
 	unsigned long		last_updated;	/* In jiffies */
 	int			temp_input;	/* Temperatures */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/lm78.c linux-2.6.15-rc5-mutex/drivers/hwmon/lm78.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/lm78.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/hwmon/lm78.c	2005-12-12 21:34:34.000000000 +0000
@@ -131,10 +131,10 @@ static inline int TEMP_FROM_REG(s8 val)
 struct lm78_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore lock;
+	struct mutex lock;
 	enum chips type;
 
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/lm80.c linux-2.6.15-rc5-mutex/drivers/hwmon/lm80.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/lm80.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/hwmon/lm80.c	2005-12-12 21:35:36.000000000 +0000
@@ -108,7 +108,7 @@ static inline long TEMP_FROM_REG(u16 tem
 struct lm80_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/lm83.c linux-2.6.15-rc5-mutex/drivers/hwmon/lm83.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/lm83.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/hwmon/lm83.c	2005-12-12 21:33:05.000000000 +0000
@@ -139,7 +139,7 @@ static struct i2c_driver lm83_driver = {
 struct lm83_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/lm85.c linux-2.6.15-rc5-mutex/drivers/hwmon/lm85.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/lm85.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/hwmon/lm85.c	2005-12-12 21:46:29.000000000 +0000
@@ -331,10 +331,10 @@ struct lm85_autofan {
 struct lm85_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore lock;
+	struct mutex lock;
 	enum chips type;
 
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	int valid;		/* !=0 if following fields are valid */
 	unsigned long last_reading;	/* In jiffies */
 	unsigned long last_config;	/* In jiffies */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/lm87.c linux-2.6.15-rc5-mutex/drivers/hwmon/lm87.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/lm87.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/hwmon/lm87.c	2005-12-12 21:35:26.000000000 +0000
@@ -176,7 +176,7 @@ static struct i2c_driver lm87_driver = {
 struct lm87_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* In jiffies */
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/lm90.c linux-2.6.15-rc5-mutex/drivers/hwmon/lm90.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/lm90.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/hwmon/lm90.c	2005-12-12 21:35:33.000000000 +0000
@@ -201,7 +201,7 @@ static struct i2c_driver lm90_driver = {
 struct lm90_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
 	int kind;
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/lm92.c linux-2.6.15-rc5-mutex/drivers/hwmon/lm92.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/lm92.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/hwmon/lm92.c	2005-12-12 21:32:22.000000000 +0000
@@ -96,7 +96,7 @@ static struct i2c_driver lm92_driver;
 struct lm92_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/max1619.c linux-2.6.15-rc5-mutex/drivers/hwmon/max1619.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/max1619.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/hwmon/max1619.c	2005-12-12 21:32:26.000000000 +0000
@@ -104,7 +104,7 @@ static struct i2c_driver max1619_driver 
 struct max1619_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/pc87360.c linux-2.6.15-rc5-mutex/drivers/hwmon/pc87360.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/pc87360.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/hwmon/pc87360.c	2005-12-12 21:35:18.000000000 +0000
@@ -183,8 +183,8 @@ static inline u8 PWM_TO_REG(int val, int
 struct pc87360_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore lock;
-	struct semaphore update_lock;
+	struct mutex lock;
+	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/sis5595.c linux-2.6.15-rc5-mutex/drivers/hwmon/sis5595.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/sis5595.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/hwmon/sis5595.c	2005-12-12 21:36:53.000000000 +0000
@@ -167,9 +167,9 @@ static inline u8 DIV_TO_REG(int val)
 struct sis5595_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore lock;
+	struct mutex lock;
 
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 	char maxins;		/* == 3 if temp enabled, otherwise == 4 */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/smsc47b397.c linux-2.6.15-rc5-mutex/drivers/hwmon/smsc47b397.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/smsc47b397.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/hwmon/smsc47b397.c	2005-12-12 21:32:47.000000000 +0000
@@ -92,9 +92,9 @@ static u8 smsc47b397_reg_temp[] = {0x25,
 struct smsc47b397_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore lock;
+	struct mutex lock;
 
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	unsigned long last_updated; /* in jiffies */
 	int valid;
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/smsc47m1.c linux-2.6.15-rc5-mutex/drivers/hwmon/smsc47m1.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/smsc47m1.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/hwmon/smsc47m1.c	2005-12-12 21:36:47.000000000 +0000
@@ -102,9 +102,9 @@ superio_exit(void)
 struct smsc47m1_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore lock;
+	struct mutex lock;
 
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	unsigned long last_updated;	/* In jiffies */
 
 	u8 fan[2];		/* Register value */
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/via686a.c linux-2.6.15-rc5-mutex/drivers/hwmon/via686a.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/via686a.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/hwmon/via686a.c	2005-12-12 21:32:38.000000000 +0000
@@ -296,7 +296,7 @@ static inline long TEMP_FROM_REG10(u16 v
 struct via686a_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/w83627ehf.c linux-2.6.15-rc5-mutex/drivers/hwmon/w83627ehf.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/w83627ehf.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/hwmon/w83627ehf.c	2005-12-12 21:36:26.000000000 +0000
@@ -177,9 +177,9 @@ temp1_to_reg(int temp)
 struct w83627ehf_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore lock;
+	struct mutex lock;
 
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/w83627hf.c linux-2.6.15-rc5-mutex/drivers/hwmon/w83627hf.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/w83627hf.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/hwmon/w83627hf.c	2005-12-12 21:35:50.000000000 +0000
@@ -285,10 +285,10 @@ static inline u8 DIV_TO_REG(long val)
 struct w83627hf_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore lock;
+	struct mutex lock;
 	enum chips type;
 
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/w83781d.c linux-2.6.15-rc5-mutex/drivers/hwmon/w83781d.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/w83781d.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/hwmon/w83781d.c	2005-12-12 21:34:06.000000000 +0000
@@ -221,10 +221,10 @@ DIV_TO_REG(long val, enum chips type)
 struct w83781d_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore lock;
+	struct mutex lock;
 	enum chips type;
 
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/w83792d.c linux-2.6.15-rc5-mutex/drivers/hwmon/w83792d.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/w83792d.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/hwmon/w83792d.c	2005-12-12 21:35:10.000000000 +0000
@@ -269,10 +269,10 @@ DIV_TO_REG(long val)
 struct w83792d_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore lock;
+	struct mutex lock;
 	enum chips type;
 
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 
diff -uNrp /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/w83l785ts.c linux-2.6.15-rc5-mutex/drivers/hwmon/w83l785ts.c
--- /warthog/kernels/linux-2.6.15-rc5/drivers/hwmon/w83l785ts.c	2005-12-08 16:23:39.000000000 +0000
+++ linux-2.6.15-rc5-mutex/drivers/hwmon/w83l785ts.c	2005-12-12 21:35:47.000000000 +0000
@@ -107,7 +107,7 @@ static struct i2c_driver w83l785ts_drive
 struct w83l785ts_data {
 	struct i2c_client client;
 	struct class_device *class_dev;
-	struct semaphore update_lock;
+	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
 
