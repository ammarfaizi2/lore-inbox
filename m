Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287449AbSAURBy>; Mon, 21 Jan 2002 12:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287425AbSAURBo>; Mon, 21 Jan 2002 12:01:44 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:55209 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S287464AbSAURBc>; Mon, 21 Jan 2002 12:01:32 -0500
Date: Mon, 21 Jan 2002 17:57:05 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: James Cleverdon <jamesclv@us.ibm.com>
cc: Peter Monta <pmonta@pmonta.com>, linux-kernel@vger.kernel.org
Subject: Re: APIC errors, Asus A7M266-D (760MPX chipset)
In-Reply-To: <200201211637.g0LGbCq07602@butler1.beaverton.ibm.com>
Message-ID: <Pine.GSO.3.96.1020121174759.26201A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2002, James Cleverdon wrote:

> BTW, be aware that Intel has changed the way the ESR works.  The P6 manual 
> says that software must do two back-to-back writes to clear ESR bits.  The 
> most recent P4s say that a read clears bits and writes are ignored, save for 
> the requirement of a write before the read to get the ESR up to date.  AFAIK, 
> Intel's Linux gang hasn't posted any patches to fix smp_error_interrupt() for 
> P4s.  I've been meaning to do that myself....

 Have you verified this empirically?  AFAIK, the intended way for the ESR
to work is to update upon write and clear upon read.  Now there are
various errata within specific implementations, but our code seems immune
to them (except from the Pentium case we handle explicitly), i.e. the
ESR's value as fetched by the handler is correct.  The value outside the
handler may be meaningless, but who cares?

> > Oddly, booting this same kernel with the "noapic" option results in
> > the same problem, but recompiling with all APIC options disabled
> > gives a successful boot.
> 
> Sounds like the APIC was up to something anyway....

 The "noapic" option only affects I/O APICs.  Local APICs get programmed
anyway.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

