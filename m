Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130800AbQKVQhV>; Wed, 22 Nov 2000 11:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130316AbQKVQhA>; Wed, 22 Nov 2000 11:37:00 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:2466 "EHLO
        delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
        id <S131793AbQKVQgx>; Wed, 22 Nov 2000 11:36:53 -0500
Date: Wed, 22 Nov 2000 17:02:18 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Johannes Erdfelt <johannes@erdfelt.com>,
        Ingo Molnar <mingo@chiara.elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0test11-ac1
In-Reply-To: <E13yMsl-0005Lb-00@the-village.bc.nu>
Message-ID: <Pine.GSO.3.96.1001122164851.24845B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2000, Alan Cox wrote:

> >  It's not legal -- the MPS is very explicit the MP-table must reflect a
> > real configuration. 
> 
> Intel tell me otherwise. The real world also disagrees which makes the
> discussion a little pointless. We have to handle the real situation where
> this occurs

 Quoting from "MultiProcessor Specification" version 1.4, p. 5-2:

 "The default system configurations are designed to support dual-processor
systems with fixed configurations.  Systems with dynamically configurable
components, for example, a uniprocessor system with an upgrade socket for
the second processor, must always generate the MP configuration table. 
Failure to do so may cause the operating system to install the wrong
modules due to erroneous configuration information." 

 This will not fix the broken work, unfortunately...

> >  OK, but how does it handle the 82489DX?  There are valid configurations
> > using this kind of APIC, including Pentium P54C ones...
> 
> These processors don't report the APIC on the cpuid ? If so then I guess
> the fix is something like this

 No, they don't, as they have their on-chip APICs disabled by hardware.
Otherwise they wouldn't be able to utilize a discrete local APIC.

> Intel stuff appears to always be happy poking in APIC space. I don't know
> if this is related to the chip internals on the non APIC capable chips.

 It might be related to the chipset setup.  I wonder whether would it
crash on accessing another area of unoccupied space.  Hmm, after thinking
for I while I recall there exist an event that's called "PCI master abort" 
and that may happen when no device responds to a PCI cycle.  What chipset
do the affected systems use?  Is it HX or NX?  I have docs for both and I
may search for a possible cause.  Maybe we could fix it as a quirk... 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
