Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269451AbTHKQOH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 12:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268751AbTHKQCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:02:21 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:14886 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272772AbTHKP7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 11:59:42 -0400
To: torvalds@osdl.org
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: [PATCH] CodingStyle fixes for drm_agpsupport
Message-Id: <E19mF4Y-0005Eg-00@tetrachloride>
Date: Mon, 11 Aug 2003 16:59:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/drm/drm_agpsupport.h linux-2.5/drivers/char/drm/drm_agpsupport.h
--- bk-linus/drivers/char/drm/drm_agpsupport.h	2003-07-11 13:57:40.000000000 +0100
+++ linux-2.5/drivers/char/drm/drm_agpsupport.h	2003-07-11 14:08:03.000000000 +0100
@@ -105,7 +105,8 @@ int DRM(agp_acquire)(struct inode *inode
 
 	if (!dev->agp || dev->agp->acquired || !drm_agp->acquire)
 		return -EINVAL;
-	if ((retcode = drm_agp->acquire())) return retcode;
+	if ((retcode = drm_agp->acquire()))
+		return retcode;
 	dev->agp->acquired = 1;
 	return 0;
 }
@@ -142,7 +143,8 @@ int DRM(agp_release)(struct inode *inode
  */
 void DRM(agp_do_release)(void)
 {
-	if (drm_agp->release) drm_agp->release();
+	if (drm_agp->release)
+		drm_agp->release();
 }
 
 /**
@@ -200,7 +202,8 @@ int DRM(agp_alloc)(struct inode *inode, 
 	unsigned long    pages;
 	u32 		 type;
 
-	if (!dev->agp || !dev->agp->acquired) return -EINVAL;
+	if (!dev->agp || !dev->agp->acquired)
+		return -EINVAL;
 	if (copy_from_user(&request, (drm_agp_buffer_t *)arg, sizeof(request)))
 		return -EFAULT;
 	if (!(entry = DRM(alloc)(sizeof(*entry), DRM_MEM_AGPLISTS)))
@@ -222,11 +225,12 @@ int DRM(agp_alloc)(struct inode *inode, 
 	entry->pages     = pages;
 	entry->prev      = NULL;
 	entry->next      = dev->agp->memory;
-	if (dev->agp->memory) dev->agp->memory->prev = entry;
+	if (dev->agp->memory)
+		dev->agp->memory->prev = entry;
 	dev->agp->memory = entry;
 
 	request.handle   = entry->handle;
-        request.physical = memory->physical;
+	request.physical = memory->physical;
 
 	if (copy_to_user((drm_agp_buffer_t *)arg, &request, sizeof(request))) {
 		dev->agp->memory       = entry->next;
@@ -253,7 +257,8 @@ static drm_agp_mem_t *DRM(agp_lookup_ent
 	drm_agp_mem_t *entry;
 
 	for (entry = dev->agp->memory; entry; entry = entry->next) {
-		if (entry->handle == handle) return entry;
+		if (entry->handle == handle)
+			return entry;
 	}
 	return NULL;
 }
@@ -279,12 +284,14 @@ int DRM(agp_unbind)(struct inode *inode,
 	drm_agp_mem_t     *entry;
 	int ret;
 
-	if (!dev->agp || !dev->agp->acquired) return -EINVAL;
+	if (!dev->agp || !dev->agp->acquired)
+		return -EINVAL;
 	if (copy_from_user(&request, (drm_agp_binding_t *)arg, sizeof(request)))
 		return -EFAULT;
 	if (!(entry = DRM(agp_lookup_entry)(dev, request.handle)))
 		return -EINVAL;
-	if (!entry->bound) return -EINVAL;
+	if (!entry->bound)
+		return -EINVAL;
 	ret = DRM(unbind_agp)(entry->memory);
 	if (ret == 0)
 	    entry->bound = 0;
@@ -320,9 +327,11 @@ int DRM(agp_bind)(struct inode *inode, s
 		return -EFAULT;
 	if (!(entry = DRM(agp_lookup_entry)(dev, request.handle)))
 		return -EINVAL;
-	if (entry->bound) return -EINVAL;
+	if (entry->bound)
+		return -EINVAL;
 	page = (request.offset + PAGE_SIZE - 1) / PAGE_SIZE;
-	if ((retcode = DRM(bind_agp)(entry->memory, page))) return retcode;
+	if ((retcode = DRM(bind_agp)(entry->memory, page)))
+		return retcode;
 	entry->bound = dev->agp->base + (page << PAGE_SHIFT);
 	DRM_DEBUG("base = 0x%lx entry->bound = 0x%lx\n",
 		  dev->agp->base, entry->bound);
@@ -351,16 +360,23 @@ int DRM(agp_free)(struct inode *inode, s
 	drm_agp_buffer_t request;
 	drm_agp_mem_t    *entry;
 
-	if (!dev->agp || !dev->agp->acquired) return -EINVAL;
+	if (!dev->agp || !dev->agp->acquired)
+		return -EINVAL;
 	if (copy_from_user(&request, (drm_agp_buffer_t *)arg, sizeof(request)))
 		return -EFAULT;
 	if (!(entry = DRM(agp_lookup_entry)(dev, request.handle)))
 		return -EINVAL;
-	if (entry->bound) DRM(unbind_agp)(entry->memory);
+	if (entry->bound)
+		DRM(unbind_agp)(entry->memory);
+
+	if (entry->prev)
+		entry->prev->next = entry->next;
+	else
+		dev->agp->memory = entry->next;
+
+	if (entry->next)
+		entry->next->prev = entry->prev;
 
-	if (entry->prev) entry->prev->next = entry->next;
-	else             dev->agp->memory  = entry->next;
-	if (entry->next) entry->next->prev = entry->prev;
 	DRM(free_agp)(entry->memory, entry->pages);
 	DRM(free)(entry, sizeof(*entry), DRM_MEM_AGPLISTS);
 	return 0;
@@ -415,14 +431,16 @@ void DRM(agp_uninit)(void)
 /** Calls drm_agp->allocate_memory() */
 struct agp_memory *DRM(agp_allocate_memory)(size_t pages, u32 type)
 {
-	if (!drm_agp->allocate_memory) return NULL;
+	if (!drm_agp->allocate_memory)
+		return NULL;
 	return drm_agp->allocate_memory(pages, type);
 }
 
 /** Calls drm_agp->free_memory() */
 int DRM(agp_free_memory)(struct agp_memory *handle)
 {
-	if (!handle || !drm_agp->free_memory) return 0;
+	if (!handle || !drm_agp->free_memory)
+		return 0;
 	drm_agp->free_memory(handle);
 	return 1;
 }
@@ -430,14 +448,16 @@ int DRM(agp_free_memory)(struct agp_memo
 /** Calls drm_agp->bind_memory() */
 int DRM(agp_bind_memory)(struct agp_memory *handle, off_t start)
 {
-	if (!handle || !drm_agp->bind_memory) return -EINVAL;
+	if (!handle || !drm_agp->bind_memory)
+		return -EINVAL;
 	return drm_agp->bind_memory(handle, start);
 }
 
 /** Calls drm_agp->unbind_memory() */
 int DRM(agp_unbind_memory)(struct agp_memory *handle)
 {
-	if (!handle || !drm_agp->unbind_memory) return -EINVAL;
+	if (!handle || !drm_agp->unbind_memory)
+		return -EINVAL;
 	return drm_agp->unbind_memory(handle);
 }
 
