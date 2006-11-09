Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966000AbWKINqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966000AbWKINqk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 08:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966001AbWKINqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 08:46:40 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:10760 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S966000AbWKINqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 08:46:40 -0500
Date: Thu, 9 Nov 2006 13:46:32 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Fix missing parens in set_personality()
Message-ID: <20061109134632.GA17179@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you call set_personality() with an expression such as:

	set_personality(foo ? PERS_FOO1 : PERS_FOO2);

then this evaluates to:

	((current->personality == foo ? PERS_FOO1 : PERS_FOO2) ? ...

which is obviously not the intended result.  Add the missing parents
to ensure this gets evaluated as expected:

	((current->personality == (foo ? PERS_FOO1 : PERS_FOO2)) ? ...

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff --git a/include/linux/personality.h b/include/linux/personality.h
index bf4cf20..012cd55 100644
--- a/include/linux/personality.h
+++ b/include/linux/personality.h
@@ -114,7 +114,7 @@ #define get_personality		(current->perso
  * Change personality of the currently running process.
  */
 #define set_personality(pers) \
-	((current->personality == pers) ? 0 : __set_personality(pers))
+	((current->personality == (pers)) ? 0 : __set_personality(pers))
 
 #endif /* __KERNEL__ */
 

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
