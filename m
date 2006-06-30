Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWF3UQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWF3UQs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 16:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbWF3UQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 16:16:48 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:18413 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750801AbWF3UQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 16:16:48 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-mm4
Date: Fri, 30 Jun 2006 22:16:53 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060629013643.4b47e8bd.akpm@osdl.org>
In-Reply-To: <20060629013643.4b47e8bd.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606302216.54056.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 June 2006 10:36, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm4/
> 
> 
> - The RAID patches have been dropped due to testing failures in -mm3.
> 
> - The SCSI Attached Storage tree (git-sas.patch) has been restored.

It doesn't compile for me on a non-SMP x86_64.  Appended is a patch that fixes
this (it only reverts one change between -mm3 and -mm4, though).

Greetings,
Rafael


 arch/i386/kernel/alternative.c |    6 ------
 1 files changed, 6 deletions(-)

Index: linux-2.6.17-mm4/arch/i386/kernel/alternative.c
===================================================================
--- linux-2.6.17-mm4.orig/arch/i386/kernel/alternative.c
+++ linux-2.6.17-mm4/arch/i386/kernel/alternative.c
@@ -168,7 +168,6 @@ void apply_alternatives(struct alt_instr
 	}
 }
 
-#ifdef CONFIG_SMP
 static void alternatives_smp_save(struct alt_instr *start, struct alt_instr *end)
 {
 	struct alt_instr *a;
@@ -338,8 +337,6 @@ void alternatives_smp_switch(int smp)
 	}
 	spin_unlock_irqrestore(&smp_alt, flags);
 }
-#endif
-
 
 void __init alternative_instructions(void)
 {
@@ -352,8 +349,6 @@ void __init alternative_instructions(voi
 	}
 	apply_alternatives(__alt_instructions, __alt_instructions_end);
 
-#ifdef CONFIG_SMP
-
 	/* switch to patch-once-at-boottime-only mode and free the
 	 * tables in case we know the number of CPUs will never ever
 	 * change */
@@ -385,5 +380,4 @@ void __init alternative_instructions(voi
 					    _text, _etext);
 		alternatives_smp_switch(0);
 	}
-#endif
 }
