Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbUCSUal (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 15:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbUCSUal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 15:30:41 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:39857 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261950AbUCSUaj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 15:30:39 -0500
Date: Fri, 19 Mar 2004 21:30:38 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Thomas Schlichter <thomas.schlichter@web.de>
Cc: Philippe Elie <phil.el@wanadoo.fr>, Andrew Morton <akpm@osdl.org>,
       Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.4-rc2] bogus semicolon behind if()
In-Reply-To: <200403192001.13129.thomas.schlichter@web.de>
Message-ID: <Pine.LNX.4.55.0403192116530.11965@jurand.ds.pg.gda.pl>
References: <200403090014.03282.thomas.schlichter@web.de>
 <200403091208.20556.thomas.schlichter@web.de> <Pine.LNX.4.55.0403171734090.14525@jurand.ds.pg.gda.pl>
 <200403192001.13129.thomas.schlichter@web.de>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2004, Thomas Schlichter wrote:

> Well, my timer interrupt goes through the IO-APIC but I do have a functional 
> TSC. Nevertheless my system requires timer_ack to be set... If it isn't, my 
> CPU does not utilize its C2 state...

 Hmm, I wonder if there's any relationship between the state of the local
APIC and your observation.  Can you please see if the following hack
changes anything (this assumes you have your timer IRQ directly connected
to an I/O APIC input)?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

--- io_apic.c.macro	2004-03-19 20:13:44.000000000 +0000
+++ io_apic.c	2004-03-19 20:15:23.000000000 +0000
@@ -1613,7 +1613,7 @@ static inline void check_timer(void)
 		timer_ack = 1;
 	else
 		timer_ack = !cpu_has_tsc;
-	enable_8259A_irq(0);
+	disable_8259A_irq(0);
 
 	pin1 = find_isa_irq_pin(0, mp_INT);
 	pin2 = find_isa_irq_pin(0, mp_ExtINT);
