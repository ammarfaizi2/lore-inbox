Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWDSCGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWDSCGO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 22:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWDSCGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 22:06:14 -0400
Received: from xenotime.net ([66.160.160.81]:10888 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750714AbWDSCGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 22:06:13 -0400
Date: Tue, 18 Apr 2006 19:08:39 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, bunk@stusta.de, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: [PATCH] [6/6] i386: Move CONFIG_DOUBLEFAULT into
 arch/i386 where it belongs.
Message-Id: <20060418190839.3fa53a0f.rdunlap@xenotime.net>
In-Reply-To: <200604182212.13835.ak@suse.de>
References: <4444C0EA.mailKK411J5GA@suse.de>
	<20060418190528.GL11582@stusta.de>
	<200604182212.13835.ak@suse.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2006 22:12:13 +0200 Andi Kleen wrote:

> On Tuesday 18 April 2006 21:05, Adrian Bunk wrote:
> > On Tue, Apr 18, 2006 at 12:35:22PM +0200, Andi Kleen wrote:
> > > 
> > > Signed-off-by: Andi Kleen <ak@suse.de>
> > >...
> > 
> > NAK.
> >  submitting a patch that is the revert of a patch that went 
> > into Linus' tree just 8 days ago [1], I'd expect at least:
> > - a Cc to the people involved with the patch you are reverting
> > - a note that you are reverting a recent patch in your patch
> >   description
> > - an explanation why you disagree with the patch you are reverting
> 
> The subject was very clear. i386 options belong into arch/i386.

Yes, the timing could have been better.  Whatever.

I agree with Andi that it should be moved back to the ix86 Processor
menu, but not where he moved it to.  My patch is below.

> -Andi (who actually thinks the whole thing was always a bad idea - saving
> a few K but giving up such debugging is a poor trade off)

It does default to Y and can only be changed if EMBEDDED is enabled.
I don't think that it really should be in the Kernel hacking menu.

---

From: Randy Dunlap <rdunlap@xenotime.net>

Put DOUBLEFAULT option back in the i386 Processor menu, but
not at the very top of it like it was originally, where it
was out of place in the menu structure.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 arch/i386/Kconfig |    9 +++++++++
 init/Kconfig      |    9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

--- linux-2617-rc1g12.orig/arch/i386/Kconfig
+++ linux-2617-rc1g12/arch/i386/Kconfig
@@ -282,6 +282,15 @@ config X86_VISWS_APIC
 	depends on X86_VISWS
 	default y
 
+config DOUBLEFAULT
+	default y
+	bool "Enable doublefault exception handler" if EMBEDDED
+	help
+          This option allows trapping of rare doublefault exceptions that
+          would otherwise cause a system to silently reboot. Disabling this
+          option saves about 4k and might cause you much additional grey
+          hair.
+
 config X86_MCE
 	bool "Machine Check Exception"
 	depends on !X86_VOYAGER
--- linux-2617-rc1g12.orig/init/Kconfig
+++ linux-2617-rc1g12/init/Kconfig
@@ -374,15 +374,6 @@ config SLAB
 	  SLOB is more space efficient but does not scale well and is
 	  more susceptible to fragmentation.
 
-config DOUBLEFAULT
-	default y
-	bool "Enable doublefault exception handler" if EMBEDDED && X86_32
-	help
-          This option allows trapping of rare doublefault exceptions that
-          would otherwise cause a system to silently reboot. Disabling this
-          option saves about 4k and might cause you much additional grey
-          hair.
-
 endmenu		# General setup
 
 config TINY_SHMEM

---
