Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966226AbWKXV7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966226AbWKXV7u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 16:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966231AbWKXV7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 16:59:50 -0500
Received: from tomts16.bellnexxia.net ([209.226.175.4]:56511 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S966226AbWKXV7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 16:59:48 -0500
Date: Fri, 24 Nov 2006 16:59:47 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       Karim Yaghmour <karim@opersys.com>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, Richard J Moore <richardj_moore@uk.ibm.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com
Subject: [PATCH 9/16] LTTng 0.6.36 for 2.6.18 : Core, headers
Message-ID: <20061124215947.GJ25048@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 16:59:06 up 93 days, 19:07,  3 users,  load average: 0.82, 0.63, 0.44
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LTTng core, headers.

patch09-2.6.18-lttng-core-0.6.36-core-header.diff

Signed-off-by : Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--BEGIN--
--- /dev/null
+++ b/include/linux/ltt-core.h
@@ -0,0 +1,33 @@
+/*
+ * linux/include/linux/ltt-core.h
+ *
+ * Copyright (C) 2005,2006 Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca)
+ *
+ * This contains the core definitions for the Linux Trace Toolkit.
+ */
+
+#ifndef LTT_CORE_H
+#define LTT_CORE_H
+
+#include <linux/list.h>
+
+#ifdef CONFIG_LTT
+
+/* All modifications of ltt_traces must be done by ltt-tracer.c, while holding
+ * the semaphore. Only reading of this information can be done elsewhere, with
+ * the RCU mechanism : the preemption must be disabled while reading the
+ * list. */
+struct ltt_traces {
+	struct list_head head;		/* Traces list */
+	unsigned int num_active_traces;	/* Number of active traces */
+} ____cacheline_aligned;
+
+extern struct ltt_traces ltt_traces;
+
+
+/* Keep track of traps nesting inside LTT */
+extern volatile unsigned int ltt_nesting[];
+
+#endif //CONFIG_LTT
+
+#endif //LTT_CORE_H
--END--

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
