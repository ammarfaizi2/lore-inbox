Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbTLJKAu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 05:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbTLJKAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 05:00:50 -0500
Received: from aun.it.uu.se ([130.238.12.36]:26567 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262960AbTLJKAt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 05:00:49 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16342.61127.717756.446723@alkaid.it.uu.se>
Date: Wed, 10 Dec 2003 11:00:39 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Jesse Allen <the3dfxdude@hotmail.com>
Cc: Ross Dickson <ross@datscreative.com.au>, linux-kernel@vger.kernel.org,
       AMartin@nvidia.com
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
In-Reply-To: <20031210033906.GA176@tesore.local>
References: <200312072312.01013.ross@datscreative.com.au>
	<20031210033906.GA176@tesore.local>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Allen writes:
 > --- linux/arch/i386/kernel/apic.c	2003-10-25 11:44:59.000000000 -0700
 > +++ linux-jla/arch/i386/kernel/apic.c	2003-12-09 19:07:19.000000000 -0700
 > @@ -1089,6 +1089,16 @@
 >  	 */
 >  	irq_stat[cpu].apic_timer_irqs++;
 >  
 > +#ifdef CONFIG_MK7 && CONFIG_BLK_DEV_AMD74XX
 > +
 > +	/*
 > +	 * on 2200XP & nforce2 chipset we need at least 500ns delay here
 > +	 * to stop lockups with udma100 drive. try to scale delay time
 > +	 * with cpu speed. Ross Dickson.
 > +	 */
 > +	ndelay((cpu_khz >> 12)+200 ); /* don't ack too soon or hard lockup */
 > +#endif
 > +
 >  	/*
 >  	 * NOTE! We'd better ACK the irq immediately,
 >  	 * because timer handling can be slow.

This is too much of a kludge. APIC timer ACKing is supposed to be fast.
Please try without this delay but with the disconnect PCI quirk.

If the delay is still needed even when disconnect is disabled, _then_
can discuss how to do the delay properly.

/Mikael
