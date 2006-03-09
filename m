Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751558AbWCIB2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbWCIB2h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 20:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbWCIB2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 20:28:37 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:26895 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750786AbWCIB2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 20:28:37 -0500
Date: Thu, 9 Mar 2006 02:28:35 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-kernel@vger.kernel.org,
       ben@fluff.org
Subject: [2.6 patch] add a proper prototype for setup_arch()
Message-ID: <20060309012835.GX4006@stusta.de>
References: <20060305204418.GA7244@home.fluff.org> <20060305230321.6ce3ea57.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060305230321.6ce3ea57.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2006 at 11:03:21PM -0800, Andrew Morton wrote:
> Ben Dooks <ben-linux@fluff.org> wrote:
> >
> > When running sparse over an ARM build of 2.6.16-rc5, I came
> >  across this error, which is due to setup_arch() being used
> >  be init/main.c, but not being defined in any headers.
> > 
> >  This patch adds setup_arch() definition to include/linux/init.h
> > 
> >  The warning is:
> >    arch/arm/kernel/setup.c:730:13: warning: symbol 'setup_arch' was not declared. Should it be static?
> > 
> > ...
> >
> >  --- linux-2.6.16-rc5/include/linux/init.h	2006-02-28 09:05:02.000000000 +0000
> >  +++ linux-2.6.16-rc5-fixes/include/linux/init.h	2006-03-05 20:39:21.000000000 +0000
> >  @@ -69,6 +69,10 @@ extern initcall_t __security_initcall_st
> >   
> >   /* Defined in init/main.c */
> >   extern char saved_command_line[];
> >  +
> >  +/* used by init/main.c */
> >  +extern void setup_arch(char **);
> 
> There are already declarations of setup_arch in include/asm-ppc and
> include/asm-powerpc.  Different declarations.

These are struct members, not function prototypes.

> Plus there's an unneeded-with-this-patch declaration in init/main.c.

Updated patch below.

cu
Adrian


<--  snip  -->


This patch adds a proper prototype for setup_arch() in init.h .

This patch is based on a patch by Ben Dooks <ben-linux@fluff.org>.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/init.h |    4 ++++
 init/main.c          |    2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6.16-rc5-mm3-full/include/linux/init.h.old	2006-03-08 23:32:22.000000000 +0100
+++ linux-2.6.16-rc5-mm3-full/include/linux/init.h	2006-03-08 23:32:26.000000000 +0100
@@ -69,6 +69,10 @@
 
 /* Defined in init/main.c */
 extern char saved_command_line[];
+
+/* used by init/main.c */
+extern void setup_arch(char **);
+
 #endif
   
 #ifndef MODULE
--- linux-2.6.16-rc5-mm3-full/init/main.c.old	2006-03-08 23:35:40.000000000 +0100
+++ linux-2.6.16-rc5-mm3-full/init/main.c	2006-03-08 23:35:45.000000000 +0100
@@ -324,8 +324,6 @@
 }
 __setup("rdinit=", rdinit_setup);
 
-extern void setup_arch(char **);
-
 #ifndef CONFIG_SMP
 
 #ifdef CONFIG_X86_LOCAL_APIC

