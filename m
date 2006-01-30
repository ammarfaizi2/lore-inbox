Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWA3JMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWA3JMW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 04:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWA3JMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 04:12:22 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:56773
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932152AbWA3JMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 04:12:21 -0500
Message-Id: <43DDE699.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Mon, 30 Jan 2006 10:12:41 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] abstract type/size specification for assembly
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartB7952499.1__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartB7952499.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Andrew,

would you consider merging attached trivial patch to simplify specifying the size and, for functions, also the type in
assembly files?

Thanks, Jan

--=__PartB7952499.1__=
Content-Type: text/plain; name="linux-2.6.16-rc1-end-endproc.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="linux-2.6.16-rc1-end-endproc.patch"

From: Jan Beulich <jbeulich@novell.com>

Provide abstraction for generating type and size information of
assembly routines and data.

Signed-Off-By: Jan Beulich <jbeulich@novell.com>

diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc1/include/linux/linkage.h 2.6.16-rc1-end-endproc/include/linux/linkage.h
--- /home/jbeulich/tmp/linux-2.6.16-rc1/include/linux/linkage.h	2006-01-03 04:21:10.000000000 +0100
+++ 2.6.16-rc1-end-endproc/include/linux/linkage.h	2006-01-25 10:41:49.000000000 +0100
@@ -39,6 +39,11 @@
   ALIGN; \
   name:
 
+#define ENDPROC(name) \
+  .type name, @function; \
+  END(name)
+#define END(name) \
+  .size name, .-name
 
 #endif
 

--=__PartB7952499.1__=--
