Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315787AbSEJDmx>; Thu, 9 May 2002 23:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315788AbSEJDmw>; Thu, 9 May 2002 23:42:52 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:9482 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S315787AbSEJDmv>;
	Thu, 9 May 2002 23:42:51 -0400
Date: Thu, 9 May 2002 19:42:42 -0700
From: Greg KH <greg@kroah.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.15 laziness in export-objs
Message-ID: <20020510024242.GA20468@kroah.com>
In-Reply-To: <25744.1020998571@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 12 Apr 2002 00:55:19 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2002 at 12:42:51PM +1000, Keith Owens wrote:
> 2.5.15 has four Makefiles where all objects are marked as exporting
> symbols.  This is lazy coding and causes spurious rebuilds.  Please
> specify only those objects that really export symbols.
> 
> Also the export list is independent of whether an object is selected or
> not.  That is, export-objs is unconditional.

Does this patch fix up arch/i386/pci/Makefile and drivers/pci/Makefile
properly?

thanks,

greg k-h


diff -Nru a/arch/i386/pci/Makefile b/arch/i386/pci/Makefile
--- a/arch/i386/pci/Makefile	Thu May  9 20:50:36 2002
+++ b/arch/i386/pci/Makefile	Thu May  9 20:50:36 2002
@@ -24,6 +24,4 @@
 obj-y		+= irq.o common.o
 endif		# CONFIG_VISWS
 
-export-objs     +=      $(obj-y)
-
 include $(TOPDIR)/Rules.make
diff -Nru a/drivers/pci/Makefile b/drivers/pci/Makefile
--- a/drivers/pci/Makefile	Thu May  9 20:50:36 2002
+++ b/drivers/pci/Makefile	Thu May  9 20:50:36 2002
@@ -37,7 +37,8 @@
 obj-y += syscall.o
 endif
 
-export-objs := $(obj-y)
+export-objs	:= access.o hotplug.o pci.o pci-driver.o \
+		pool.o probe.o proc.o search.o
 
 include $(TOPDIR)/Rules.make
 
