Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312401AbSDXRZi>; Wed, 24 Apr 2002 13:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312418AbSDXRZh>; Wed, 24 Apr 2002 13:25:37 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:47599 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S312401AbSDXRZh>; Wed, 24 Apr 2002 13:25:37 -0400
Date: Wed, 24 Apr 2002 19:25:39 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Andi Kleen <ak@suse.de>
cc: george anzinger <george@mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Why HZ on i386 is 100 ?
In-Reply-To: <20020423213559.A24389@wotan.suse.de>
Message-ID: <Pine.GSO.3.96.1020424191233.23744A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2002, Andi Kleen wrote:

> That's the local APIC timer. Pretty much all modern x86 have it.
> But at least microsoft warns from using them for high precision 
> tim ekeeping on their mmtimer page "due to inaccuracy and 
> frequent silicon bugs" (and I guess they have the data for that) 

 That's nothing new -- I recall a problem of missing half a tick each
time when hardware reloads the timer after reaching zero with certain
revisions of Pentium CPUs.  It is documented in the specification update.

> The linux local APIC timer setup could be probably also improved, for 
> example the 16 multiplier is a bit dubious and the calibration does not
> look very robust.

 When fiddling with the predivider, please keep in mind the i82489DX only
supports 2, 4, 8 and 16 as dividers and you may set up 1 (i.e. no
division) but in a different way -- by setting LVTT appropriately (use
SET_APIC_TIMER_BASE(APIC_TIMER_BASE_CLKIN)).

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

