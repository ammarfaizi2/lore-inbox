Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264499AbUFXNCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264499AbUFXNCZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 09:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264482AbUFXM7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 08:59:36 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:23261 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S264484AbUFXM4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 08:56:24 -0400
Date: Thu, 24 Jun 2004 07:55:44 -0500
From: Jack Steiner <steiner@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] - Reduce TLB flushing during process migration
Message-ID: <20040624125544.GA15742@sgi.com>
References: <20040623143844.GA15670@sgi.com> <20040623143318.07932255.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040623143318.07932255.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 02:33:18PM -0700, Andrew Morton wrote:
> Jack Steiner <steiner@sgi.com> wrote:
> >
> > This patch adds a platform specific hook to allow an arch-specific
> > function to be called after an explicit migration.
> 
> OK by me.  David, could you please merge this up?
> 
> Jack, please prepare an update for Documentation/cachetlb.txt.




Signed-off-by: Jack Steiner <steiner@sgi.com>




--- linuxbase/Documentation/cachetlb.txt	2004-06-22 07:15:46.000000000 -0500
+++ linux/Documentation/cachetlb.txt	2004-06-24 07:54:50.000000000 -0500
@@ -132,6 +132,17 @@
 	translations for software managed TLB configurations.
 	The sparc64 port currently does this.
 
+7) void tlb_migrate_finish(struct mm_struct *mm)
+
+	This interface is called at the end of an explicit
+	process migration. This interface provides a hook 
+	to allow a platform to update TLB or context-specific 
+	information for the address space.
+
+	The ia64 sn2 platform is one example of a platform
+	that uses this interface.
+
+
 Next, we have the cache flushing interfaces.  In general, when Linux
 is changing an existing virtual-->physical mapping to a new value,
 the sequence will be in one of the following forms:

-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


