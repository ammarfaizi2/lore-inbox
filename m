Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264515AbTLGUrI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 15:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264516AbTLGUrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 15:47:08 -0500
Received: from fed1mtao03.cox.net ([68.6.19.242]:35506 "EHLO
	fed1mtao03.cox.net") by vger.kernel.org with ESMTP id S264515AbTLGUrF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 15:47:05 -0500
Date: Sun, 7 Dec 2003 13:59:06 -0700
From: Jesse Allen <the3dfxdude@hotmail.com>
To: Ian Kumlien <pomac@vapor.com>
Cc: AMartin@nvidia.com, ross@datscreative.com.au, linux-kernel@vger.kernel.org
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
Message-ID: <20031207205906.GA425@tesore.local>
References: <1070827127.1991.16.camel@big.pomac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1070827127.1991.16.camel@big.pomac.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 07, 2003 at 08:58:47PM +0100, Ian Kumlien wrote:
> > There are three parts to this email.
> > a) apic mods.
> > Lockups are due to too fast an apic acknowledge of apic timer int.
> > Apic hard locked up the system - no nmi debug available.
> > Fixed it by introducing a delay of at least 500ns into 
> > smp_apic_timer_interrupt() just prior to ack_APIC_irq().
> > b) io-apic mods
> > So I have fixed it too (tested on both my epox and albatron MOBOs).
> > Firstly I found 8254 connected directly to pin 0 not pin 2 of io-apic.
> > I have modified check_timer() in io_apic.c to trial connect pin and 
> > test for it after the existing test for connection to io-apic.
> 


So do you think Ross has found the connection between all three issues?  (Timer and NMI watchdog, IRQ 7, and CPU disconnect?)

I suppose we should now try these changes other the last two.  From what he's saying, this will fix the lockup too.  Hopefully the patch will be refined =).  I probably won't be able to run this till tomorrow, and after I get it diffed for 2.6.  I've barely got the cpu disconnect patch going today, but haven't tested it because I can only access my nforce2 machine remotely =).  But from everything I'm hearing, the lockups are gone.

Jesse

