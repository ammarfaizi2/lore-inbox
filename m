Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbVLSBfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbVLSBfW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 20:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbVLSBfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 20:35:22 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:10471 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030217AbVLSBfV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 20:35:21 -0500
Date: Mon, 19 Dec 2005 02:34:29 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, Paul Jackson <pj@sgi.com>
Subject: [patch 01/15] Generic Mutex Subsystem, add-atomic-xchg-i386.patch
Message-ID: <20051219013429.GB27658@elte.hu>
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


add atomic_cmpxchg() to i386. Needed by the new mutex code.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 include/asm-i386/atomic.h |    1 +
 1 files changed, 1 insertion(+)

Index: linux/include/asm-i386/atomic.h
===================================================================
--- linux.orig/include/asm-i386/atomic.h
+++ linux/include/asm-i386/atomic.h
@@ -216,6 +216,7 @@ static __inline__ int atomic_sub_return(
 }
 
 #define atomic_cmpxchg(v, old, new) ((int)cmpxchg(&((v)->counter), old, new))
+#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
 /**
  * atomic_add_unless - add unless the number is a given value
