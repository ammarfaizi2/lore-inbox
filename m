Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965013AbVLNWNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013AbVLNWNF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 17:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbVLNWNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 17:13:05 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:9231 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965013AbVLNWNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 17:13:04 -0500
Date: Wed, 14 Dec 2005 23:13:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] offer CC_OPTIMIZE_FOR_SIZE only if EXPERIMENTAL
Message-ID: <20051214221304.GE23349@stusta.de>
References: <20051214191006.GC23349@stusta.de> <20051214140531.7614152d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051214140531.7614152d.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 02:05:31PM -0800, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > Hi Linus,
> > 
> > your patch to allow CC_OPTIMIZE_FOR_SIZE even for EMBEDDED=n has broken 
> > the EMBEDDED menu.
> 
> It looks like that patch needs to be reverted or altered anyway.  sparc64
> machines are failing all over the place, possibly due to newly-exposed
> compiler bugs.
> 
> Whether it's the compiler or it's genuine kernel bugs, the same problems
> are likely to bite other architectures.

The help text already contains a bold warning.

What about marking it as EXPERIMENTAL?
That is not that heavy as EMBEDDED but expresses this.

cu
Adrian


<--  snip  -->


CC_OPTIMIZE_FOR_SIZE is still an experimental feature that doesn't work 
with all supported gcc/architecture combinations.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-git/init/Kconfig.old	2005-12-14 23:08:51.000000000 +0100
+++ linux-git/init/Kconfig	2005-12-14 23:09:09.000000000 +0100
@@ -257,7 +257,7 @@
 source "usr/Kconfig"
 
 config CC_OPTIMIZE_FOR_SIZE
-	bool "Optimize for size"
+	bool "Optimize for size (EXPERIMENTAL)" if EXPERIMENTAL
 	default y if ARM || H8300
 	help
 	  Enabling this option will pass "-Os" instead of "-O2" to gcc

