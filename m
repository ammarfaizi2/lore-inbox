Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964944AbVIMSEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbVIMSEQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 14:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbVIMSEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 14:04:16 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61960 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964944AbVIMSEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 14:04:16 -0400
Date: Tue, 13 Sep 2005 19:04:10 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Joern Engel <joern@infradead.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Permanently fix kernel configuration include mess (was: Missing #include <config.h>)
Message-ID: <20050913190409.B26494@flint.arm.linux.org.uk>
Mail-Followup-To: Joern Engel <joern@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050913135622.GA30675@phoenix.infradead.org> <20050913150825.A23643@flint.arm.linux.org.uk> <20050913155012.C23643@flint.arm.linux.org.uk> <20050913165954.GA31461@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050913165954.GA31461@phoenix.infradead.org>; from joern@infradead.org on Tue, Sep 13, 2005 at 05:59:54PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 05:59:54PM +0100, Joern Engel wrote:
> On Tue, 13 September 2005 15:50:12 +0100, Russell King wrote:
> > 
> > Subject: [KBUILD] Permanently fix kernel configuration include mess.
> > 
> > Include autoconf.h into every kernel compilation via the gcc
> > command line using -imacros.  This ensures that we have the
> > kernel configuration included from the start, rather than
> > relying on each file having #include <linux/config.h> as
> > appropriate.  History has shown that this is something which
> > is difficult to get right.
> > 
> > Since we now include the kernel configuration automatically,
> > make configcheck becomes meaningless, so remove it.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> If it helps:
> Signed-off-by: Joern Engel <joern@wh.fh-wedel.de>

Might help more if I copied (or sent this to) akpm. 8)

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -346,7 +346,8 @@ AFLAGS_KERNEL	=
 # Use LINUXINCLUDE when you must reference the include/ directory.
 # Needed to be compatible with the O= option
 LINUXINCLUDE    := -Iinclude \
-                   $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include)
+                   $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include) \
+		   -imacros include/linux/autoconf.h
 
 CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
 
@@ -1247,11 +1248,6 @@ tags: FORCE
 # Scripts to check various things for consistency
 # ---------------------------------------------------------------------------
 
-configcheck:
-	find * $(RCS_FIND_IGNORE) \
-		-name '*.[hcS]' -type f -print | sort \
-		| xargs $(PERL) -w scripts/checkconfig.pl
-
 includecheck:
 	find * $(RCS_FIND_IGNORE) \
 		-name '*.[hcS]' -type f -print | sort \


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
