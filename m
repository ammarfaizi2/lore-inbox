Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbWIAAUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWIAAUZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 20:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbWIAAUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 20:20:25 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:4511 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964830AbWIAAUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 20:20:24 -0400
Subject: [PATCH] manage-jbd-its-own-slab fix
From: Badari Pulavarty <pbadari@us.ibm.com>
To: akpm@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>,
       ext2-devel <Ext2-devel@lists.sourceforge.net>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 17:23:35 -0700
Message-Id: <1157070215.22667.22.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

I missed a place where I needed to convert into kmem_cache_free() :(

Thanks,
Badari

Missed a place where I forgot to convert kfree() to kmem_cache_free()
as part of jbd-manage-its-own-slab changes.

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
Index: linux-2.6.18-rc5/fs/jbd/transaction.c
===================================================================
--- linux-2.6.18-rc5.orig/fs/jbd/transaction.c	2006-08-27 20:41:48.000000000 -0700
+++ linux-2.6.18-rc5/fs/jbd/transaction.c	2006-08-31 17:08:30.000000000 -0700
@@ -727,7 +727,7 @@
 
 out:
 	if (unlikely(frozen_buffer))	/* It's usually NULL */
-		kfree(frozen_buffer);
+		jbd_slab_free(frozen_buffer, bh->b_size);
 
 	JBUFFER_TRACE(jh, "exit");
 	return error;


