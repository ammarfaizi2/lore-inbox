Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261934AbSL2WuF>; Sun, 29 Dec 2002 17:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261963AbSL2WuF>; Sun, 29 Dec 2002 17:50:05 -0500
Received: from verein.lst.de ([212.34.181.86]:54539 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S261934AbSL2WuD>;
	Sun, 29 Dec 2002 17:50:03 -0500
Date: Sun, 29 Dec 2002 23:58:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove CONFIG_X86_NUMA
Message-ID: <20021229235823.A12623@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	James Bottomley <James.Bottomley@steeleye.com>,
	linux-kernel@vger.kernel.org
References: <hch@lst.de> <200212292251.gBTMpim12460@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200212292251.gBTMpim12460@localhost.localdomain>; from James.Bottomley@steeleye.com on Sun, Dec 29, 2002 at 04:51:44PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 29, 2002 at 04:51:44PM -0600, James Bottomley wrote:
> hch@lst.de said:
> > I already wondered about that, but AFAIK a kernel with X86_NUMAQ set
> > still boots on a PeeCee, so it's really an option, not a choice.
> 
> It alters the mflags-y and mcore-y variables in arch/i386/Makefile, so it's 
> one of the subarch choices and thus should really be under the menu options.

Okay, does this patch look better?


--- 1.19/arch/i386/Kconfig	Sat Dec 28 23:18:10 2002
+++ edited/arch/i386/Kconfig	Sun Dec 29 23:10:14 2002
@@ -49,7 +49,7 @@
 
 config VOYAGER
 	bool "NCR Voyager Architecture"
-	---help---
+	help
 	  Voyager is a MCA based 32 way capable SMP architecture proprietary
 	  to NCR Corp.  Machine classes 345x/35xx/4100/51xx are voyager based.
 	  
@@ -58,9 +58,19 @@
 	  If you do not specifically know you have a Voyager based machine,
 	  say N here otherwise the kernel you build will not be bootable.
 
+config X86_NUMAQ
+	bool "IBM/Sequent NUMAQ"
+	help
+	  This option is used for getting Linux to run on a (IBM/Sequent) NUMA 
+	  multiquad box. This changes the way that processors are bootstrapped,
+	  and uses Clustered Logical APIC addressing mode instead of Flat Logical.
+	  You will need a new lynxer.elf file to flash your firmware with - send
+	  email to Martin.Bligh@us.ibm.com
+
 # Visual Workstation support is utterly broken.
 # If you want to see it working mail an VW540 to hch@infradead.org 8)
-#bool 'SGI Visual Workstation support' CONFIG_VISWS
+#config VISWS
+#	bool "SGI Visual Workstation support"
 
 endchoice
 
@@ -430,24 +440,8 @@
 	  This is purely to save memory - each supported CPU adds
 	  approximately eight kilobytes to the kernel image.
 
-config X86_NUMA
-	bool "Multi-node NUMA system support"
-	depends on SMP
-
-#Platform Choices
-config X86_NUMAQ
-	bool "Multiquad (IBM/Sequent) NUMAQ support"
-	depends on X86_NUMA
-	help
-	  This option is used for getting Linux to run on a (IBM/Sequent) NUMA 
-	  multiquad box. This changes the way that processors are bootstrapped,
-	  and uses Clustered Logical APIC addressing mode instead of Flat Logical.
-	  You will need a new lynxer.elf file to flash your firmware with - send
-	  email to Martin.Bligh@us.ibm.com
-
 config X86_SUMMIT
 	bool "IBM x440 (Summit/EXA) support"
-	depends on X86_NUMA
 	help
 	  This option is needed for IBM systems that use the Summit/EXA chipset.
 	  In particular, it is needed for the x440.
@@ -456,7 +450,7 @@
 
 config CLUSTERED_APIC
 	bool
-	depends on X86_NUMA && (X86_NUMAQ || X86_SUMMIT)
+	depends on X86_NUMAQ || X86_SUMMIT
 	default y
 
 # Common NUMA Features
