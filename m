Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129703AbQKVSaz>; Wed, 22 Nov 2000 13:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129777AbQKVSah>; Wed, 22 Nov 2000 13:30:37 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:5795 "EHLO
        delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
        id <S129248AbQKVSaV>; Wed, 22 Nov 2000 13:30:21 -0500
Date: Wed, 22 Nov 2000 18:49:29 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@chiara.elte.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0test11-ac1
In-Reply-To: <E13yd3V-0006BD-00@the-village.bc.nu>
Message-ID: <Pine.GSO.3.96.1001122175514.29041A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2000, Alan Cox wrote:

> I think it reports 1.1 apics from memory. Its simply hardcoded in the bios
> rather than the configurable flash area.

 So we might check for it.  Good!

> The following change should make all of this work
> 
> 	if(vendor!=INTEL && !has_apic)
> 		/* No SMP */

 And suddenly certain i486 systems do not work anymore?  Well, I haven't
actually heard of an i486 SMP system running Linux so far (maybe they just
work fine, so no reports).  But we could try the following, instead:

	if (boot_cpu_id != -1U
	    && APIC_INTEGRATED(apic_version[boot_cpu_id]) && !has_apic)
		/* No SMP */

It should filter broken MP-tables and work fine on all 82489DX-based
systems.  I'll have a patch soon if we agree on this solution.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
