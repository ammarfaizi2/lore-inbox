Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264562AbUE0O1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264562AbUE0O1F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 10:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264578AbUE0O1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 10:27:04 -0400
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:40338 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S264562AbUE0O0l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 10:26:41 -0400
Date: Thu, 27 May 2004 16:26:40 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ingo Molnar <mingo@elte.hu>
Cc: Ingo Molnar <mingo@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: Cleanups for APIC
In-Reply-To: <20040527141404.GA23566@elte.hu>
Message-ID: <Pine.LNX.4.55.0405271614490.10917@jurand.ds.pg.gda.pl>
References: <20040525124937.GA13347@elf.ucw.cz>
 <Pine.LNX.4.58.0405270856120.28319@devserv.devel.redhat.com>
 <Pine.LNX.4.55.0405271525140.10917@jurand.ds.pg.gda.pl>
 <Pine.LNX.4.58.0405270931040.28319@devserv.devel.redhat.com>
 <Pine.LNX.4.55.0405271542080.10917@jurand.ds.pg.gda.pl> <20040527141404.GA23566@elte.hu>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2004, Ingo Molnar wrote:

> >  The I/O APIC need not be hooked to PCI ;-) -- I'm not sure about the
> > i82093AA, but that's definitely true for the i82489DX.  The call to
> > io_apic_sync() is needed for masking to make sure interrupts won't be
> > dispatched after returning from the call -- this is not needed for
> > unmasking as a delay here is harmless.
> 
> well, an APIC message could be on the way to the CPU even with this
> synchronization. Does it matter whether it's a newly dispatched one due
> to POST delays or an in-fly one due to APIC bus delays?

 Well, if you'd mask, sync, ack (send EOI) in a handler, then the sync
would assure the ack wouldn't be in effect before masking, so no further
interrupt would arrive till unmasking.  It would work for level-triggered
interrupts and the i82093AA, but OTOH for the i82489DX, which uses
level-deassert messages, it wouldn't.

 Too much hassle for an unreliable result...  Just scrap it.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
