Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964885AbVKGVIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbVKGVIg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbVKGVIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:08:36 -0500
Received: from outmx013.isp.belgacom.be ([195.238.3.64]:46254 "EHLO
	outmx013.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S932349AbVKGVIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:08:35 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] wireless net: Conversions of kmalloc/memset to kzalloc
Reply-To: takis@issaris.org
Message-Id: <20051107210754.76075206FC@localhost.localdomain>
Date: Mon,  7 Nov 2005 22:07:54 +0100 (CET)
From: takis@issaris.org (Panagiotis Issaris)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More conversions of kmalloc/memset to kzalloc

Signed-off-by: Panagiotis Issaris <takis@issaris.org>

---

 drivers/net/wireless/airo.c       |   36 ++++++++++++------------------------
 drivers/net/wireless/airo_cs.c    |    6 ++----
 drivers/net/wireless/atmel_cs.c   |    6 ++----
 drivers/net/wireless/ipw2100.c    |    4 +---
 drivers/net/wireless/wavelan_cs.c |    3 +--
 drivers/net/wireless/wl3501_cs.c  |    3 +--
 6 files changed, 19 insertions(+), 39 deletions(-)

applies-to: 2dab107649090185fd27fa9fa9cf40396c670998
3925f02b002accf8e054bc6673d6367310db3bae
diff --git a/drivers/net/wireless/airo.c b/drivers/net/wireless/airo.c
index 6afc6e5..340ab4e 100644
--- a/drivers/net/wireless/airo.c
+++ b/drivers/net/wireless/airo.c
@@ -4535,9 +4535,8 @@ static int proc_status_open( struct inod
 	StatusRid status_rid;
 	int i;
 
-	if ((file->private_data = kmalloc(sizeof(struct proc_data ), GFP_KERNEL)) == NULL)
+	if ((file->private_data = kzalloc(sizeof(struct proc_data ), GFP_KERNEL)) == NULL)
 		return -ENOMEM;
-	memset(file->private_data, 0, sizeof(struct proc_data));
 	data = (struct proc_data *)file->private_data;
 	if ((data->rbuffer = kmalloc( 2048, GFP_KERNEL )) == NULL) {
 		kfree (file->private_data);
@@ -4615,9 +4614,8 @@ static int proc_stats_rid_open( struct i
 	int i, j;
 	u32 *vals = stats.vals;
 
-	if ((file->private_data = kmalloc(sizeof(struct proc_data ), GFP_KERNEL)) == NULL)
+	if ((file->private_data = kzalloc(sizeof(struct proc_data ), GFP_KERNEL)) == NULL)
 		return -ENOMEM;
-	memset(file->private_data, 0, sizeof(struct proc_data));
 	data = (struct proc_data *)file->private_data;
 	if ((data->rbuffer = kmalloc( 4096, GFP_KERNEL )) == NULL) {
 		kfree (file->private_data);
@@ -4881,20 +4879,18 @@ static int proc_config_open( struct inod
 	struct airo_info *ai = dev->priv;
 	int i;
 
-	if ((file->private_data = kmalloc(sizeof(struct proc_data ), GFP_KERNEL)) == NULL)
+	if ((file->private_data = kzalloc(sizeof(struct proc_data ), GFP_KERNEL)) == NULL)
 		return -ENOMEM;
-	memset(file->private_data, 0, sizeof(struct proc_data));
 	data = (struct proc_data *)file->private_data;
 	if ((data->rbuffer = kmalloc( 2048, GFP_KERNEL )) == NULL) {
 		kfree (file->private_data);
 		return -ENOMEM;
 	}
-	if ((data->wbuffer = kmalloc( 2048, GFP_KERNEL )) == NULL) {
+	if ((data->wbuffer = kzalloc( 2048, GFP_KERNEL )) == NULL) {
 		kfree (data->rbuffer);
 		kfree (file->private_data);
 		return -ENOMEM;
 	}
-	memset( data->wbuffer, 0, 2048 );
 	data->maxwritelen = 2048;
 	data->on_close = proc_config_on_close;
 
@@ -5155,24 +5151,21 @@ static int proc_wepkey_open( struct inod
 	int j=0;
 	int rc;
 
-	if ((file->private_data = kmalloc(sizeof(struct proc_data ), GFP_KERNEL)) == NULL)
+	if ((file->private_data = kzalloc(sizeof(struct proc_data ), GFP_KERNEL)) == NULL)
 		return -ENOMEM;
-	memset(file->private_data, 0, sizeof(struct proc_data));
 	memset(&wkr, 0, sizeof(wkr));
 	data = (struct proc_data *)file->private_data;
-	if ((data->rbuffer = kmalloc( 180, GFP_KERNEL )) == NULL) {
+	if ((data->rbuffer = kzalloc( 180, GFP_KERNEL )) == NULL) {
 		kfree (file->private_data);
 		return -ENOMEM;
 	}
-	memset(data->rbuffer, 0, 180);
 	data->writelen = 0;
 	data->maxwritelen = 80;
-	if ((data->wbuffer = kmalloc( 80, GFP_KERNEL )) == NULL) {
+	if ((data->wbuffer = kzalloc( 80, GFP_KERNEL )) == NULL) {
 		kfree (data->rbuffer);
 		kfree (file->private_data);
 		return -ENOMEM;
 	}
-	memset( data->wbuffer, 0, 80 );
 	data->on_close = proc_wepkey_on_close;
 
 	ptr = data->rbuffer;
@@ -5203,9 +5196,8 @@ static int proc_SSID_open( struct inode 
 	char *ptr;
 	SsidRid SSID_rid;
 
-	if ((file->private_data = kmalloc(sizeof(struct proc_data ), GFP_KERNEL)) == NULL)
+	if ((file->private_data = kzalloc(sizeof(struct proc_data ), GFP_KERNEL)) == NULL)
 		return -ENOMEM;
-	memset(file->private_data, 0, sizeof(struct proc_data));
 	data = (struct proc_data *)file->private_data;
 	if ((data->rbuffer = kmalloc( 104, GFP_KERNEL )) == NULL) {
 		kfree (file->private_data);
@@ -5213,12 +5205,11 @@ static int proc_SSID_open( struct inode 
 	}
 	data->writelen = 0;
 	data->maxwritelen = 33*3;
-	if ((data->wbuffer = kmalloc( 33*3, GFP_KERNEL )) == NULL) {
+	if ((data->wbuffer = kzalloc( 33*3, GFP_KERNEL )) == NULL) {
 		kfree (data->rbuffer);
 		kfree (file->private_data);
 		return -ENOMEM;
 	}
-	memset( data->wbuffer, 0, 33*3 );
 	data->on_close = proc_SSID_on_close;
 
 	readSsidRid(ai, &SSID_rid);
@@ -5247,9 +5238,8 @@ static int proc_APList_open( struct inod
 	char *ptr;
 	APListRid APList_rid;
 
-	if ((file->private_data = kmalloc(sizeof(struct proc_data ), GFP_KERNEL)) == NULL)
+	if ((file->private_data = kzalloc(sizeof(struct proc_data ), GFP_KERNEL)) == NULL)
 		return -ENOMEM;
-	memset(file->private_data, 0, sizeof(struct proc_data));
 	data = (struct proc_data *)file->private_data;
 	if ((data->rbuffer = kmalloc( 104, GFP_KERNEL )) == NULL) {
 		kfree (file->private_data);
@@ -5257,12 +5247,11 @@ static int proc_APList_open( struct inod
 	}
 	data->writelen = 0;
 	data->maxwritelen = 4*6*3;
-	if ((data->wbuffer = kmalloc( data->maxwritelen, GFP_KERNEL )) == NULL) {
+	if ((data->wbuffer = kzalloc( data->maxwritelen, GFP_KERNEL )) == NULL) {
 		kfree (data->rbuffer);
 		kfree (file->private_data);
 		return -ENOMEM;
 	}
-	memset( data->wbuffer, 0, data->maxwritelen );
 	data->on_close = proc_APList_on_close;
 
 	readAPListRid(ai, &APList_rid);
@@ -5297,9 +5286,8 @@ static int proc_BSSList_open( struct ino
 	/* If doLoseSync is not 1, we won't do a Lose Sync */
 	int doLoseSync = -1;
 
-	if ((file->private_data = kmalloc(sizeof(struct proc_data ), GFP_KERNEL)) == NULL)
+	if ((file->private_data = kzalloc(sizeof(struct proc_data ), GFP_KERNEL)) == NULL)
 		return -ENOMEM;
-	memset(file->private_data, 0, sizeof(struct proc_data));
 	data = (struct proc_data *)file->private_data;
 	if ((data->rbuffer = kmalloc( 1024, GFP_KERNEL )) == NULL) {
 		kfree (file->private_data);
diff --git a/drivers/net/wireless/airo_cs.c b/drivers/net/wireless/airo_cs.c
index 96ed8da..e328547 100644
--- a/drivers/net/wireless/airo_cs.c
+++ b/drivers/net/wireless/airo_cs.c
@@ -170,12 +170,11 @@ static dev_link_t *airo_attach(void)
 	DEBUG(0, "airo_attach()\n");
 
 	/* Initialize the dev_link_t structure */
-	link = kmalloc(sizeof(struct dev_link_t), GFP_KERNEL);
+	link = kzalloc(sizeof(struct dev_link_t), GFP_KERNEL);
 	if (!link) {
 		printk(KERN_ERR "airo_cs: no memory for new device\n");
 		return NULL;
 	}
-	memset(link, 0, sizeof(struct dev_link_t));
 	
 	/* Interrupt setup */
 	link->irq.Attributes = IRQ_TYPE_EXCLUSIVE;
@@ -194,13 +193,12 @@ static dev_link_t *airo_attach(void)
 	link->conf.IntType = INT_MEMORY_AND_IO;
 	
 	/* Allocate space for private device-specific data */
-	local = kmalloc(sizeof(local_info_t), GFP_KERNEL);
+	local = kzalloc(sizeof(local_info_t), GFP_KERNEL);
 	if (!local) {
 		printk(KERN_ERR "airo_cs: no memory for new device\n");
 		kfree (link);
 		return NULL;
 	}
-	memset(local, 0, sizeof(local_info_t));
 	link->priv = local;
 	
 	/* Register with Card Services */
diff --git a/drivers/net/wireless/atmel_cs.c b/drivers/net/wireless/atmel_cs.c
index 195cb36..1bd1314 100644
--- a/drivers/net/wireless/atmel_cs.c
+++ b/drivers/net/wireless/atmel_cs.c
@@ -180,12 +180,11 @@ static dev_link_t *atmel_attach(void)
 	DEBUG(0, "atmel_attach()\n");
 
 	/* Initialize the dev_link_t structure */
-	link = kmalloc(sizeof(struct dev_link_t), GFP_KERNEL);
+	link = kzalloc(sizeof(struct dev_link_t), GFP_KERNEL);
 	if (!link) {
 		printk(KERN_ERR "atmel_cs: no memory for new device\n");
 		return NULL;
 	}
-	memset(link, 0, sizeof(struct dev_link_t));
 	
 	/* Interrupt setup */
 	link->irq.Attributes = IRQ_TYPE_EXCLUSIVE;
@@ -204,13 +203,12 @@ static dev_link_t *atmel_attach(void)
 	link->conf.IntType = INT_MEMORY_AND_IO;
 	
 	/* Allocate space for private device-specific data */
-	local = kmalloc(sizeof(local_info_t), GFP_KERNEL);
+	local = kzalloc(sizeof(local_info_t), GFP_KERNEL);
 	if (!local) {
 		printk(KERN_ERR "atmel_cs: no memory for new device\n");
 		kfree (link);
 		return NULL;
 	}
-	memset(local, 0, sizeof(local_info_t));
 	link->priv = local;
 	
 	/* Register with Card Services */
diff --git a/drivers/net/wireless/ipw2100.c b/drivers/net/wireless/ipw2100.c
index ad7f8cd..4f19ac7 100644
--- a/drivers/net/wireless/ipw2100.c
+++ b/drivers/net/wireless/ipw2100.c
@@ -6065,13 +6065,11 @@ static int ipw2100_wpa_set_encryption(st
 
 		ieee80211_crypt_delayed_deinit(ieee, crypt);
 
-		new_crypt = (struct ieee80211_crypt_data *)
-			kmalloc(sizeof(struct ieee80211_crypt_data), GFP_KERNEL);
+		new_crypt = kzalloc(sizeof(struct ieee80211_crypt_data), GFP_KERNEL);
 		if (new_crypt == NULL) {
 			ret = -ENOMEM;
 			goto done;
 		}
-		memset(new_crypt, 0, sizeof(struct ieee80211_crypt_data));
 		new_crypt->ops = ops;
 		if (new_crypt->ops && try_module_get(new_crypt->ops->owner))
 			new_crypt->priv = new_crypt->ops->init(param->u.crypt.idx);
diff --git a/drivers/net/wireless/wavelan_cs.c b/drivers/net/wireless/wavelan_cs.c
index 4b3c98f..c822cad 100644
--- a/drivers/net/wireless/wavelan_cs.c
+++ b/drivers/net/wireless/wavelan_cs.c
@@ -4608,9 +4608,8 @@ wavelan_attach(void)
 #endif
 
   /* Initialize the dev_link_t structure */
-  link = kmalloc(sizeof(struct dev_link_t), GFP_KERNEL);
+  link = kzalloc(sizeof(struct dev_link_t), GFP_KERNEL);
   if (!link) return NULL;
-  memset(link, 0, sizeof(struct dev_link_t));
 
   /* The io structure describes IO port mapping */
   link->io.NumPorts1 = 8;
diff --git a/drivers/net/wireless/wl3501_cs.c b/drivers/net/wireless/wl3501_cs.c
index 3f8c27f..978fdc6 100644
--- a/drivers/net/wireless/wl3501_cs.c
+++ b/drivers/net/wireless/wl3501_cs.c
@@ -1965,10 +1965,9 @@ static dev_link_t *wl3501_attach(void)
 	int ret;
 
 	/* Initialize the dev_link_t structure */
-	link = kmalloc(sizeof(*link), GFP_KERNEL);
+	link = kzalloc(sizeof(*link), GFP_KERNEL);
 	if (!link)
 		goto out;
-	memset(link, 0, sizeof(struct dev_link_t));
 
 	/* The io structure describes IO port mapping */
 	link->io.NumPorts1	= 16;
---
0.99.9.GIT
