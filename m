Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262257AbTFZRz3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 13:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262259AbTFZRz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 13:55:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65238 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262257AbTFZRy5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 13:54:57 -0400
Date: Thu, 26 Jun 2003 19:09:09 +0100
From: Matthew Wilcox <willy@debian.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] BINFMT_ZFLAT can't be a module
Message-ID: <20030626180909.GP451@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


BINFMT_ZFLAT is an attribute of BINFMT_FLAT not a distinct option in
its own right.  So the test in lib/Kconfig has to be changed to something
like this:

Index: lib/Kconfig
===================================================================
RCS file: /var/cvs/linux-2.5/lib/Kconfig,v
retrieving revision 1.4
diff -u -p -r1.4 Kconfig
--- lib/Kconfig	8 Apr 2003 15:20:57 -0000	1.4
+++ lib/Kconfig	26 Jun 2003 18:07:41 -0000
@@ -17,8 +17,8 @@ config CRC32
 #
 config ZLIB_INFLATE
 	tristate
-	default y if CRAMFS=y || PPP_DEFLATE=y || JFFS2_FS=y || ZISOFS_FS=y || BINFMT_ZFLAT=y || CRYPTO_DEFLATE=y
-	default m if CRAMFS=m || PPP_DEFLATE=m || JFFS2_FS=m || ZISOFS_FS=m || BINFMT_ZFLAT=m || CRYPTO_DEFLATE=m
+	default y if CRAMFS=y || PPP_DEFLATE=y || JFFS2_FS=y || ZISOFS_FS=y || CRYPTO_DEFLATE=y || (BINFMT_FLAT=y && BINFMT_ZFLAT=y)
+	default m if CRAMFS=m || PPP_DEFLATE=m || JFFS2_FS=m || ZISOFS_FS=m || CRYPTO_DEFLATE=m || (BINFMT_FLAT=m && BINFMT_ZFLAT=y)
 
 config ZLIB_DEFLATE
 	tristate

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
