Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266379AbUGOVt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266379AbUGOVt3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 17:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266378AbUGOVt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 17:49:28 -0400
Received: from palrel13.hp.com ([156.153.255.238]:42418 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S266379AbUGOVtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 17:49:06 -0400
Date: Thu, 15 Jul 2004 14:40:21 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Stephane Eranian <eranian@frankl.hpl.hp.com>
Subject: [PATCH] fix for buffer limit for long in sysctl.c
Message-ID: <20040715214021.GC1557@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

We discovered a bug in the do_proc_doulongvec_minmax() routine.
The buffer is too short by one byte. A 64-bit number expressed 
in decimal uses 20 bytes. The size of the buffer was set to 20. 
The following patch relative to 2.6.7 fixes the problem. For 
consistency reason, a length of 21 is used for both int and 
long parsers.

change-log:
	fix a bug in do_proc_doulongvec_minmax() where the
	the string buffer was too short to parse a 64-bit number
	expressed in decimal. That was causing problems with entries
	in  /proc/sys using long and allowing large number (such as -1)

signed-off-by: Stephane Eranian <eranian@hpl.hp.com>

===== kernel/sysctl.c 1.65 vs edited =====
--- 1.65/kernel/sysctl.c        2004-06-16 21:12:21 -07:00
+++ edited/kernel/sysctl.c      2004-07-15 14:38:34 -07:00
@@ -1442,7 +1442,7 @@
                              int write, void *data),
                  void *data)
 {
-#define TMPBUFLEN 20
+#define TMPBUFLEN 21
        int *i, vleft, first=1, neg, val;
        unsigned long lval;
        size_t left, len;
@@ -1682,7 +1682,7 @@
                                     unsigned long convmul,
                                     unsigned long convdiv)
 {
-#define TMPBUFLEN 20
+#define TMPBUFLEN 21
        unsigned long *i, *min, *max, val;
        int vleft, first=1, neg;
        size_t len, left;

-- 

-Stephane
