Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbUCQRUa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 12:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbUCQRUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 12:20:30 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:2689 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261672AbUCQRU2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 12:20:28 -0500
Date: Wed, 17 Mar 2004 18:20:26 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Philippe Elie <phil.el@wanadoo.fr>,
       Thomas Schlichter <thomas.schlichter@web.de>
Cc: Andrew Morton <akpm@osdl.org>, Andreas Schwab <schwab@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.4-rc2] bogus semicolon behind if()
In-Reply-To: <20040310060804.GB2958@zaniah>
Message-ID: <Pine.LNX.4.55.0403171752040.14525@jurand.ds.pg.gda.pl>
References: <200403090014.03282.thomas.schlichter@web.de>
 <20040308162947.4d0b831a.akpm@osdl.org> <20040309070127.GA2958@zaniah>
 <200403091208.20556.thomas.schlichter@web.de> <20040310060804.GB2958@zaniah>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2004, Philippe Elie wrote:

> > As I wrote a few days ago I have problems with that ChangeSet,
> >   (http://marc.theaimsgroup.com/?l=linux-kernel&m=107840458123059&w=2)
> > so I did examine it closer.
> 
> errmm, http://tinyurl.com/2jbe4
> 
> Maciej, you wrote this patch, any comment ?

 Yep, that's a stupid typo, but the bug would only trigger for a system
that would have:

1. a discrete 82489DX APIC,

2. a functional TSC,

3. a timer interrupt working through the I/O APIC,

4. a working I/O APIC NMI watchdog.

Such systems used to actually exist, but you'd have a hard time trying to
find one.

 Here's an obvious update.  Thomas, thanks for spotting it.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-2.6.4-timer_ack-fix-0
diff -up --recursive --new-file linux-2.6.4.macro/arch/i386/kernel/io_apic.c linux-2.6.4/arch/i386/kernel/io_apic.c
--- linux-2.6.4.macro/arch/i386/kernel/io_apic.c	2004-03-17 17:09:29.000000000 +0000
+++ linux-2.6.4/arch/i386/kernel/io_apic.c	2004-03-17 17:11:07.000000000 +0000
@@ -2195,7 +2195,7 @@ static inline void check_timer(void)
 				disable_8259A_irq(0);
 				setup_nmi();
 				enable_8259A_irq(0);
-				if (check_nmi_watchdog() < 0);
+				if (check_nmi_watchdog() < 0)
 					timer_ack = !cpu_has_tsc;
 			}
 			return;
@@ -2219,7 +2219,7 @@ static inline void check_timer(void)
 				add_pin_to_irq(0, 0, pin2);
 			if (nmi_watchdog == NMI_IO_APIC) {
 				setup_nmi();
-				if (check_nmi_watchdog() < 0);
+				if (check_nmi_watchdog() < 0)
 					timer_ack = !cpu_has_tsc;
 			}
 			return;
