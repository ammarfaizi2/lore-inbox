Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267840AbUIJTni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267840AbUIJTni (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 15:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267830AbUIJTni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 15:43:38 -0400
Received: from flamingo.mail.pas.earthlink.net ([207.217.120.232]:27362 "EHLO
	flamingo.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S267860AbUIJTna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 15:43:30 -0400
Date: Fri, 10 Sep 2004 15:43:23 -0400 (EDT)
From: Dan Streetman <ddstreet@ieee.org>
Reply-To: ddstreet@ieee.org
To: linux-kernel@vger.kernel.org
Subject: [patch] mod_devicetable.h needs #ifdef __KERNEL__ removed
Message-ID: <Pine.LNX.4.51.0409101533220.27308@dylan.root.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In include/linux/mod_devicetable.h, there is a typedef for
kernel_ulong_t that is protected inside a #ifdef __KERNEL__ block.  
However later in the file kernel_ulong_t is used inside structures, not 
protected by a #ifdef __KERNEL__.  So the header file isn't includable by 
user-space programs.  The #ifdef should be removed, here is a patch that 
removes it.

Signed-off-by: Dan Streetman <ddstreet@ieee.org>


--- linux-2.6.8.1-clean/include/linux/mod_devicetable.h	2004-08-14 06:56:23.000000000 -0400
+++ linux-2.6.8.1/include/linux/mod_devicetable.h	2004-09-10 15:31:00.000000000 -0400
@@ -7,10 +7,8 @@
 #ifndef LINUX_MOD_DEVICETABLE_H
 #define LINUX_MOD_DEVICETABLE_H
 
-#ifdef __KERNEL__
 #include <linux/types.h>
 typedef unsigned long kernel_ulong_t;
-#endif
 
 #define PCI_ANY_ID (~0)
 

