Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbWAFMol@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbWAFMol (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 07:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWAFMol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 07:44:41 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6666 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750909AbWAFMok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 07:44:40 -0500
Date: Fri, 6 Jan 2006 13:44:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: [2.6 patch] UML - Prevent MODE_SKAS=n and MODE_TT=n
Message-ID: <20060106124438.GB12131@stusta.de>
References: <200601042151.k04LpxbH009237@ccure.user-mode-linux.org> <20060104152433.7304ec75.akpm@osdl.org> <20060105022129.GA13183@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060105022129.GA13183@ccure.user-mode-linux.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 09:21:29PM -0500, Jeff Dike wrote:
> On Wed, Jan 04, 2006 at 03:24:33PM -0800, Andrew Morton wrote:
> > Jeff Dike <jdike@addtoit.com> wrote:
> > >
> > > Produce a compile-time error if both MODE_SKAS and MODE_TT are disabled.
> > Is there no sane way to prevent this situation within Kconfig?
> 
> I tried.  The best I managed was to get *config to moan about circular
> dependencies.

The patch below implements this in Kconfig.

> 				Jeff

cu
Adrian


<--  snip  -->


If MODE_TT=n, MODE_SKAS must be y.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-git/arch/um/Kconfig.old	2006-01-06 13:41:02.000000000 +0100
+++ linux-git/arch/um/Kconfig	2006-01-06 13:41:14.000000000 +0100
@@ -83,7 +83,7 @@
         of physical memory.
 
 config MODE_SKAS
-	bool "Separate Kernel Address Space support"
+	bool "Separate Kernel Address Space support" if MODE_TT
 	default y
 	help
 	This option controls whether skas (separate kernel address space)

