Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbUCJQU7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 11:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbUCJQU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 11:20:59 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:8133 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262680AbUCJQUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 11:20:55 -0500
Date: Wed, 10 Mar 2004 11:20:53 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Philippe Elie <phil.el@wanadoo.fr>
Cc: Thomas Schlichter <thomas.schlichter@web.de>,
       Andrew Morton <akpm@osdl.org>, Andreas Schwab <schwab@suse.de>,
       linux-kernel@vger.kernel.org, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: [2.6.4-rc2] bogus semicolon behind if()
In-Reply-To: <20040310060804.GB2958@zaniah>
Message-ID: <Pine.LNX.4.58.0403101054270.29087@montezuma.fsmlabs.com>
References: <200403090014.03282.thomas.schlichter@web.de>
 <20040308162947.4d0b831a.akpm@osdl.org> <20040309070127.GA2958@zaniah>
 <200403091208.20556.thomas.schlichter@web.de> <20040310060804.GB2958@zaniah>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2004, Philippe Elie wrote:

> > 1. The semicolons behind the if()'s cannot be there intentionally.
> > 2. To fix my problem, timer_ack must be set to 1 for my (integrated) APIC, and
> > as my CPU has a TSC, this cannot be correct for me:
> > -	timer_ack = 1;
> > +	if (nmi_watchdog == NMI_IO_APIC && !APIC_INTEGRATED(ver))
> > +		timer_ack = 1;
> > +	else
> > +		timer_ack = !cpu_has_tsc;
>
> I don't get the figure, this code in check_timer() is called by
> setup_IO_APIC so APIC_INTEGRATED(ver) is always 0 ?

Nope, that will catch the older external "local" APICs like the 82489s (P5
etc), most IOAPICs will return 0x11 or higher for version#
