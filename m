Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWABQeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWABQeT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 11:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWABQeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 11:34:09 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:2772 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750816AbWABQds (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 11:33:48 -0500
Date: Mon, 2 Jan 2006 17:33:37 +0100
From: Ingo Molnar <mingo@elte.hu>, Chuck Ebbert <76306.1226@compuserve.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 02/19] mutex subsystem, add typecheck_fn(type, function)
Message-ID: <20060102163337.GC31501@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.7
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.7 required=5.9 tests=ALL_TRUSTED,AWL,FROM_ENDS_IN_NUMS autolearn=no SpamAssassin version=3.0.3
	0.5 FROM_ENDS_IN_NUMS      From: ends in numbers
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
