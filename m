Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293549AbSCCLBq>; Sun, 3 Mar 2002 06:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293552AbSCCLBi>; Sun, 3 Mar 2002 06:01:38 -0500
Received: from gold.MUSKOKA.COM ([216.123.107.5]:35079 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S293549AbSCCLBW>;
	Sun, 3 Mar 2002 06:01:22 -0500
Message-ID: <3C820188.5A4F095C@yahoo.com>
Date: Sun, 03 Mar 2002 05:57:12 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
To: marcelo@conectiva.com.br
CC: alan@lxorguk.ukuu.org.uk, davej@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bluesmoke/MCE support optional
In-Reply-To: <20020301024710.GF2711@matchmail.com> <E16gmBy-0003V5-00@the-village.bc.nu> <20020301135547.F7662@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> 
> On Fri, Mar 01, 2002 at 12:31:18PM +0000, Alan Cox wrote:
>  >
>  > Its not necessary to say N. On a pentium box with the newer MCE setup code
>  > you must force MCE on. On non MCE capable CPU's we just dont set it up.
> 
>  The help text should probably document the nomce boot option too.

This clarifies the P5 behaviour and documents the related boot arguments, 
as suggested by Alan and Dave J. respectively.

Patch against 2.4.19p2.

Paul.

--- Documentation/Configure.help~	Sun Mar  3 05:04:18 2002
+++ Documentation/Configure.help	Sun Mar  3 05:56:49 2002
@@ -17666,8 +17666,12 @@
   ranging from a warning message on the console, to halting the machine.
   Your processor must be a Pentium or newer to support this - check the 
   flags in /proc/cpuinfo for mce.  Note that some older Pentium systems
-  have a design flaw which leads to false MCE events - for these and
-  old non-MCE processors (386, 486), say N.  Otherwise say Y.
+  have a design flaw which leads to false MCE events - hence MCE is
+  disabled on all P5 processors, unless explicitly enabled with "mce"
+  as a boot argument.  Similarly, if MCE is built in and creates a
+  problem on some new non-standard machine, you can boot with "nomce" 
+  to disable it.  MCE support simply ignores non-MCE processors like
+  the 386 and 486, so nearly everyone can say Y here.
 
 Toshiba Laptop support
 CONFIG_TOSHIBA


