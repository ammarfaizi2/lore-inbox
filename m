Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131776AbQKVABs>; Tue, 21 Nov 2000 19:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131790AbQKVABi>; Tue, 21 Nov 2000 19:01:38 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20563 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131776AbQKVAB1>; Tue, 21 Nov 2000 19:01:27 -0500
Subject: Re: Linux 2.4.0test11-ac1
To: macro@ds2.pg.gda.pl (Maciej W. Rozycki)
Date: Tue, 21 Nov 2000 23:31:20 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        johannes@erdfelt.com (Johannes Erdfelt),
        mingo@chiara.elte.hu (Ingo Molnar), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.3.96.1001121195742.28403E-100000@delta.ds2.pg.gda.pl> from "Maciej W. Rozycki" at Nov 21, 2000 08:08:43 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13yMsl-0005Lb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > MP table regardless of the capabilities of the CPU installed. Its apparently
> > legal to do so. There is an apic capability flag that should be tested before
>  It's not legal -- the MPS is very explicit the MP-table must reflect a
> real configuration. 

Intel tell me otherwise. The real world also disagrees which makes the
discussion a little pointless. We have to handle the real situation where
this occurs

> > making any assumptions about APIC availability on a processor.
> 
>  OK, but how does it handle the 82489DX?  There are valid configurations
> using this kind of APIC, including Pentium P54C ones...

These processors don't report the APIC on the cpuid ? If so then I guess
the fix is something like this

	if( cpuid says there is no local apic && vendor != intel)

Intel stuff appears to always be happy poking in APIC space. I don't know
if this is related to the chip internals on the non APIC capable chips.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
