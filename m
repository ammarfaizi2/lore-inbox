Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbVLQVk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbVLQVk5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 16:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbVLQVk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 16:40:57 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:42509 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964977AbVLQVk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 16:40:57 -0500
Date: Sat, 17 Dec 2005 22:40:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] re-enable UID16 for !EMBEDDED
Message-ID: <20051217214058.GU23349@stusta.de>
References: <20051217044410.GO23349@stusta.de> <20051217195447.GG8637@waste.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051217195447.GG8637@waste.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2005 at 11:54:48AM -0800, Matt Mackall wrote:
> On Sat, Dec 17, 2005 at 05:44:10AM +0100, Adrian Bunk wrote:
> > It seems noone noticed that CONFIG_UID16 was accidentially always 
> > disabled in the latest -mm kernels.
> 
> Hmm, did I break it?

Yes, patch below.

cu
Adrian


<--  snip  -->


UID16 was accidentially disabled for !EMBEDDED.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-rc5-mm3-full/init/Kconfig.old	2005-12-17 19:55:58.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/init/Kconfig	2005-12-17 19:56:12.000000000 +0100
@@ -337,10 +337,11 @@
 config UID16
 	bool "Enable 16-bit UID system calls" if EMBEDDED
 	depends !ALPHA && !PPC && !PPC64 && !PARISC && !V850 && !ARCH_S390X
 	depends !X86_64 || IA32_EMULATION
 	depends !SPARC64 || SPARC32_COMPAT
+	default y
 	help
 	  This enables the legacy 16-bit UID syscall wrappers.
 
 config CC_OPTIMIZE_FOR_SIZE
 	bool "Optimize for size"
