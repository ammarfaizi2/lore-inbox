Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266124AbUHATCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266124AbUHATCv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 15:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266126AbUHATCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 15:02:51 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:2510 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266124AbUHATCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 15:02:49 -0400
Date: Sun, 1 Aug 2004 21:02:41 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Nathan Scott <nathans@sgi.com>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       "Jeffrey E. Hundstad" <jeffrey.hundstad@mnsu.edu>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Steve Lord <lord@xfs.org>, linux-xfs@oss.sgi.com,
       Cahya Wirawan <cwirawan@email.archlab.tuwien.ac.at>,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] let 4KSTACKS depend on EXPERIMENTAL
Message-ID: <20040801190241.GC2746@fs.tum.de>
References: <20040720114418.GH21918@email.archlab.tuwien.ac.at> <40FD0A61.1040503@xfs.org> <40FD2E99.20707@mnsu.edu> <20040720195012.GN14733@fs.tum.de> <20040729060900.GA1946@frodo> <20040729114219.GN2349@fs.tum.de> <20040730083040.A2703153@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040730083040.A2703153@wobbly.melbourne.sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2004 at 08:30:40AM +1000, Nathan Scott wrote:
>...
> Adrian wrote:
> > 2.6 is a stable kernel series used in production environments.
> > 
> > Regarding Linus' tree, it's IMHO the best solution to work around it 
> > this way until all issues are sorted out.
> 
> I'm not really convinced - the EXPERIMENTAL marking should
> be plenty of a deterent to folks in production environments.
> There are reports of stack overruns on other filesystems as
> well with 4KSTACKS, so doesn't seem worthwhile to me to do
> this just for XFS.


OK, below is a patch that only adds a dependency of 4KSTACKS on 
EXPERIMENTAL.

Considering that not all issues with 4kb stacks are currently corrected, 
this patch should IMHO go in 2.6.8 .


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8-rc2-mm1-full/arch/i386/Kconfig.old	2004-08-01 20:59:02.000000000 +0200
+++ linux-2.6.8-rc2-mm1-full/arch/i386/Kconfig	2004-08-01 20:59:46.000000000 +0200
@@ -1474,7 +1474,8 @@
 	  to solve problems without frame pointers.
 
 config 4KSTACKS
-	bool "Use 4Kb for kernel stacks instead of 8Kb"
+	bool "Use 4Kb for kernel stacks instead of 8Kb (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
 	help
 	  If you say Y here the kernel will use a 4Kb stacksize for the
 	  kernel stack attached to each process/thread. This facilitates


