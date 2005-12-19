Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030221AbVLSBfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbVLSBfn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 20:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbVLSBfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 20:35:43 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:3813 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030221AbVLSBfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 20:35:36 -0500
Date: Mon, 19 Dec 2005 02:34:42 +0100
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
Subject: [patch 02/15] Generic Mutex Subsystem, add-atomic-xchg-x86_64.patch
Message-ID: <20051219013442.GC27658@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.7
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.7 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


add atomic_cmpxchg() to x86_64. Needed by the new mutex code.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 include/asm-x86_64/atomic.h |    1 +
 1 files changed, 1 insertion(+)

Index: linux/include/asm-x86_64/atomic.h
===================================================================
--- linux.orig/include/asm-x86_64/atomic.h
+++ linux/include/asm-x86_64/atomic.h
@@ -389,6 +389,7 @@ static __inline__ long atomic64_sub_retu
 #define atomic64_dec_return(v)  (atomic64_sub_return(1,v))
 
 #define atomic_cmpxchg(v, old, new) ((int)cmpxchg(&((v)->counter), old, new))
+#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
 /**
  * atomic_add_unless - add unless the number is a given value
