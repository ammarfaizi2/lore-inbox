Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbTFXJwW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 05:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbTFXJwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 05:52:22 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:5076 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S261292AbTFXJwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 05:52:21 -0400
Date: Tue, 24 Jun 2003 12:06:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: Provide example copy_in_user implementation
Message-ID: <20030624100610.GC159@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch adds example copy_in_user implementation (copy_in_user is
needed for new ioctl32 implementation, all 64bit archs will need
it)... Please apply,

								Pavel

Index: linux/include/asm-generic/uaccess.h
===================================================================
--- linux.orig/include/asm-generic/uaccess.h	2003-06-17 17:10:44.000000000 +0200
+++ linux/include/asm-generic/uaccess.h	2003-06-16 16:09:52.000000000 +0200
@@ -0,0 +1,13 @@
+static inline unsigned long copy_in_user(void *dst, const void *src, unsigned size) 
+{ 
+	unsigned i, ret;
+	unsigned char c;
+	for (i=0; i<size; i++) {
+		if (copy_from_user(&c, src+i, 1)) 
+			return size-i;
+		if (copy_to_user(dst+i, &c, 1))
+			return size-i;
+	}
+	return 0;
+}	
+


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
