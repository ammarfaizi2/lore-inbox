Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264316AbUEDP5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264316AbUEDP5u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 11:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbUEDP5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 11:57:50 -0400
Received: from aun.it.uu.se ([130.238.12.36]:61694 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264316AbUEDP5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 11:57:48 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16535.48497.41972.583857@alkaid.it.uu.se>
Date: Tue, 4 May 2004 17:57:37 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: John Levon <levon@movementarian.org>
Cc: linux-kernel@vger.kernel.org, oprofile-list@lists.sourceforge.net,
       torvalds@osdl.org
Subject: Re: [PATCH] allow drivers to claim the lapic NMI watchdog HW
In-Reply-To: <20040504110200.GA9880@compsoc.man.ac.uk>
References: <200405040233.i442X1GO025270@harpo.it.uu.se>
	<20040504110200.GA9880@compsoc.man.ac.uk>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon writes:
 > On Tue, May 04, 2004 at 04:33:01AM +0200, Mikael Pettersson wrote:
 > 
 > > +/* lapic_nmi_owner:
 > > + * +1: the lapic NMI hardware is assigned to the lapic NMI watchdog
 > > + *  0: the lapic NMI hardware is unassigned
 > 
 > If we're going to have a mini state machine, can't we at least use some
 > defines for each state...
 > 
 > > +		lapic_nmi_owner -= 2; /* +1 -> -1, 0 -> -2 */
 > 
 > ...and make this into some readable english via a little helper?

Thing is, using discrete states makes the code for the checks
and state changes more verbose. However, I can easily hide the
representation behind macros with understandable names.

 > > -EXPORT_SYMBOL(disable_lapic_nmi_watchdog);
 > > -EXPORT_SYMBOL(enable_lapic_nmi_watchdog);
 > > +EXPORT_SYMBOL(reassign_lapic_nmi_watchdog);
 > > +EXPORT_SYMBOL(release_lapic_nmi_watchdog);
 > 
 > I don't like this new naming. Since the patch is really all about
 > ownership of the local APIC, can't we call it something like
 > 
 > acquire_lapic_nmi()
 > release_lapic_nmi()

Yep, those are nicer names.

 > Neither perfctr nor oprofile have anything to do with watchdogs, so
 > this:
 > 
 > > -	disable_lapic_nmi_watchdog();
 > > +	if (reassign_lapic_nmi_watchdog() < 0) {
 > 
 > Looks a little weird now.

A little, yes.

I'll implement these changes this evening and post an updated patch tomorrow.

/Mikael
