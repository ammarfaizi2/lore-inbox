Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264443AbUE0ODg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbUE0ODg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 10:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbUE0ODg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 10:03:36 -0400
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:13453 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S264443AbUE0ODd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 10:03:33 -0400
Date: Thu, 27 May 2004 16:03:32 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ingo Molnar <mingo@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, mingo@elte.hu
Subject: Re: Cleanups for APIC
In-Reply-To: <Pine.LNX.4.58.0405270931040.28319@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.55.0405271542080.10917@jurand.ds.pg.gda.pl>
References: <20040525124937.GA13347@elf.ucw.cz>
 <Pine.LNX.4.58.0405270856120.28319@devserv.devel.redhat.com>
 <Pine.LNX.4.55.0405271525140.10917@jurand.ds.pg.gda.pl>
 <Pine.LNX.4.58.0405270931040.28319@devserv.devel.redhat.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2004, Ingo Molnar wrote:

> > Hmm, isn't that needed to make sure the iomem writeback is completed
> > before exiting the caller?
> 
> the only thing that could happen is a POST delay in the PCI chipset - but
> is that really an issue? Plus we only do the io_apic_sync() for the
> masking, not the unmasking - so if it's needed then we dont do it
> consistently.

 The I/O APIC need not be hooked to PCI ;-) -- I'm not sure about the
i82093AA, but that's definitely true for the i82489DX.  The call to
io_apic_sync() is needed for masking to make sure interrupts won't be
dispatched after returning from the call -- this is not needed for
unmasking as a delay here is harmless.

 Though, now that we don't mask APIC interrupts during their service
anymore the synchronization may be superfluous indeed -- other cases have
to take late interrupts into account anyway.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
