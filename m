Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265547AbTFRVph (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 17:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265550AbTFRVph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 17:45:37 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:34060 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S265547AbTFRVpg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 17:45:36 -0400
Date: Wed, 18 Jun 2003 22:59:33 +0100
From: John Levon <levon@movementarian.org>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] OProfile: IO-APIC fixup
Message-ID: <20030618215933.GA35128@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19Skxp-000LWc-C0*LsuVU9KrbxI*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Follow-on patch to the NMI timer patch, from Zwane Mwaikambo. Please
apply.

regards,
john

p.s. can/should we use torvalds@osdl.org already ?

diff -Naur -X dontdiff linux-cvs/arch/i386/kernel/nmi.c linux-fixes/arch/i386/kernel/nmi.c
--- linux-cvs/arch/i386/kernel/nmi.c	2003-06-18 15:06:05.000000000 +0100
+++ linux-fixes/arch/i386/kernel/nmi.c	2003-06-18 23:09:49.000000000 +0100
@@ -189,7 +189,6 @@
 	if ((nmi_watchdog != NMI_IO_APIC) || (nmi_active <= 0))
 		return;
 
-	disable_irq(0);
 	unset_nmi_callback();
 	nmi_active = -1;
 	nmi_watchdog = NMI_NONE;
@@ -201,7 +200,6 @@
 		nmi_watchdog = NMI_IO_APIC;
 		touch_nmi_watchdog();
 		nmi_active = 1;
-		enable_irq(0);
 	}
 }
 
