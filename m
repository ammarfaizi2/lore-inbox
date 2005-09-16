Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbVIPXRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbVIPXRh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 19:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbVIPXRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 19:17:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18848 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750731AbVIPXRg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 19:17:36 -0400
Date: Fri, 16 Sep 2005 16:17:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Abhay Salunke <Abhay_Salunke@dell.com>
Cc: linux-kernel@vger.kernel.org, abhay_salunke@dell.com
Subject: Re: [patch 2.6.14-rc1] Enhancements and fixes for dell_rbu driver
Message-Id: <20050916161701.0a9beffd.akpm@osdl.org>
In-Reply-To: <20050916221000.GA3454@abhays.us.dell.com>
References: <20050916221000.GA3454@abhays.us.dell.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Abhay Salunke <Abhay_Salunke@dell.com> wrote:
>
> -static __exit void dcdrbu_exit(void)
>  +static __exit void
>  +dcdrbu_exit(void)

hm, all these extraneous whitespace changes actually take the driver
further away from preferred coding style.

How about we do this?


diff -puN drivers/firmware/dell_rbu.c~dell_rbu-tidy drivers/firmware/dell_rbu.c
--- devel/drivers/firmware/dell_rbu.c~dell_rbu-tidy	2005-09-16 16:15:27.000000000 -0700
+++ devel-akpm/drivers/firmware/dell_rbu.c	2005-09-16 16:15:27.000000000 -0700
@@ -85,8 +85,7 @@ static struct platform_device *rbu_devic
 static int context;
 static dma_addr_t dell_rbu_dmaaddr;
 
-static void
-init_packet_head(void)
+static void init_packet_head(void)
 {
 	INIT_LIST_HEAD(&packet_data_head.list);
 	rbu_data.packet_write_count = 0;
@@ -95,8 +94,7 @@ init_packet_head(void)
 	rbu_data.packetsize = 0;
 }
 
