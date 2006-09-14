Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbWINDqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbWINDqj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 23:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWINDqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 23:46:39 -0400
Received: from tomts13-srv.bellnexxia.net ([209.226.175.34]:3285 "EHLO
	tomts13-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1750960AbWINDqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 23:46:37 -0400
Date: Wed, 13 Sep 2006 23:46:36 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>
Cc: ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: [PATCH 7/11] LTTng-core 0.5.108 : facilities-loader
Message-ID: <20060914034636.GH2194@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_Krystal-32689-1158205596-0001-2"
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 23:45:45 up 22 days, 54 min,  6 users,  load average: 1.28, 0.68, 0.34
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Krystal-32689-1158205596-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

7 - Core tracer facility loader
patch-2.6.17-lttng-core-0.5.108-facilities-loader.diff


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 

--=_Krystal-32689-1158205596-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-2.6.17-lttng-core-0.5.108-facilities-loader.diff"

--- /dev/null
+++ b/ltt/ltt-facility-loader-core.c
@@ -0,0 +1,66 @@
+/*
+ * ltt-facility-loader-core.c
+ *
+ * (C) Copyright  2005 - 
+ *          Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca)
+ *
+ * Contains the LTT facility loader.
+ *
+ */
+
+
+#include <linux/ltt-facilities.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/config.h>
+#include "ltt-facility-loader-core.h"
+
+
+#ifdef CONFIG_LTT
+
+EXPORT_SYMBOL(LTT_FACILITY_SYMBOL);
+EXPORT_SYMBOL(LTT_FACILITY_CHECKSUM_SYMBOL);
+
+static const char ltt_facility_name[] = LTT_FACILITY_NAME;
+
+#define SYMBOL_STRING(sym) #sym
+
+static struct ltt_facility facility = {
+	.name = ltt_facility_name,
+	.num_events = LTT_FACILITY_NUM_EVENTS,
+	.checksum = LTT_FACILITY_CHECKSUM,
+	.symbol = SYMBOL_STRING(LTT_FACILITY_SYMBOL),
+};
+
+static int __init facility_init(void)
+{
+	printk(KERN_INFO "LTT : ltt-facility-core init in kernel\n");
+
+	LTT_FACILITY_SYMBOL = ltt_facility_kernel_register(&facility);
+	LTT_FACILITY_CHECKSUM_SYMBOL = LTT_FACILITY_SYMBOL;
+	
+	return LTT_FACILITY_SYMBOL;
+}
+
+#ifndef MODULE
+__initcall(facility_init);
+#else
+module_init(facility_init);
+static void __exit facility_exit(void)
+{
+	int err;
+
+	err = ltt_facility_unregister(LTT_FACILITY_SYMBOL);
+	if(err != 0)
+		printk(KERN_ERR "LTT : Error in unregistering facility.\n");
+
+}
+module_exit(facility_exit)
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mathieu Desnoyers");
+MODULE_DESCRIPTION("Linux Trace Toolkit Facility");
+
+#endif //MODULE
+
+#endif //CONFIG_LTT
--- /dev/null
+++ b/ltt/ltt-facility-loader-core.h
@@ -0,0 +1,20 @@
+#ifndef _LTT_FACILITY_LOADER_CORE_H_
+#define _LTT_FACILITY_LOADER_CORE_H_
+
+#ifdef CONFIG_LTT
+
+#include <linux/ltt-facilities.h>
+#include <linux/ltt/ltt-facility-id-core.h>
+
+ltt_facility_t	ltt_facility_core;
+ltt_facility_t	ltt_facility_core_1A8DE486;
+
+#define LTT_FACILITY_SYMBOL		ltt_facility_core
+#define LTT_FACILITY_CHECKSUM_SYMBOL	ltt_facility_core_1A8DE486
+#define LTT_FACILITY_CHECKSUM		0x1A8DE486
+#define LTT_FACILITY_NAME		"core"
+#define LTT_FACILITY_NUM_EVENTS	facility_core_num_events
+
+#endif //CONFIG_LTT
+
+#endif //_LTT_FACILITY_LOADER_CORE_H_

--=_Krystal-32689-1158205596-0001-2--
