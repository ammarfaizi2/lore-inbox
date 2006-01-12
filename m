Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161459AbWALXSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161459AbWALXSe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 18:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161461AbWALXSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 18:18:34 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:54532 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161459AbWALXSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 18:18:33 -0500
Date: Fri, 13 Jan 2006 00:18:33 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: [2.6 patch] i386: remove gcc version check for CONFIG_REGPARM
Message-ID: <20060112231833.GC29663@stusta.de>
References: <20060109211157.GA14477@mars.ravnborg.org> <Pine.LNX.4.64.0601100821440.4939@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601100821440.4939@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 08:27:57AM -0800, Linus Torvalds wrote:
> 
> 
> On Mon, 9 Jan 2006, Sam Ravnborg wrote:
> >
> > Please pull from:
> > 	ssh://master.kernel.org/pub/scm/linux/kernel/git/sam/kbuild.git
> 
> Ok, pulled.
> 
> However, fixing up a trivial conflict in i386/Makefile, I noticed this:
> 
> 	cflags-$(CONFIG_REGPARM) += $(shell if [ $(call cc-version) -ge 0300 ] ; then \
> 				    echo "-mregparm=3"; fi ;)
> 
> and it strikes me that this is WRONG.
> 
> It's wrong for some subtle reasons: it means that CONFIG_REGPARM is set 
> whether or not it is actually _used_, which means that anybody who depends 
> on CONFIG_REGPARM in the sources is just screwed.
>...

The change from Sam's tree conflicted with my patch to completely remove  
the version check since we do no longer support any gcc < 3.0.  

Patch below.

> 		Linus

cu
Adrian


<--  snip  -->


Since we do no longer support any gcc < 3.0, there's no need to check 
for it..


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-mm3-full/arch/i386/Makefile.old	2006-01-13 00:04:09.000000000 +0100
+++ linux-2.6.15-mm3-full/arch/i386/Makefile	2006-01-13 00:05:09.000000000 +0100
@@ -37,10 +37,7 @@
 # CPU-specific tuning. Anything which can be shared with UML should go here.
 include $(srctree)/arch/i386/Makefile.cpu
 
-# -mregparm=3 works ok on gcc-3.0 and later
-#
-cflags-$(CONFIG_REGPARM) += $(shell if [ $(call cc-version) -ge 0300 ] ; then \
-                            echo "-mregparm=3"; fi ;)
+cflags-$(CONFIG_REGPARM) += -mregparm=3
 
 # Disable unit-at-a-time mode on pre-gcc-4.0 compilers, it makes gcc use
 # a lot more stack due to the lack of sharing of stacklots:

