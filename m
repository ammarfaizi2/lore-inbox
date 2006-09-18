Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965190AbWIRAyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965190AbWIRAyJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 20:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965191AbWIRAyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 20:54:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:2839 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965190AbWIRAx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 20:53:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Ey7skSPDljLsWYMtvwYFEiKpQv7cLsl5kzUjHsndtPuD4758PpGBhA2zrI7TETZFCRu6yJ64EuMND3hDkr1+HLBODqyujojjDzvDBzyevs0bNzKY8uQMtbZFkPHVUlpGFLIjq9eIVuxuDLwy90yrQ7PPd6OfmI7JnjM2fT+Xgd4=
Message-ID: <6b4e42d10609171753m2a047081qc2982bf4a693a044@mail.gmail.com>
Date: Sun, 17 Sep 2006 17:53:58 -0700
From: "Om Narasimhan" <om.turyx@gmail.com>
To: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Subject: kmalloc to kzalloc patches for drivers/base
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tested by compiling.

Signed off by Om Narasimhan <om.turyx@gmail.com>


drivers/base/class.c          |    2 +-
 drivers/base/dmapool.c        |    4 ++--
 drivers/base/firmware_class.c |    2 +-
 drivers/base/map.c            |    4 ++--
 drivers/base/platform.c       |    4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index de89083..4858d3a 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -511,7 +511,7 @@ char *make_class_name(const char *name,

 	size = strlen(name) + strlen(kobject_name(kobj)) + 2;

-	class_name = kmalloc(size, GFP_KERNEL);
+	class_name = kzalloc(size, GFP_KERNEL);
 	if (!class_name)
 		return ERR_PTR(-ENOMEM);

diff --git a/drivers/base/dmapool.c b/drivers/base/dmapool.c
index 33c5cce..a9558c3 100644
--- a/drivers/base/dmapool.c
+++ b/drivers/base/dmapool.c
@@ -126,7 +126,7 @@ dma_pool_create (const char *name, struc
 	} else if (allocation < size)
 		return NULL;

-	if (!(retval = kmalloc (sizeof *retval, SLAB_KERNEL)))
+	if (!(retval = kzalloc (sizeof *retval, SLAB_KERNEL)))
 		return retval;

 	strlcpy (retval->name, name, sizeof retval->name);
@@ -164,7 +164,7 @@ pool_alloc_page (struct dma_pool *pool,
 	mapsize = (mapsize + BITS_PER_LONG - 1) / BITS_PER_LONG;
 	mapsize *= sizeof (long);

-	page = (struct dma_page *) kmalloc (mapsize + sizeof *page, mem_flags);
+	page = (struct dma_page *) kzalloc (mapsize + sizeof *page, mem_flags);
 	if (!page)
 		return NULL;
 	page->vaddr = dma_alloc_coherent (pool->dev,
diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
index 5d6c011..3b6348d 100644
--- a/drivers/base/firmware_class.c
+++ b/drivers/base/firmware_class.c
@@ -546,7 +546,7 @@ request_firmware_nowait(
 	const char *name, struct device *device, void *context,
 	void (*cont)(const struct firmware *fw, void *context))
 {
-	struct firmware_work *fw_work = kmalloc(sizeof (struct firmware_work),
+	struct firmware_work *fw_work = kzalloc(sizeof (struct firmware_work),
 						GFP_ATOMIC);
 	int ret;

diff --git a/drivers/base/map.c b/drivers/base/map.c
index e87017f..4e389b2 100644
--- a/drivers/base/map.c
+++ b/drivers/base/map.c
@@ -41,7 +41,7 @@ int kobj_map(struct kobj_map *domain, de
 	if (n > 255)
 		n = 255;

-	p = kmalloc(sizeof(struct probe) * n, GFP_KERNEL);
+	p = kzalloc(sizeof(struct probe) * n, GFP_KERNEL);

 	if (p == NULL)
 		return -ENOMEM;
@@ -135,7 +135,7 @@ retry:

 struct kobj_map *kobj_map_init(kobj_probe_t *base_probe, struct mutex *lock)
 {
-	struct kobj_map *p = kmalloc(sizeof(struct kobj_map), GFP_KERNEL);
+	struct kobj_map *p = kzalloc(sizeof(struct kobj_map), GFP_KERNEL);
 	struct probe *base = kzalloc(sizeof(*base), GFP_KERNEL);
 	int i;

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 2b8755d..e08950b 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -192,7 +192,7 @@ int platform_device_add_resources(struct
 {
 	struct resource *r;

-	r = kmalloc(sizeof(struct resource) * num, GFP_KERNEL);
+	r = kzalloc(sizeof(struct resource) * num, GFP_KERNEL);
 	if (r) {
 		memcpy(r, res, sizeof(struct resource) * num);
 		pdev->resource = r;
@@ -216,7 +216,7 @@ int platform_device_add_data(struct plat
 {
 	void *d;

-	d = kmalloc(size, GFP_KERNEL);
+	d = kzalloc(size, GFP_KERNEL);
 	if (d) {
 		memcpy(d, data, size);
 		pdev->dev.platform_data = d;
