Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316050AbSEJQ3j>; Fri, 10 May 2002 12:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316060AbSEJQ3i>; Fri, 10 May 2002 12:29:38 -0400
Received: from air-2.osdl.org ([65.201.151.6]:32898 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S316050AbSEJQ3h>;
	Fri, 10 May 2002 12:29:37 -0400
Date: Fri, 10 May 2002 09:25:55 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
To: Keith Owens <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.15 laziness in export-objs
In-Reply-To: <25744.1020998571@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.33.0205100924580.762-100000@segfault.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 May 2002, Keith Owens wrote:

> 2.5.15 has four Makefiles where all objects are marked as exporting
> symbols.  This is lazy coding and causes spurious rebuilds.  Please
> specify only those objects that really export symbols.
> 
> Also the export list is independent of whether an object is selected or
> not.  That is, export-objs is unconditional.
> 
> fs/nls/Makefile:export-objs = $(obj-y)
> arch/i386/pci/Makefile:export-objs     +=      $(obj-y)
> drivers/base/Makefile:export-objs     := $(obj-y)
> drivers/pci/Makefile:export-objs := $(obj-y)

Here is the patch for drivers/base.

	-pat

===== drivers/base/Makefile 1.3 vs edited =====
--- 1.3/drivers/base/Makefile	Tue Mar 26 14:26:45 2002
+++ edited/drivers/base/Makefile	Fri May 10 09:24:33 2002
@@ -2,6 +2,6 @@
 
 obj-y		:= core.o sys.o interface.o fs.o power.o
 
-export-objs	:= $(obj-y)
+export-objs	:= core.o fs.o power.o sys.o
 
 include $(TOPDIR)/Rules.make

