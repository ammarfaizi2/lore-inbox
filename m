Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030336AbVKPOZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030336AbVKPOZJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 09:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbVKPOZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 09:25:09 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:4593 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030336AbVKPOZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 09:25:08 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] spufs: Make all exports GPL-only
Date: Wed, 16 Nov 2005 15:26:40 +0100
User-Agent: KMail/1.7.2
Cc: paulus@samba.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       mnutter@us.ibm.com
References: <20051115205347.395355000@localhost> <20051115210408.327453000@localhost> <20051115174145.70f37501.akpm@osdl.org>
In-Reply-To: <20051115174145.70f37501.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200511161526.42655.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This changes all exported symbols of spufs to EXPORT_SYMBOL_GPL.
The spu_ibox_read/spu_wbox_write symbols are not exported
any more when the scheduler patch is applied.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

---

On Middeweken 16 November 2005 02:41, Andrew Morton wrote:
> +EXPORT_SYMBOL_GPL(hash_page);
> +EXPORT_SYMBOL(spu_alloc);
> +EXPORT_SYMBOL(spu_free);
> +EXPORT_SYMBOL(spu_run);
> +EXPORT_SYMBOL(spu_ibox_read);
> +EXPORT_SYMBOL(spu_wbox_write);
> +EXPORT_SYMBOL_GPL(register_spu_syscalls);
> +EXPORT_SYMBOL_GPL(unregister_spu_syscalls);
> -EXPORT_SYMBOL_GPL(__handle_mm_fault); /* For MOL */
> +EXPORT_SYMBOL_GPL(__handle_mm_fault);
> 
> A strange mixture of GPL and non-GPL.   What's the thinking here?

Lack of thinking ;-)
At first, I had everything as EXPORT_SYMBOL. Everything that was added
in the last few months was EXPORT_SYMBOL_GPL.

Index: linux-2.6.15-rc/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-2.6.15-rc.orig/arch/powerpc/platforms/cell/spu_base.c
+++ linux-2.6.15-rc/arch/powerpc/platforms/cell/spu_base.c
@@ -399,7 +399,7 @@ struct spu *spu_alloc(void)
 
 	return spu;
 }
-EXPORT_SYMBOL(spu_alloc);
+EXPORT_SYMBOL_GPL(spu_alloc);
 
 void spu_free(struct spu *spu)
 {
@@ -407,7 +407,7 @@ void spu_free(struct spu *spu)
 	list_add_tail(&spu->list, &spu_list);
 	up(&spu_mutex);
 }
-EXPORT_SYMBOL(spu_free);
+EXPORT_SYMBOL_GPL(spu_free);
 
 static int spu_handle_mm_fault(struct spu *spu)
 {
@@ -576,7 +576,7 @@ int spu_run(struct spu *spu)
 
 	return ret;
 }
-EXPORT_SYMBOL(spu_run);
+EXPORT_SYMBOL_GPL(spu_run);
 
 static void __iomem * __init map_spe_prop(struct device_node *n,
 						 const char *name)

