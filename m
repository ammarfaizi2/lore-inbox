Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262705AbSI1EbR>; Sat, 28 Sep 2002 00:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262706AbSI1EaF>; Sat, 28 Sep 2002 00:30:05 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:2500 "HELO atlrel6.hp.com")
	by vger.kernel.org with SMTP id <S262707AbSI1E3f>;
	Sat, 28 Sep 2002 00:29:35 -0400
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] missing bit of non-executable data patch
Message-Id: <E17v9Je-0001n9-00@eeyore>
From: Bjorn Helgaas <helgaas@fc.hp.com>
Date: Fri, 27 Sep 2002 22:34:54 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most of David Mosberger's work to allow data to be non-executable
by default is already in, but this bit appears to have been lost.
Note that all architectures except ia64 currently set the default
so data is executable, so this doesn't change behavior for anybody.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.683   -> 1.684  
#	  include/linux/mm.h	1.39    -> 1.40   
#	include/asm-arm/page.h	1.4     -> 1.5    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/20	bjorn_helgaas@hp.com	1.684
# Last bit of VM_DATA_DEFAULT_FLAGS patch (makes rights on a data
# page architecture-dependent).
# --------------------------------------------
#
diff -Nru a/include/asm-arm/page.h b/include/asm-arm/page.h
--- a/include/asm-arm/page.h	Fri Sep 20 16:13:54 2002
+++ b/include/asm-arm/page.h	Fri Sep 20 16:13:54 2002
@@ -106,6 +106,9 @@
 #define VALID_PAGE(page)	((page - mem_map) < max_mapnr)
 #endif
 
+#define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
+				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
+
 #endif
 
 #endif
diff -Nru a/include/linux/mm.h b/include/linux/mm.h
--- a/include/linux/mm.h	Fri Sep 20 16:13:54 2002
+++ b/include/linux/mm.h	Fri Sep 20 16:13:54 2002
@@ -104,7 +104,7 @@
 #define VM_DONTEXPAND	0x00040000	/* Cannot expand with mremap() */
 #define VM_RESERVED	0x00080000	/* Don't unmap it from swap_out */
 
-#define VM_STACK_FLAGS	0x00000177
+#define VM_STACK_FLAGS			(VM_DATA_DEFAULT_FLAGS | VM_GROWSDOWN)
 
 #define VM_READHINTMASK			(VM_SEQ_READ | VM_RAND_READ)
 #define VM_ClearReadHint(v)		(v)->vm_flags &= ~VM_READHINTMASK
