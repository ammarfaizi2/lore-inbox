Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRACXNI>; Wed, 3 Jan 2001 18:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131904AbRACXM6>; Wed, 3 Jan 2001 18:12:58 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:38149 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S131806AbRACXMv>; Wed, 3 Jan 2001 18:12:51 -0500
Message-ID: <3A53B356.32353C01@uow.edu.au>
Date: Thu, 04 Jan 2001 10:18:46 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: mzyngier@freesurf.fr
CC: linux-kernel@vger.kernel.org, linux-irda@pasta.cs.UiT.No
Subject: Re: [IrDA+SMP] Lockup in handle_IRQ_event
In-Reply-To: <wrpzoh89t1c.fsf@hina.wild-wind.fr.eu.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc ZYNGIER wrote:
> 
> Hi all,
> 
> Having just started playing with IrDA on my dual celeron (Abit "APIC
> error..." BP6), I managed to kill it every single time (NMI watchdog
> in handle_IRQ_event) while connecting to my mobile phone (in fact,
> when closing the connection to the phone. even 'cat /dev/ircomm0' will
> do...). This is perfectly repeatable.
> 

Try this:

--- linux-2.4.0-prerelease/net/irda/irqueue.c	Tue Nov 21 20:11:22 2000
+++ linux-akpm/net/irda/irqueue.c	Thu Jan  4 10:14:10 2001
@@ -436,7 +436,7 @@
 
 	/* Release lock */
 	if ( hashbin->hb_type & HB_GLOBAL) {
-		spin_unlock_irq( &hashbin->hb_mutex[ bin]);
+		spin_unlock_irqrestore( &hashbin->hb_mutex[ bin], flags);
 
 	} else if ( hashbin->hb_type & HB_LOCAL) {
 		restore_flags( flags);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
