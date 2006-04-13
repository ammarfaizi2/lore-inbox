Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWDMRLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWDMRLr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 13:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWDMRLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 13:11:47 -0400
Received: from ns2.suse.de ([195.135.220.15]:39336 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932125AbWDMRLq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 13:11:46 -0400
To: "Jan Beulich" <jbeulich@novell.com>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org, tom.l.nguyen@intel.com
Subject: Re: [i386, x86-64] ioapic_register_intr() and assign_irq_vector() questions
References: <443E734F.76E4.0078.0@novell.com>
From: Andi Kleen <ak@suse.de>
Date: 13 Apr 2006 19:11:42 +0200
In-Reply-To: <443E734F.76E4.0078.0@novell.com>
Message-ID: <p73wtdt2yep.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jan Beulich" <jbeulich@novell.com> writes:

> Since ioapic_register_intr() ties, for the PCI case, the interrupt
> gate for vector to interrupt[vector], doesn't this, since do_IRQ()
> derives the IRQ from the value loaded in the handler at that address
> (which is the value of vector), mean that here irq == vector in all
> cases? If so, why does this function need an if/else (the 'else'
> case would then be good for both cases)?

Yes agreed. irq should be always equal vector. IIRC this 
stems from the MSI work from Tom Nguyen. Maybe he knows
why he coded it like this. I suppose it could be cleaned up.

> 
> Looking at the call paths assign_irq_vector() can get called from, I
> would think this function, namely as it's using static variables,
> lacks synchronization - is there any (hidden) reason this is not
> needed here?

It is only called during system initialization which is single threaded. 
If someone added ioapic hotplug they would need to do something about 
this.

-Andi
