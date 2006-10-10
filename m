Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030234AbWJJTui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbWJJTui (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 15:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030239AbWJJTuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 15:50:37 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:19908 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030234AbWJJTuh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 15:50:37 -0400
Date: Tue, 10 Oct 2006 21:50:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Riss <frederic.riss@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, len.brown@intel.com
Subject: Re: 2.6.18 suspend regression on Intel Macs
Message-ID: <20061010195022.GA32134@elf.ucw.cz>
References: <1160417982.5142.45.camel@funkylaptop> <20061010103910.GD31598@elf.ucw.cz> <1160476889.3000.282.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0610100830370.3952@g5.osdl.org> <1160507296.5134.4.camel@funkylaptop> <1160509121.3000.327.camel@laptopd505.fenrus.org> <1160509584.5134.11.camel@funkylaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160509584.5134.11.camel@funkylaptop>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > So what's the plan? Should/Will the ACPI guys remove the bit-preserving
> > > change brought in with the latest ACPICA merge?
> > 
> > 
> > it sounds like a good idea to at least put the workaround back for now,
> > until a more elegant solution (maybe something can be done to make it
> > not needed anymore) is found...
> > (or until it shows it breaks other machines at which point
> > reconsideration is also needed)
> 
> The workaround hasn't been removed. It's still there,
> drivers/acpi/pci_link.c:
> 788 
> 789 /* Make sure SCI is enabled again (Apple firmware bug?) */
> 790 acpi_set_register(ACPI_BITREG_SCI_ENABLE, 1, ACPI_MTX_DO_NOT_LOCK);
> 791 
> 
> The thing is acpi_set_register doesn't permit anymore to write the SCI
> bit since the last ACPI merge. Or maybe you meant that the
> acpi_hw_register_write modifications should be reverted until a better
> solution is found?

Maybe you can just create a patch that modifies ACPI not to mask the
SCI bit? Reverting big chunk of ACPI code is likely not the right
solution.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
