Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261896AbVF0HvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbVF0HvW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 03:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbVF0HvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 03:51:22 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:5800 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S261896AbVF0Htm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 03:49:42 -0400
Date: Mon, 27 Jun 2005 10:49:19 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Andi Kleen <ak@suse.de>
cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
       Jeff Mahoney <jeffm@suse.de>, penberg@gmail.com, reiser@namesys.com,
       flx@namesys.com, zam@namesys.com, vs@thebsh.namesys.com,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: -mm -> 2.6.13 merge status
In-Reply-To: <20050627072832.GA14251@wotan.suse.de>
Message-ID: <Pine.LNX.4.58.0506271048310.26869@sbz-30.cs.Helsinki.FI>
References: <p73d5qgc67h.fsf@verdi.suse.de> <42B86027.3090001@namesys.com>
 <20050621195642.GD14251@wotan.suse.de> <42B8C0FF.2010800@namesys.com>
 <84144f0205062223226d560e41@mail.gmail.com> <42BB0151.3030904@suse.de>
 <20050623114318.5ae13514.akpm@osdl.org> <20050623193247.GC6814@suse.de>
 <1119717967.9392.2.camel@localhost> <20050627072449.GF19550@suse.de>
 <20050627072832.GA14251@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-27 at 09:28 +0200, Andi Kleen wrote:
> You can just dump the expression (with #argument). That is what
> traditional userspace assert did forever.
> 
> It won't help for BUG_ON(a || b || c || d || e) but these
> are bad style anyways and should be avoided.

Sounds good to me. Jens, would this work for you?

			Pekka

Show BUG_ON expression when assertion fails.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 bug.h |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

Index: 2.6/include/asm-generic/bug.h
===================================================================
--- 2.6.orig/include/asm-generic/bug.h
+++ 2.6/include/asm-generic/bug.h
@@ -13,7 +13,12 @@
 #endif
 
 #ifndef HAVE_ARCH_BUG_ON
-#define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
+#define BUG_ON(condition) do { \
+	if (unlikely((condition) != 0)) { \
+		printk("kernel BUG '%s' at %s:%d!\n", #condition, __FILE__, __LINE__); \
+		panic("BUG!"); \
+	} \
+} while(0)
 #endif
 
 #ifndef HAVE_ARCH_WARN_ON

