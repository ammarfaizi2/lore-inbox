Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751759AbWDCQGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbWDCQGj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 12:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbWDCQGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 12:06:39 -0400
Received: from [198.99.130.12] ([198.99.130.12]:51600 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751759AbWDCQGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 12:06:38 -0400
Date: Mon, 3 Apr 2006 11:07:34 -0400
From: Jeff Dike <jdike@addtoit.com>
To: torvalds@osdl.org
Cc: Blaisorblade <blaisorblade@yahoo.it>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH] UML - TLS fixlets
Message-ID: <20060403150734.GA4081@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two small TLS fixes -

arch/um/os-Linux/sys-i386/tls.c uses errno and -E* so it should include 
    errno.h
__setup_host_supports_tls returns 1, but as an initcall, it should return 0

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/arch/um/os-Linux/sys-i386/tls.c
===================================================================
--- linux-2.6.16.orig/arch/um/os-Linux/sys-i386/tls.c	2006-04-03 09:39:23.000000000 -0400
+++ linux-2.6.16/arch/um/os-Linux/sys-i386/tls.c	2006-04-03 09:39:42.000000000 -0400
@@ -1,3 +1,4 @@
+#include <errno.h>
 #include <linux/unistd.h>
 #include "sysdep/tls.h"
 #include "user_util.h"
Index: linux-2.6.16/arch/um/sys-i386/tls.c
===================================================================
--- linux-2.6.16.orig/arch/um/sys-i386/tls.c	2006-04-03 09:39:15.000000000 -0400
+++ linux-2.6.16/arch/um/sys-i386/tls.c	2006-04-03 09:39:43.000000000 -0400
@@ -378,7 +378,7 @@ static int __init __setup_host_supports_
 	} else
 		printk(KERN_ERR "  Host TLS support NOT detected! "
 				"TLS support inside UML will not work\n");
-	return 1;
+	return 0;
 }
 
 __initcall(__setup_host_supports_tls);
