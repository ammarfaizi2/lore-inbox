Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267278AbUIEV4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267278AbUIEV4M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 17:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267285AbUIEV4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 17:56:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:14777 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267278AbUIEV4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 17:56:08 -0400
Date: Sun, 5 Sep 2004 14:53:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: jhf@rivenstone.net (Joseph Fannin)
Cc: albert_herranz@yahoo.es, roland@redhat.com, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org
Subject: Re: 2.6.9-rc1-mm1 ppc build broken
Message-Id: <20040905145355.0cf48d5c.akpm@osdl.org>
In-Reply-To: <20040904203715.GA3049@samarkand.rivenstone.net>
References: <200408302348.i7UNmvw0006978@magilla.sf.frob.com>
	<20040831105118.85292.qmail@web52306.mail.yahoo.com>
	<20040904203715.GA3049@samarkand.rivenstone.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jhf@rivenstone.net (Joseph Fannin) wrote:
>
>  > The #include <asm/io.h> comes from bk-ia64.patch time
>  > interpolation logic patch from Cristoph Lameter.
>  > 
>  > I've checked that at least for the embedded port I'm
>  > working on the linux/mm.h is *not* a must on ppc
>  > asm/io.h so we can get rid of it (commented out).
>  > Maybe this is also true for the rest of ppc platforms.
>  > 
>  > Now 2.6.9-rc1-mm1 builds fine.
> 
>      This is still broken in -mm3.  This fix works for my powermac too,
>  except that arch/ppc/syslib/open_pic.c misses errno.h when it does not
>  get it through mm.h.  I can't speak for other platforms, but I'll
>  include the patch.

OK, now I have an ordering problem.  If I understand you correctly, this
patch fixes a ppc problem which was introduced by a patch from the bk-ia64
tree, yes?

If so, my options are to ask Tony to add this patch to the bk-ia64 tree so
they all go in at the same time, or to merge this patch into Linus's tree
prior to the ia64 patch.  To do the latter, I'd need confirmation that your
patch is safe against current -linus.  Can you please confirm this?

--- 25/arch/ppc/syslib/open_pic.c~ppc-build-fix	2004-09-05 14:50:54.250084104 -0700
+++ 25-akpm/arch/ppc/syslib/open_pic.c	2004-09-05 14:50:54.266081672 -0700
@@ -16,6 +16,7 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/sysdev.h>
+#include <linux/errno.h>
 #include <asm/ptrace.h>
 #include <asm/signal.h>
 #include <asm/io.h>
diff -puN include/asm-ppc/io.h~ppc-build-fix include/asm-ppc/io.h
--- 25/include/asm-ppc/io.h~ppc-build-fix	2004-09-05 14:50:54.262082280 -0700
+++ 25-akpm/include/asm-ppc/io.h	2004-09-05 14:50:54.276080152 -0700
@@ -4,7 +4,6 @@
 
 #include <linux/config.h>
 #include <linux/types.h>
-#include <linux/mm.h>
 
 #include <asm/page.h>
 #include <asm/byteorder.h>
_

