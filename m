Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261515AbTCOVfN>; Sat, 15 Mar 2003 16:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261567AbTCOVfM>; Sat, 15 Mar 2003 16:35:12 -0500
Received: from pasky.ji.cz ([62.44.12.54]:61690 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S261515AbTCOVfL>;
	Sat, 15 Mar 2003 16:35:11 -0500
Date: Sat, 15 Mar 2003 22:45:58 +0100
From: Petr Baudis <pasky@ucw.cz>
To: Dave Jones <davej@codemonkey.org.uk>, alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][kconfig][i386] Fix help entry for processor type choice
Message-ID: <20030315214558.GE31875@pasky.ji.cz>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>, alan@redhat.com,
	linux-kernel@vger.kernel.org
References: <20030315204009.GB31875@pasky.ji.cz> <20030315221259.GA26890@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030315221259.GA26890@suse.de>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Sat, Mar 15, 2003 at 11:13:06PM CET, I got a letter,
where Dave Jones <davej@codemonkey.org.uk> told me, that...
> On Sat, Mar 15, 2003 at 09:40:09PM +0100, Petr Baudis wrote:
> 
>  >  	bool "486"
>  >  	help
>  > -	  Select this for a x486 processor, ether Intel or one of the
>  > +	  Select this for an x486 processor, either Intel or one of the
> 
> This bit is broken. There is no x486 processor, it should be either
> 'i486', '80486' or just '486'. There's already a patch fixing up this
> (and x586 x686 etc) in Alans 2.5-ac patchset.

Ok, the new version follows, thanks. It does s/an x386/386 series/ and removes
the x486 line typo fixes, which are redundant for -ac (which is where this will
probably end up anyway).

-- 
 
				Petr "Pasky" Baudis
.
The pure and simple truth is rarely pure and never simple.
		-- Oscar Wilde
.
Stuff: http://pasky.ji.cz/

--- linux+pasky/arch/i386/Kconfig	Thu Mar  6 20:38:49 2003
+++ linux/arch/i386/Kconfig	Sat Mar 15 21:34:16 2003
@@ -110,10 +110,7 @@
 choice
 	prompt "Processor family"
 	default M686
-
-config M386
-	bool "386"
-	---help---
+	help
 	  This is the processor type of your CPU. This information is used for
 	  optimizing purposes. In order to compile a kernel that can run on
 	  all x86 CPU types (albeit not optimally fast), you can specify
@@ -148,6 +145,16 @@
 
 	  If you don't know what to do, choose "386".
 
+config M386
+	bool "386"
+	help
+	  Select this for a 386 series processor, that is AMD/Cyrix/Intel
+	  386DX/DXL/SL/SLC/SX, Cyrix/TI 486DLC/DLC2, UMC 486SX-S and NexGen
+	  Nx586. Kernel compiled for this processor will also run on any newer
+	  processor of this architecture, although not optimally fast.
+
+	  If you don't know what processor to choose, choose this one.
+
 config M486
 	bool "486"
 	help
