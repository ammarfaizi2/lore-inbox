Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752176AbWCCH5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176AbWCCH5Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 02:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752111AbWCCH5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 02:57:09 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:56192 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751672AbWCCH5C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 02:57:02 -0500
Message-Id: <20060303075736.744751000@sorel.sous-sol.org>
References: <20060303075542.659414000@sorel.sous-sol.org>
Date: Thu, 02 Mar 2006 23:55:46 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [PATCH 4/4] [PATCH] mempolicy.c compile fix, make sure BITS_PER_BYTE is defined
Content-Disposition: inline; filename=compile-fix-make-sure-bits_per_byte-is-defined.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Gar..

mm/mempolicy.c: In function 'get_nodes':
mm/mempolicy.c:527: error: 'BITS_PER_BYTE' undeclared (first use in this function)
mm/mempolicy.c:527: error: (Each undeclared identifier is reported only once
mm/mempolicy.c:527: error: for each function it appears in.)

About to retry a build with the below patch which should do the trick.
(How did this *ever* build?)

Signed-off-by: Dave Jones <davej@redhat.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 include/linux/types.h |    1 +
 1 files changed, 1 insertion(+)

--- linux-2.6.15.5.orig/include/linux/types.h
+++ linux-2.6.15.5/include/linux/types.h
@@ -8,6 +8,7 @@
 	(((bits)+BITS_PER_LONG-1)/BITS_PER_LONG)
 #define DECLARE_BITMAP(name,bits) \
 	unsigned long name[BITS_TO_LONGS(bits)]
+#define BITS_PER_BYTE 8
 #endif
 
 #include <linux/posix_types.h>

--
