Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262274AbVERVum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbVERVum (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 17:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbVERVum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 17:50:42 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:24780 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S262285AbVERVue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 17:50:34 -0400
Message-Id: <200505182150.j4ILoHFE001840@ginger.cmf.nrl.navy.mil>
To: davem@redhat.com
cc: sam@ravnborg.org, linux-kernel@vger.kernel.org,
       "Jan Beulich" <JBeulich@novell.com>
Subject: Re: [PATCH] fix ATM makefile for out-of-source-tree builds 
In-reply-to: <s28321ef.089@emea1-mh.id2.novell.com> 
Date: Wed, 18 May 2005 17:50:18 -0400
From: "chas williams - CONTRACTOR" <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dave, 

please apply to 2.6 head -- thanks!


[ATM]: fix ATM makefile for out-of-source-tree builds

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Signed-off-by: Chas Williams <chas@cmf.nrl.navy.mil>

---
commit 70ac1c1be822318a3b706d00397b2bf24ffe0a6e
tree fe56ec270cfb1155e9370731e49900172ec73de6
parent ff0d2f90fdc4b564d47a7c26b16de81a16cfa28e
author chas williams <chas@relax.(none)> Tue, 17 May 2005 14:39:55 -0400
committer chas williams <chas@relax.(none)> Tue, 17 May 2005 14:39:55 -0400

 atm/Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: drivers/atm/Makefile
===================================================================
--- 6bb5a1cf91bbda8308ec7e6d900cb89071907dcd/drivers/atm/Makefile  (mode:100644)
+++ fe56ec270cfb1155e9370731e49900172ec73de6/drivers/atm/Makefile  (mode:100644)
@@ -39,7 +39,8 @@
   fore_200e-objs		+= fore200e_pca_fw.o
   # guess the target endianess to choose the right PCA-200E firmware image
   ifeq ($(CONFIG_ATM_FORE200E_PCA_DEFAULT_FW),y)
-    CONFIG_ATM_FORE200E_PCA_FW = $(shell if test -n "`$(CC) -E -dM $(src)/../../include/asm/byteorder.h | grep ' __LITTLE_ENDIAN '`"; then echo $(obj)/pca200e.bin; else echo $(obj)/pca200e_ecd.bin2; fi)
+    byteorder.h			:= include$(if $(patsubst $(srctree),,$(objtree)),2)/asm/byteorder.h
+    CONFIG_ATM_FORE200E_PCA_FW	:= $(obj)/pca200e$(if $(shell $(CC) -E -dM $(byteorder.h) | grep ' __LITTLE_ENDIAN '),.bin,_ecd.bin2)
   endif
 endif
 
