Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261814AbUKJBqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbUKJBqS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 20:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbUKJBqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 20:46:17 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59918 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261814AbUKJBpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 20:45:50 -0500
Date: Wed, 10 Nov 2004 02:45:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] Use -ffreestanding?
Message-ID: <20041110014516.GC4089@stusta.de>
References: <20041107142445.GH14308@stusta.de> <20041108134448.GA2456@wotan.suse.de> <20041108153436.GB9783@stusta.de> <20041108161935.GC2456@wotan.suse.de> <20041108163101.GA13234@stusta.de> <20041108175120.GB27525@wotan.suse.de> <20041108183449.GC15077@stusta.de> <20041108190130.GA2564@wotan.suse.de> <20041108233806.GM15077@stusta.de> <20041109050107.GA5328@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109050107.GA5328@wotan.suse.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 06:01:07AM +0100, Andi Kleen wrote:
> > Why doesn't the kernel use -ffreestanding which should prevent all such 
> > problems?
> 
> Because we want most of these optimizations. Also with -ffreestanding

Do we really want the compiler to silently replace in-kernel functions 
with built-ins?

You can still do an explicit
  #define strlen __builtin_strlen
if you want to use a gcc built-in function.

> you would need to supply the out of line string functions anyways 
> because gcc wouldn't inline them.

At least with gcc 3.4.2 on i386 adding -ffreestanding and your 
(i386-specific) IN_STRING_C hack removed compiles fine.

> -Andi


I'm open for examples why this actually doesn't work, but after my 
(limited) testin I'd suggest the patch below for inclusion in the next 
-mm.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm4-full-ffreestanding/Makefile.old	2004-11-09 22:27:06.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full-ffreestanding/Makefile	2004-11-09 22:27:47.000000000 +0100
@@ -349,7 +349,8 @@
 CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
 
 CFLAGS 		:= -Wall -Wstrict-prototypes -Wno-trigraphs \
-	  	   -fno-strict-aliasing -fno-common
+	  	   -fno-strict-aliasing -fno-common \
+		   -ffreestanding
 AFLAGS		:= -D__ASSEMBLY__
 
 export	VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION LOCALVERSION KERNELRELEASE \