-static int
-fill_last_packet(void *data, size_t length)
+static int fill_last_packet(void *data, size_t length)
 {
 	struct list_head *ptemp_list;
 	struct packet_data *packet = NULL;
@@ -138,8 +136,7 @@ fill_last_packet(void *data, size_t leng
 	return 0;
 }
 
-static int
-create_packet(size_t length)
+static int create_packet(size_t length)
 {
 	struct packet_data *newpacket;
 	int ordernum = 0;
@@ -198,8 +195,7 @@ create_packet(size_t length)
 	return 0;
 }
 
-static int
-packetize_data(void *data, size_t length)
+static int packetize_data(void *data, size_t length)
 {
 	int rc = 0;
 
@@ -213,8 +209,7 @@ packetize_data(void *data, size_t length
 	return rc;
 }
 
-static int
-do_packet_read(char *data, struct list_head *ptemp_list,
+static int do_packet_read(char *data, struct list_head *ptemp_list,
 	int length, int bytes_read, int *list_read_count)
 {
 	void *ptemp_buf;
@@ -248,8 +243,7 @@ do_packet_read(char *data, struct list_h
 	return bytes_copied;
 }
 
-static int
-packet_read_list(char *data, size_t * pread_length)
+static int packet_read_list(char *data, size_t *pread_length)
 {
 	struct list_head *ptemp_list;
 	int temp_count = 0;
@@ -287,8 +281,7 @@ packet_read_list(char *data, size_t * pr
 	return 0;
 }
 
-static void
-packet_empty_list(void)
+static void packet_empty_list(void)
 {
 	struct list_head *ptemp_list;
 	struct list_head *pnext_list;
@@ -320,8 +313,7 @@ packet_empty_list(void)
  * img_update_free: Frees the buffer allocated for storing BIOS image
  * Always called with lock held and returned with lock held
  */
-static void
-img_update_free(void)
+static void img_update_free(void)
 {
 	if (!rbu_data.image_update_buffer)
 		return;
@@ -358,8 +350,7 @@ img_update_free(void)
  * already allocated size, then that memory is reused. This function is
  * called with lock held and returns with lock held.
  */
-static int
-img_update_realloc(unsigned long size)
+static int img_update_realloc(unsigned long size)
 {
 	unsigned char *image_update_buffer = NULL;
 	unsigned long rc;
@@ -428,8 +419,7 @@ img_update_realloc(unsigned long size)
 	return rc;
 }
 
-static ssize_t
-read_packet_data(char *buffer, loff_t pos, size_t count)
+static ssize_t read_packet_data(char *buffer, loff_t pos, size_t count)
 {
 	int retval;
 	size_t bytes_left;
@@ -470,8 +460,7 @@ read_packet_data(char *buffer, loff_t po
 	return retval;
 }
 
-static ssize_t
-read_rbu_mono_data(char *buffer, loff_t pos, size_t count)
+static ssize_t read_rbu_mono_data(char *buffer, loff_t pos, size_t count)
 {
 	unsigned char *ptemp = NULL;
 	size_t bytes_left = 0;
@@ -509,8 +498,8 @@ read_rbu_mono_data(char *buffer, loff_t 
 	return ret_count;
 }
 
-static ssize_t
-read_rbu_data(struct kobject *kobj, char *buffer, loff_t pos, size_t count)
+static ssize_t read_rbu_data(struct kobject *kobj, char *buffer,
+			loff_t pos, size_t count)
 {
 	ssize_t ret_count = 0;
 
@@ -527,8 +516,7 @@ read_rbu_data(struct kobject *kobj, char
 	return ret_count;
 }
 
-static void
-callbackfn_rbu(const struct firmware *fw, void *context)
+static void callbackfn_rbu(const struct firmware *fw, void *context)
 {
 	int rc = 0;
 
@@ -564,9 +552,8 @@ callbackfn_rbu(const struct firmware *fw
 		rbu_data.entry_created = 1;
 }
 
-static ssize_t
-read_rbu_image_type(struct kobject *kobj, char *buffer, loff_t pos,
-	size_t count)
+static ssize_t read_rbu_image_type(struct kobject *kobj, char *buffer,
+			loff_t pos, size_t count)
 {
 	int size = 0;
 	if (!pos)
@@ -574,9 +561,8 @@ read_rbu_image_type(struct kobject *kobj
 	return size;
 }
 
-static ssize_t
-write_rbu_image_type(struct kobject *kobj, char *buffer, loff_t pos,
-	size_t count)
+static ssize_t write_rbu_image_type(struct kobject *kobj, char *buffer,
+			loff_t pos, size_t count)
 {
 	int rc = count;
 	int req_firm_rc = 0;
@@ -636,18 +622,25 @@ write_rbu_image_type(struct kobject *kob
 }
 
 static struct bin_attribute rbu_data_attr = {
-	.attr = {.name = "data",.owner = THIS_MODULE,.mode = 0444},
+	.attr = {
+		.name = "data",
+		.owner = THIS_MODULE,
+		.mode = 0444,
+	},
 	.read = read_rbu_data,
 };
 
 static struct bin_attribute rbu_image_type_attr = {
-	.attr = {.name = "image_type",.owner = THIS_MODULE,.mode = 0644},
+	.attr = {
+		.name = "image_type",
+		.owner = THIS_MODULE,
+		.mode = 0644,
+	},
 	.read = read_rbu_image_type,
 	.write = write_rbu_image_type,
 };
 
-static int __init
-dcdrbu_init(void)
+static int __init dcdrbu_init(void)
 {
 	int rc = 0;
 	spin_lock_init(&rbu_data.lock);
@@ -677,8 +670,7 @@ dcdrbu_init(void)
 
 }
 
-static __exit void
-dcdrbu_exit(void)
+static __exit void dcdrbu_exit(void)
 {
 	spin_lock(&rbu_data.lock);
 	packet_empty_list();
_

