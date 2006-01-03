Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbWACXHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbWACXHL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbWACXG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:06:58 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:41399 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964830AbWACXGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:06:55 -0500
Date: Wed, 4 Jan 2006 00:06:36 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 02/20] mutex subsystem, add typecheck_fn(type, function)
Message-ID: <20060103230636.GC13511@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuck Ebbert <76306.1226@compuserve.com>

add typecheck_fn(type, function) to do type-checking of function
pointers.

Modified-by: Ingo Molnar <mingo@elte.hu>

(made it typeof() based, instead of typedef based.)

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 include/linux/kernel.h |    9 +++++++++
 1 files changed, 9 insertions(+)

Index: linux/include/linux/kernel.h
===================================================================
--- linux.orig/include/linux/kernel.h
+++ linux/include/linux/kernel.h
@@ -286,6 +286,15 @@ extern void dump_stack(void);
 	1; \
 })
 
+/*
+ * Check at compile time that 'function' is a certain type, or is a pointer
+ * to that type (needs to use typedef for the function type.)
+ */
+#define typecheck_fn(type,function) \
+({	typeof(type) __tmp = function; \
+	(void)__tmp; \
+})
+
 #endif /* __KERNEL__ */
 
 #define SI_LOAD_SHIFT	16
