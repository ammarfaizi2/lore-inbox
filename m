Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbWDBI47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWDBI47 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 04:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWDBI47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 04:56:59 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:45063 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932291AbWDBI46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 04:56:58 -0400
Date: Sun, 2 Apr 2006 10:56:56 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, linux-acpi@vger.kernel.org
Subject: [-mm patch] memory_hotplug.h: no need to #if guard the {add,remove}_memory() prototypes
Message-ID: <20060402085656.GD11800@stusta.de>
References: <20060328114655.05e1933f.rdunlap@xenotime.net> <20060401221641.GC11800@stusta.de> <20060401160818.b9777586.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060401160818.b9777586.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2006 at 04:08:18PM -0800, Randy.Dunlap wrote:
> On Sun, 2 Apr 2006 00:16:41 +0200 Adrian Bunk wrote:
> 
> > On Tue, Mar 28, 2006 at 11:46:55AM -0800, Randy.Dunlap wrote:
> > > From: Randy Dunlap <rdunlap@xenotime.net>
> > > 
> > > Spell CONFIG option correctly so that externs work.
> > > Fixes these warnings:
> > > drivers/acpi/acpi_memhotplug.c:248: warning: implicit declaration of function 'add_memory'
> > > drivers/acpi/acpi_memhotplug.c:312: warning: implicit declaration of function 'remove_memory'
> > > 
> > > Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> > > ---
> > >  linsrc/linux-2616-mm2/include/linux/memory_hotplug.h |    2 +-
> > >  1 files changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > --- rddunlap.orig/linsrc/linux-2616-mm2/include/linux/memory_hotplug.h
> > > +++ rddunlap/linsrc/linux-2616-mm2/include/linux/memory_hotplug.h
> > > @@ -105,7 +105,7 @@ static inline int __remove_pages(struct 
> > >  }
> > >  
> > >  #if defined(CONFIG_MEMORY_HOTPLUG) || defined(CONFIG_ACPI_HOTPLUG_MEMORY) \
> > > -	|| defined(CONFIG_ACPI_MEMORY_HOTPLUG_MODULE)
> > > +	|| defined(CONFIG_ACPI_HOTPLUG_MEMORY_MODULE)
> > >  extern int add_memory(u64 start, u64 size);
> > >  extern int remove_memory(u64 start, u64 size);
> > >  #endif
> > 
> > What about simply offering the prototypes unconditionally?
> 
> duh, yes, that should be OK AFAIK.  Could you do that?

Patch below.

> ~Randy

cu
Adrian


<--  snip  -->


We don't have to #if guard prototypes.

This also fixes a bug observed by Randy Dunlap due to a misspelled 
option in the #if (I haven't investigated whether it was harmless or 
might have caused runtime corruption).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-mm2-full/include/linux/memory_hotplug.h.old	2006-04-02 10:44:37.000000000 +0200
+++ linux-2.6.16-mm2-full/include/linux/memory_hotplug.h	2006-04-02 10:44:50.000000000 +0200
@@ -104,10 +104,7 @@
 	return -ENOSYS;
 }
 
-#if defined(CONFIG_MEMORY_HOTPLUG) || defined(CONFIG_ACPI_HOTPLUG_MEMORY) \
-	|| defined(CONFIG_ACPI_MEMORY_HOTPLUG_MODULE)
 extern int add_memory(u64 start, u64 size);
 extern int remove_memory(u64 start, u64 size);
-#endif
 
 #endif /* __LINUX_MEMORY_HOTPLUG_H */

