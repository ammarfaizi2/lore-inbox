Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263275AbTCYT3V>; Tue, 25 Mar 2003 14:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263283AbTCYT2d>; Tue, 25 Mar 2003 14:28:33 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:40842 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S263276AbTCYT04>; Tue, 25 Mar 2003 14:26:56 -0500
Date: Tue, 25 Mar 2003 20:37:37 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: [PATCH] pcmcia (4/4): remove unused include/pcmcia/driver_ops.h
Message-ID: <20030325193737.GD15319@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Except for dev_node_t, the contents of include/pcmcia/driver_ops.h
aren't used anywhere within the kernel. It's a left-over file from the
days when cardbus 32-bit cards weren't handled as pci devices, and
their drivers as pci drivers. So, move the dev_node_t to
include/pcmcia/ds.h, remove the lone in-kernel reference to
driver_ops.h, and remove the contents of driver_ops.h.

 driver_ops.h |   75 +----------------------------------------------------------
 ds.h         |    8 +++++-
 2 files changed, 9 insertions(+), 74 deletions(-)

diff -ruN linux-original/include/pcmcia/driver_ops.h linux/include/pcmcia/driver_ops.h
--- linux-original/include/pcmcia/driver_ops.h	2003-03-25 18:26:53.000000000 +0100
+++ linux/include/pcmcia/driver_ops.h	2003-03-25 20:15:27.000000000 +0100
@@ -1,73 +1,2 @@
-/*
- * driver_ops.h 1.15 2000/06/12 21:55:40
- *
- * The contents of this file are subject to the Mozilla Public License
- * Version 1.1 (the "License"); you may not use this file except in
- * compliance with the License. You may obtain a copy of the License
- * at http://www.mozilla.org/MPL/
- *
- * Software distributed under the License is distributed on an "AS IS"
- * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
- * the License for the specific language governing rights and
- * limitations under the License. 
- *
- * The initial developer of the original code is David A. Hinds
- * <dahinds@users.sourceforge.net>.  Portions created by David A. Hinds
- * are Copyright (C) 1999 David A. Hinds.  All Rights Reserved.
- *
- * Alternatively, the contents of this file may be used under the
- * terms of the GNU General Public License version 2 (the "GPL"), in which
- * case the provisions of the GPL are applicable instead of the
- * above.  If you wish to allow the use of your version of this file
- * only under the terms of the GPL and not to allow others to use
- * your version of this file under the MPL, indicate your decision by
- * deleting the provisions above and replace them with the notice and
- * other provisions required by the GPL.  If you do not delete the
- * provisions above, a recipient may use your version of this file
- * under either the MPL or the GPL.
- */
-
-#ifndef _LINUX_DRIVER_OPS_H
-#define _LINUX_DRIVER_OPS_H
-
-#ifndef DEV_NAME_LEN
-#define DEV_NAME_LEN	32
-#endif
-
-#ifdef __KERNEL__
-
-typedef struct dev_node_t {
-    char		dev_name[DEV_NAME_LEN];
-    u_short		major, minor;
-    struct dev_node_t	*next;
-} dev_node_t;
-
-typedef struct dev_locator_t {
-    enum { LOC_ISA, LOC_PCI } bus;
-    union {
-	struct {
-	    u_short	io_base_1, io_base_2;
-	    u_long	mem_base;
-	    u_char	irq, dma;
-	} isa;
-	struct {
-	    u_char	bus;
-	    u_char	devfn;
-	} pci;
-    } b;
-} dev_locator_t;
-
-typedef struct driver_operations {
-    char		*name;
-    dev_node_t		*(*attach) (dev_locator_t *loc);
-    void		(*suspend) (dev_node_t *dev);
-    void		(*resume) (dev_node_t *dev);
-    void		(*detach) (dev_node_t *dev);
-} driver_operations;
-
-int register_driver(struct driver_operations *ops);
-void unregister_driver(struct driver_operations *ops);
-
-#endif /* __KERNEL__ */
-
-#endif /* _LINUX_DRIVER_OPS_H */
+/* now empty */
+#warning please remove the reference to this file
diff -ruN linux-original/include/pcmcia/ds.h linux/include/pcmcia/ds.h
--- linux-original/include/pcmcia/ds.h	2003-03-25 20:05:08.000000000 +0100
+++ linux/include/pcmcia/ds.h	2003-03-25 20:12:47.000000000 +0100
@@ -30,9 +30,9 @@
 #ifndef _LINUX_DS_H
 #define _LINUX_DS_H
 
-#include <pcmcia/driver_ops.h>
 #include <pcmcia/bulkmem.h>
 #include <linux/device.h>
+#include <pcmcia/cs_types.h>
 
 typedef struct tuple_parse_t {
     tuple_t		tuple;
@@ -108,6 +108,12 @@
 
 #ifdef __KERNEL__
 
+typedef struct dev_node_t {
+    char		dev_name[DEV_NAME_LEN];
+    u_short		major, minor;
+    struct dev_node_t	*next;
+} dev_node_t;
+
 typedef struct dev_link_t {
     dev_node_t		*dev;
     u_int		state, open;
