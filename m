Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267023AbUBMOXW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 09:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267024AbUBMOXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 09:23:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63133 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267023AbUBMOXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 09:23:13 -0500
Date: Fri, 13 Feb 2004 09:23:04 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Stephen Smalley <sds@epoch.ncsc.mil>, <linux-kernel@vger.kernel.org>
Subject: [SELINUX] mark avc_init with __init
Message-ID: <Xine.LNX.4.44.0402130921580.20552-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The avc_init function is only called during kernel init, so it can be 
marked with __init.

Please apply.


- James
-- 
James Morris
<jmorris@redhat.com>

diff -urN -X dontdiff linux-2.6.3-rc2-mm1.o/security/selinux/avc.c linux-2.6.3-rc2-mm1.w2/security/selinux/avc.c
--- linux-2.6.3-rc2-mm1.o/security/selinux/avc.c	2004-02-04 08:39:07.000000000 -0500
+++ linux-2.6.3-rc2-mm1.w2/security/selinux/avc.c	2004-02-13 09:21:38.703303568 -0500
@@ -166,7 +166,7 @@
  *
  * Initialize the access vector cache.
  */
-void avc_init(void)
+void __init avc_init(void)
 {
 	struct avc_node	*new;
 	int i;
diff -urN -X dontdiff linux-2.6.3-rc2-mm1.o/security/selinux/include/avc.h linux-2.6.3-rc2-mm1.w2/security/selinux/include/avc.h
--- linux-2.6.3-rc2-mm1.o/security/selinux/include/avc.h	2004-02-04 08:39:07.000000000 -0500
+++ linux-2.6.3-rc2-mm1.w2/security/selinux/include/avc.h	2004-02-13 09:21:38.704303416 -0500
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/kdev_t.h>
 #include <linux/spinlock.h>
+#include <linux/init.h>
 #include <asm/system.h>
 #include "flask.h"
 #include "av_permissions.h"
@@ -121,7 +122,7 @@
  * AVC operations
  */
 
-void avc_init(void);
+void __init avc_init(void);
 
 int avc_lookup(u32 ssid, u32 tsid, u16 tclass,
                u32 requested, struct avc_entry_ref *aeref);

