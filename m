Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262884AbSJRDvp>; Thu, 17 Oct 2002 23:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262885AbSJRDvp>; Thu, 17 Oct 2002 23:51:45 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:46351 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262884AbSJRDvo>;
	Thu, 17 Oct 2002 23:51:44 -0400
Date: Thu, 17 Oct 2002 20:57:20 -0700
From: Greg KH <greg@kroah.com>
To: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "Patterson, David H" <david.h.patterson@intel.com>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Abel, Michael J" <michael.j.abel@intel.com>,
       "Tarabini, Anthony" <anthony.tarabini@intel.com>,
       "'andreasW@ati.com'" <andreasW@ati.com>,
       "Abdul-Khaliq, Rushdan" <rushdan.abdul-khaliq@intel.com>
Subject: Re: [PATCH] GART driver support for generic AGP 3.0 device detection/ enabling & Intel 7505 chipset support
Message-ID: <20021018035720.GA3326@kroah.com>
References: <D1C0BF20D4AFD411AB98009027AE99881167C7BF@fmsmsx40.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D1C0BF20D4AFD411AB98009027AE99881167C7BF@fmsmsx40.fm.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 11:13:19AM -0700, Tolentino, Matthew E wrote:
> Attached is a patch for generic AGP 3.0 device detection and enabling
> routines as well as specific support for the Intel 7505 chipset against the
> 2.5.43 kernel.   

Just a minor comment:


diff -urN linux-2.5.43-vanilla/drivers/char/agp/Makefile linux-2.5.43/drivers/char/agp/Makefile
--- linux-2.5.43-vanilla/drivers/char/agp/Makefile	Tue Oct 15 20:27:49 2002
+++ linux-2.5.43/drivers/char/agp/Makefile	Thu Oct 17 10:12:41 2002
@@ -3,12 +3,13 @@
 # space ioctl interface to use agp memory.  It also adds a kernel interface
 # that other drivers could use to manipulate agp memory.
 
-export-objs := agp.o
+export-objs := agp.o agp3.o
 
-agpgart-y := agp.o frontend.o
+agpgart-y := agp.o agp3.o frontend.o 
 
 agpgart-$(CONFIG_AGP_INTEL)	+= i8x0-agp.o
 agpgart-$(CONFIG_AGP_I810)	+= i810-agp.o
+agpgart-$(CONFIG_AGP_I7505)	+= i7505-agp.o
 agpgart-$(CONFIG_AGP_VIA)	+= via-agp.o
 agpgart-$(CONFIG_AGP_AMD)	+= amd-agp.o
 agpgart-$(CONFIG_AGP_SIS)	+= sis-agp.o


You should probably not build agp3.o unless i7505-agp.o is built too, or
do some of the other drivers need functions in agp3.c?


thanks,

greg k-h
