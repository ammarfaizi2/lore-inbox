Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964937AbVL2Anh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbVL2Anh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 19:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964948AbVL2AjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 19:39:15 -0500
Received: from mx.pathscale.com ([64.160.42.68]:50152 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932571AbVL2AjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 19:39:09 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 6 of 20] ipath - driver debugging headers
X-Mercurial-Node: 9e8d017ed298d591ea338b0d77a37c25cdb38cbd
Message-Id: <9e8d017ed298d591ea33.1135816285@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1135816279@eng-12.pathscale.com>
Date: Wed, 28 Dec 2005 16:31:25 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 2d9a3f27a10c -r 9e8d017ed298 drivers/infiniband/hw/ipath/ipath_debug.h
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_debug.h	Wed Dec 28 14:19:42 2005 -0800
@@ -0,0 +1,98 @@
+/*
+ * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ *
+ * Patent licenses, if any, provided herein do not apply to
+ * combinations of this program with other software, or any other
+ * product whatsoever.
+ */
+
+#ifndef _IPATH_DEBUG_H
+#define _IPATH_DEBUG_H
+
+#ifndef _IPATH_DEBUGGING	/* debugging enabled or not */
+#define _IPATH_DEBUGGING 1
+#endif
+
+#if _IPATH_DEBUGGING
+
+/*
+ * Mask values for debugging.  The scheme allows us to compile out any
+ * of the debug tracing stuff, and if compiled in, to enable or disable
+ * dynamically.  This can be set at modprobe time also:
+ *      modprobe infinipath.ko infinipath_debug=7
+ */
+
+#define __IPATH_INFO        0x1 /* generic low verbosity stuff */
+#define __IPATH_DBG         0x2 /* generic debug */
+#define __IPATH_TRSAMPLE    0x8 /* generate trace buffer sample entries */
+/* leave some low verbosity spots open */
+#define __IPATH_VERBDBG     0x40        /* very verbose debug */
+#define __IPATH_PKTDBG      0x80        /* print packet data */
+/* print process startup (init)/exit messages */
+#define __IPATH_PROCDBG     0x100
+/* print mmap/nopage stuff, not using VDBG any more */
+#define __IPATH_MMDBG       0x200
+#define __IPATH_USER_SEND   0x1000      /* use user mode send */
+#define __IPATH_KERNEL_SEND 0x2000      /* use kernel mode send */
+#define __IPATH_EPKTDBG     0x4000      /* print ethernet packet data */
+#define __IPATH_SMADBG      0x8000      /* sma packet debug */
+#define __IPATH_IPATHDBG    0x10000     /* Ethernet (IPATH) general debug on */
+#define __IPATH_IPATHWARN   0x20000     /* Ethernet (IPATH) warnings on */
+#define __IPATH_IPATHERR    0x40000     /* Ethernet (IPATH) errors on */
+#define __IPATH_IPATHPD     0x80000     /* Ethernet (IPATH) packet dump on */
+#define __IPATH_IPATHTABLE  0x100000    /* Ethernet (IPATH) table dump on */
+
+#else /* _IPATH_DEBUGGING */
+
+/*
+ * define all of these even with debugging off, for the few places that do
+ * if(infinipath_debug & _IPATH_xyzzy), but in a way that will make the
+ * compiler eliminate the code
+ */
+
+#define __IPATH_INFO      0x0   /* generic low verbosity stuff */
+#define __IPATH_DBG       0x0   /* generic debug */
+#define __IPATH_TRSAMPLE  0x0   /* generate trace buffer sample entries */
+#define __IPATH_VERBDBG   0x0   /* very verbose debug */
+#define __IPATH_PKTDBG    0x0   /* print packet data */
+#define __IPATH_PROCDBG   0x0   /* print process startup (init)/exit messages */
+/* print mmap/nopage stuff, not using VDBG any more */
+#define __IPATH_MMDBG     0x0
+#define __IPATH_EPKTDBG   0x0   /* print ethernet packet data */
+#define __IPATH_SMADBG    0x0   /* print process startup (init)/exit messages */#define __IPATH_IPATHDBG  0x0   /* Ethernet (IPATH) table dump on */
+#define __IPATH_IPATHWARN 0x0   /* Ethernet (IPATH) warnings on   */
+#define __IPATH_IPATHERR  0x0   /* Ethernet (IPATH) errors on   */
+#define __IPATH_IPATHPD   0x0   /* Ethernet (IPATH) packet dump on   */
+#define __IPATH_IPATHTABLE 0x0  /* Ethernet (IPATH) packet dump on   */
+
+#endif /* _IPATH_DEBUGGING */
+
+#endif /* _IPATH_DEBUG_H */
diff -r 2d9a3f27a10c -r 9e8d017ed298 drivers/infiniband/hw/ipath/ipath_kdebug.h
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_kdebug.h	Wed Dec 28 14:19:42 2005 -0800
@@ -0,0 +1,109 @@
+/*
+ * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ *
+ * Patent licenses, if any, provided herein do not apply to
+ * combinations of this program with other software, or any other
+ * product whatsoever.
+ */
+
+#ifndef _IPATH_KDEBUG_H
+#define _IPATH_KDEBUG_H
+
+#include "ipath_debug.h"
+
+/*
+ * This file contains lightweight kernel tracing code.
+ */
+
+extern unsigned infinipath_debug;
+const char *ipath_get_unit_name(int unit);
+
+#if _IPATH_DEBUGGING
+
+#define _IPATH_UNIT_ERROR(unit,fmt,...) \
+        printk(KERN_ERR "%s: " fmt, ipath_get_unit_name(unit), ##__VA_ARGS__)
+
+#define _IPATH_ERROR(fmt,...) printk(KERN_ERR "infinipath: " fmt, ##__VA_ARGS__)
+
+#define _IPATH_INFO(fmt,...) \
+	do { \
+		if(unlikely(infinipath_debug & __IPATH_INFO)) \
+			printk(KERN_INFO "infinipath: " fmt, ##__VA_ARGS__); \
+	} while(0)
+
+#define __IPATH_DBG_WHICH(which,fmt,...) \
+	do { \
+		if(unlikely(infinipath_debug&(which))) \
+			printk(KERN_DEBUG "%s: " fmt, __func__,##__VA_ARGS__); \
+	} while(0)
+
+#define  _IPATH_DBG(fmt,...) __IPATH_DBG_WHICH(__IPATH_DBG,fmt,##__VA_ARGS__)
+#define  _IPATH_VDBG(fmt,...) __IPATH_DBG_WHICH(__IPATH_VERBDBG,fmt,##__VA_ARGS__)
+#define  _IPATH_PDBG(fmt,...) __IPATH_DBG_WHICH(__IPATH_PKTDBG,fmt,##__VA_ARGS__)
+#define  _IPATH_EPDBG(fmt,...) __IPATH_DBG_WHICH(__IPATH_EPKTDBG,fmt,##__VA_ARGS__)
+#define  _IPATH_PRDBG(fmt,...) __IPATH_DBG_WHICH(__IPATH_PROCDBG,fmt,##__VA_ARGS__)
+#define  _IPATH_MMDBG(fmt,...) __IPATH_DBG_WHICH(__IPATH_MMDBG,fmt,##__VA_ARGS__)
+#define  _IPATH_SMADBG(fmt,...) __IPATH_DBG_WHICH(__IPATH_SMADBG,fmt,##__VA_ARGS__)
+#define  _IPATH_IPATHDBG(fmt,...) __IPATH_DBG_WHICH(__IPATH_IPATHDBG,fmt,##__VA_ARGS__)
+#define  _IPATH_IPATHWARN(fmt,...) __IPATH_DBG_WHICH(__IPATH_IPATHWARN,fmt,##__VA_ARGS__)
+#define  _IPATH_IPATHERR(fmt,...) __IPATH_DBG_WHICH(__IPATH_IPATHERR ,fmt,##__VA_ARGS__)
+#define  _IPATH_IPATHPD(fmt,...) __IPATH_DBG_WHICH(__IPATH_IPATHPD  ,fmt,##__VA_ARGS__)
+#define  _IPATH_IPATHTABLE(fmt,...) __IPATH_DBG_WHICH(__IPATH_IPATHTABLE  ,fmt,##__VA_ARGS__)
+
+#else /* ! _IPATH_DEBUGGING */
+
+#define _IPATH_UNIT_ERROR(unit,fmt,...) \
+	do { \
+		printk(KERN_ERR "%s" fmt, "",##__VA_ARGS__); \
+	} while(0)
+
+#define _IPATH_ERROR(fmt,...) \
+	do { \
+		printk (KERN_ERR  "%s" fmt, "",##__VA_ARGS__); \
+	} while(0)
+
+#define _IPATH_INFO(fmt,...)
+#define _IPATH_DBG(fmt,...)
+#define _IPATH_PDBG(fmt,...)
+#define _IPATH_EPDBG(fmt,...)
+#define _IPATH_PRDBG(fmt,...)
+#define _IPATH_VDBG(fmt,...)
+#define _IPATH_MMDBG(fmt,...)
+#define _IPATH_SMADBG(fmt,...)
+#define _IPATH_IPATHDBG(fmt,...)
+#define _IPATH_IPATHWARN(fmt,...)
+#define _IPATH_IPATHERR(fmt,...)
+#define _IPATH_IPATHPD(fmt,...)
+#define _IPATH_IPATHTABLE(fmt,...)
+
+#endif /* _IPATH_DEBUGGING */
+
+#endif /* _IPATH_DEBUG_H */
