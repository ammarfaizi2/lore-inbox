Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161039AbWBTRIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161039AbWBTRIa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 12:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161048AbWBTRIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 12:08:30 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:39177 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161039AbWBTRI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 12:08:29 -0500
Date: Mon, 20 Feb 2006 18:08:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] some fixups for the X86_NUMAQ dependencies
Message-ID: <20060220170827.GD4661@stusta.de>
References: <20060219232621.GC4971@stusta.de> <43F9EF43.3020709@mbligh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F9EF43.3020709@mbligh.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 08:33:07AM -0800, Martin J. Bligh wrote:
> Adrian Bunk wrote:
> >You must always ensure to fulfill the dependencies of what you are 
> >select'ing.
> >
> >
> >Signed-off-by: Adrian Bunk <bunk@stusta.de>
> >
> >---
> >
> > arch/i386/Kconfig |    7 +++----
> > 1 file changed, 3 insertions(+), 4 deletions(-)
> >
> >--- linux-2.6.16-rc3-mm1-full/arch/i386/Kconfig.old	2006-02-20 
> >00:12:50.000000000 +0100
> >+++ linux-2.6.16-rc3-mm1-full/arch/i386/Kconfig	2006-02-20 
> >00:17:57.000000000 +0100
> >@@ -84,6 +84,7 @@
> > 
> > config X86_NUMAQ
> > 	bool "NUMAQ (IBM/Sequent)"
> >+	select SMP
> > 	select NUMA
> > 	help
> > 	  This option is used for getting Linux to run on a (IBM/Sequent) 
> > 	  NUMA
> >@@ -419,6 +420,7 @@
> 
> Surely NUMA should select SMP, not NUMA-Q?


NUMA depends on SMP.

Therefore, if you select NUMA, you have to ensure that SMP is enabled.


> > config NOHIGHMEM
> > 	bool "off"
> >+	depends on !X86_NUMAQ
> > 	---help---
> > 	  Linux can use up to 64 Gigabytes of physical memory on x86 systems.
> > 	  However, the address space of 32-bit x86 processors is only 4
> >@@ -455,6 +457,7 @@
> > 
> > config HIGHMEM4G
> > 	bool "4GB"
> >+	depends on !X86_NUMAQ
> > 	help
> > 	  Select this if you have a 32-bit processor and between 1 and 4
> > 	  gigabytes of physical RAM.
> >@@ -522,10 +525,6 @@
> > 	default n if X86_PC
> > 	default y if (X86_NUMAQ || X86_SUMMIT)
> > 
> >-# Need comments to help the hapless user trying to turn on NUMA support
> >-comment "NUMA (NUMA-Q) requires SMP, 64GB highmem support"
> >-	depends on X86_NUMAQ && (!HIGHMEM64G || !SMP)
> >-
> 
> Hmm. ISTR the reason we put that in there in the first place was that
> NUMA-Q got mysteriously hidden by other deps before, and it wasn't clear 
> how to select it. Perhaps we just had some of the deps backwards.


NUMAQ can't be hidden since it doesn't has any dependencies.
And this isn't what this comment is talking about (note the the 
comment is only shown if NUMAQ was already select'ed).

NUMAQ didn't fulfill the contract that when select'ing NUMA, it has to 
ensure the dependencies of NUMA are fulfilled. My patch solves this 
properly instead of telling the user through a comment that he ran into 
this bug.


> M.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

