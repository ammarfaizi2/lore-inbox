Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbRBGSA1>; Wed, 7 Feb 2001 13:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129439AbRBGSAS>; Wed, 7 Feb 2001 13:00:18 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:22676 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129057AbRBGSAF>; Wed, 7 Feb 2001 13:00:05 -0500
Date: Wed, 7 Feb 2001 18:55:26 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>, mingo@redhat.com,
        linux-kernel@vger.kernel.org, mikpe@csd.uu.se
Subject: Re: UP APIC reenabling vs. cpu type detection ordering
In-Reply-To: <3A817F68.1A5C4EC1@transmeta.com>
Message-ID: <Pine.GSO.3.96.1010207184159.1418E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Feb 2001, H. Peter Anvin wrote:

> Why is the test there in the first place?  If the machine has an APIC, it
> should be able to use it.  Presumably no other CPU uses the same MSR
> address (am I wrong?) for anything else -- if so, it should be able to
> poke it as long as the kernel intercepts the #GP(0) that may come if it
> is not enabled.  The Linux kernel has pretty sophisticated support for
> trapping faults.

 The point is whether it is safe to enable the local APIC that was
disabled by BIOS on an unknown CPU.  Probably yes, but who knows -- we
might need additional setup to be performed for interrupts to work. 

> In other words, I'd like to see a reason for making any vendor-specific
> determinations, and if so, they should ideally be centralized to the CPU
> feature-determination code.

 It would be hard to decide how to classify it.  It's something like "the
CPU has a local APIC that we know how to handle in the non-MPS system". 

 It might be viable just to delete the test altogether, though and just
trap #GP(0) on the MSR access.  For the sake of simplicity.  If a problem
with a system ever arizes, we may handle it then.

 Note that we still have to choose appropriate vendor-specific PeMo
handling and an event for the NMI watchdog anyway.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
