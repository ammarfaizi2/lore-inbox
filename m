Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264311AbUEDLCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264311AbUEDLCF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 07:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264312AbUEDLCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 07:02:05 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:1810 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S264311AbUEDLCC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 07:02:02 -0400
Date: Tue, 4 May 2004 12:02:01 +0100
From: John Levon <levon@movementarian.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, oprofile-list@lists.sourceforge.net,
       torvalds@osdl.org
Subject: Re: [PATCH] allow drivers to claim the lapic NMI watchdog HW
Message-ID: <20040504110200.GA9880@compsoc.man.ac.uk>
References: <200405040233.i442X1GO025270@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405040233.i442X1GO025270@harpo.it.uu.se>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1BKxgX-000AEO-DQ*yygCpQQOJxs*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2004 at 04:33:01AM +0200, Mikael Pettersson wrote:

> +/* lapic_nmi_owner:
> + * +1: the lapic NMI hardware is assigned to the lapic NMI watchdog
> + *  0: the lapic NMI hardware is unassigned

If we're going to have a mini state machine, can't we at least use some
defines for each state...

> +		lapic_nmi_owner -= 2; /* +1 -> -1, 0 -> -2 */

...and make this into some readable english via a little helper?

> -EXPORT_SYMBOL(disable_lapic_nmi_watchdog);
> -EXPORT_SYMBOL(enable_lapic_nmi_watchdog);
> +EXPORT_SYMBOL(reassign_lapic_nmi_watchdog);
> +EXPORT_SYMBOL(release_lapic_nmi_watchdog);

I don't like this new naming. Since the patch is really all about
ownership of the local APIC, can't we call it something like

acquire_lapic_nmi()
release_lapic_nmi()

Neither perfctr nor oprofile have anything to do with watchdogs, so
this:

> -	disable_lapic_nmi_watchdog();
> +	if (reassign_lapic_nmi_watchdog() < 0) {

Looks a little weird now.

regards
john
