Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262709AbSI1EbQ>; Sat, 28 Sep 2002 00:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262703AbSI1E35>; Sat, 28 Sep 2002 00:29:57 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:39894 "HELO atlrel7.hp.com")
	by vger.kernel.org with SMTP id <S262704AbSI1E3f>;
	Sat, 28 Sep 2002 00:29:35 -0400
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] AGPGART 2/5: size AGP mem correctly when memory is discontiguous
Message-Id: <E17v9Je-0001ma-00@eeyore>
From: Bjorn Helgaas <helgaas@fc.hp.com>
Date: Fri, 27 Sep 2002 22:34:54 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the agpgart assumption that memory is contiguous.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.661   -> 1.662  
#	drivers/char/agp/agpgart_be.c	1.35    -> 1.36   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/13	bjorn_helgaas@hp.com	1.662
# Fix max AGP memory for machines with discontiguous memory.
# --------------------------------------------
#
diff -Nru a/drivers/char/agp/agpgart_be.c b/drivers/char/agp/agpgart_be.c
--- a/drivers/char/agp/agpgart_be.c	Fri Sep 13 16:50:25 2002
+++ b/drivers/char/agp/agpgart_be.c	Fri Sep 13 16:50:25 2002
@@ -4517,7 +4497,7 @@
 {
 	long memory, index, result;
 
-	memory = virt_to_phys(high_memory) >> 20;
+	memory = (num_physpages << PAGE_SHIFT) >> 20;
 	index = 1;
 
 	while ((memory > maxes_table[index].mem) &&
