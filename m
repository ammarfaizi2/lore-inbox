Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269229AbUINJRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269229AbUINJRX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 05:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269227AbUINJRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 05:17:23 -0400
Received: from holomorphy.com ([207.189.100.168]:24722 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269236AbUINJQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 05:16:17 -0400
Date: Tue, 14 Sep 2004 02:15:05 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Alex Zarochentsev <zam@namesys.com>, Hugh Dickins <hugh@veritas.com>,
       Paul Jackson <pj@sgi.com>, Hans Reiser <reiser@namesys.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [sparc32] add atomic_sub_and_test() to make reiser4 code microoptimized for x86 compile on sparc32
Message-ID: <20040914091505.GM9106@holomorphy.com>
References: <Pine.LNX.4.61.0409131608530.877@scrub.home> <Pine.LNX.4.44.0409131545100.17907-100000@localhost.localdomain> <20040913171936.GC2252@backtop.namesys.com> <20040914020614.GI9106@holomorphy.com> <Pine.LNX.4.61.0409141055000.877@scrub.home> <20040914091045.GL9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914091045.GL9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 02:10:45AM -0700, William Lee Irwin III wrote:
> The only point I had to make was that I'd rather avoid adding arch
> hooks for code that will never be run on the arch. I suppose for the
> sake of compiletesting...

Repost with appropriate Subject: line (I'm trying to cut down on these).


-- wli

Add atomic_sub_and_test() to sparc32, implemented in terms of
atomic_sub_return(),  so reiser4 can be simultaneously microoptimized
for x86 and made to pass compilation testing on sparc32.


Index: mm5-2.6.9-rc1/include/asm-sparc/atomic.h
===================================================================
--- mm5-2.6.9-rc1.orig/include/asm-sparc/atomic.h	2004-08-13 22:37:25.000000000 -0700
+++ mm5-2.6.9-rc1/include/asm-sparc/atomic.h	2004-09-14 01:59:51.579542880 -0700
@@ -46,6 +46,7 @@
 #define atomic_inc_and_test(v) (atomic_inc_return(v) == 0)
 
 #define atomic_dec_and_test(v) (atomic_dec_return(v) == 0)
+#define atomic_sub_and_test(v) (atomic_sub_return(v) == 0)
 
 /* This is the old 24-bit implementation.  It's still used internally
  * by some sparc-specific code, notably the semaphore implementation.
