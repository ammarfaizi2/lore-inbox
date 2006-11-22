Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757152AbWKVXMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757152AbWKVXMX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 18:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757156AbWKVXMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 18:12:22 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:26070 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1757152AbWKVXMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 18:12:20 -0500
Date: Wed, 22 Nov 2006 15:12:03 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, tali <tali@admingilde.org>,
       dmitry.torokhov@gmail.com
Subject: [PATCH 1/2] kernel-doc: stricter function pointer recognition
Message-Id: <20061122151203.e1058031.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Be more careful about function pointer args:
look for "(...*" instead of just "(".

This line in include/linux/input.h fools the current kernel-doc script
into deciding that this is a function pointer:

	unsigned long ffbit[NBITS(FF_MAX)];

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 scripts/kernel-doc |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2619-rc6g4.orig/scripts/kernel-doc
+++ linux-2619-rc6g4/scripts/kernel-doc
@@ -1430,7 +1430,7 @@ sub create_parameterlist($$$) {
 	    # corresponding data structures "correctly". Catch it later in
 	    # output_* subs.
 	    push_parameter($arg, "", $file);
-	} elsif ($arg =~ m/\(/) {
+	} elsif ($arg =~ m/\(.*\*/) {
 	    # pointer-to-function
 	    $arg =~ tr/#/,/;
 	    $arg =~ m/[^\(]+\(\*([^\)]+)\)/;


---
