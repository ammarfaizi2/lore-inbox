Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290759AbSAYR7b>; Fri, 25 Jan 2002 12:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290765AbSAYR7R>; Fri, 25 Jan 2002 12:59:17 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:37393 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S290759AbSAYR66>; Fri, 25 Jan 2002 12:58:58 -0500
Date: Fri, 25 Jan 2002 18:01:50 +0000
From: John Levon <movement@marcelothewonderpenguin.com>
To: Andi Kleen <ak@suse.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: [PATCH] Fix 2.5.3pre reiserfs BUG() at boot time
Message-ID: <20020125180149.GB45738@compsoc.man.ac.uk>
In-Reply-To: <20020125182808.A8130@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020125182808.A8130@wotan.suse.de>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Bendik Singers - Afrotid
X-Toppers: N/A
X-Scanner: exiscan *16UAck-000NU2-00*DeLmAZMtyEQ* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2002 at 06:28:08PM +0100, Andi Kleen wrote:

> kmem_cache_create() ("reiserfs_inode_cache") but kmem_cache_create()
> only allows 19 character names and BUG()s for longer names.

please apply this too then.

regards
john


--- mm/slab.c.old	Fri Jan 25 17:54:11 2002
+++ mm/slab.c	Fri Jan 25 17:55:18 2002
@@ -599,7 +599,10 @@
  * @dtor: A destructor for the objects.
  *
  * Returns a ptr to the cache on success, NULL on failure.
- * Cannot be called within a int, but can be interrupted.
+ * Cannot be called within a interrupt, but can be interrupted.
+ *
+ * strlen(@name) must be less than %CACHE_NAMELEN.
+ * 
  * The @ctor is run when new pages are allocated by the cache
  * and the @dtor is run before the pages are handed back.
  * The flags are
