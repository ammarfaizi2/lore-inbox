Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWAEBiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWAEBiS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 20:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbWAEBiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 20:38:18 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:35462 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751135AbWAEBiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 20:38:17 -0500
Date: Wed, 4 Jan 2006 20:41:26 -0500
From: Kurt Wall <kwall@kurtwerks.com>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Make apm buildable without legacy pm.
Message-ID: <20060105014126.GH5895@kurtwerks.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20060103143352.GA24937@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060103143352.GA24937@redhat.com>
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.15-rc6krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2006 at 09:33:52AM -0500, Dave Jones took 0 lines to write:
> APM doesn't _need_ the PM_LEGACY junk, so remove it's dependancy
> from Kconfig, and ifdef the junk in the code.
> Whilst the ifdefs are ugly, when the legacy stuff gets ripped out
> so will the ifdefs.
> 
> Signed-off-by: Dave Jones <davej@redhat.com>
> 
> --- linux-2.6.14/arch/i386/Kconfig~	2005-12-22 22:06:10.000000000 -0500
> +++ linux-2.6.14/arch/i386/Kconfig	2005-12-22 22:06:16.000000000 -0500
> @@ -710,7 +710,7 @@ depends on PM && !X86_VISWS
>  
>  config APM
>  	tristate "APM (Advanced Power Management) BIOS support"
> -	depends on PM && PM_LEGACY
> +	depends on PM
>  	---help---
>  	  APM is a BIOS specification for saving power using several different
>  	  techniques. This is mostly useful for battery powered laptops with

Here's this hunk re-diffed against 2.6.15 (which applies without
needing patch to apply an offset of -11 lines):

--- linux-2.6.15/arch/i386/Kconfig.orig	2006-01-04 20:33:43.000000000 -0500
+++ linux-2.6.15/arch/i386/Kconfig	2006-01-04 20:35:34.000000000 -0500
@@ -699,7 +699,7 @@
 
 config APM
 	tristate "APM (Advanced Power Management) BIOS support"
-	depends on PM && PM_LEGACY
+	depends on PM
 	---help---
 	  APM is a BIOS specification for saving power using several different
 	  techniques. This is mostly useful for battery powered laptops with

Kurt
-- 
If I traveled to the end of the rainbow
As Dame Fortune did intend,
Murphy would be there to tell me
The pot's at the other end.
		-- Bert Whitney
