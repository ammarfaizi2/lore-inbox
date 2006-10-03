Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbWJCKV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWJCKV3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 06:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbWJCKV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 06:21:29 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:62430 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964871AbWJCKV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 06:21:28 -0400
Message-ID: <452239A2.5020508@fr.ibm.com>
Date: Tue, 03 Oct 2006 12:21:22 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Greg Banks <gnb@melbourne.sgi.com>, Neil Brown <neilb@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm] fix linux/nfsd/const.h for make headers_check 
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make headers_check fails on linux/nfsd/const.h. 

Since linux/sunrpc/msg_prot.h does not seem to export anything
interesting for userspace, this patch moves it in the __KERNEL__ 
protected section.

Cheers,

C.

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
---
 include/linux/nfsd/const.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: 2.6.18-mm3/include/linux/nfsd/const.h
===================================================================
--- 2.6.18-mm3.orig/include/linux/nfsd/const.h
+++ 2.6.18-mm3/include/linux/nfsd/const.h
@@ -13,7 +13,6 @@
 #include <linux/nfs2.h>
 #include <linux/nfs3.h>
 #include <linux/nfs4.h>
-#include <linux/sunrpc/msg_prot.h>

 /*
  * Maximum protocol version supported by knfsd
@@ -29,6 +28,8 @@

 #ifdef __KERNEL__

+#include <linux/sunrpc/msg_prot.h>
+
 #ifndef NFS_SUPER_MAGIC
 # define NFS_SUPER_MAGIC       0x6969
 #endif
