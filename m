Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129590AbRCANWP>; Thu, 1 Mar 2001 08:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129583AbRCANWG>; Thu, 1 Mar 2001 08:22:06 -0500
Received: from zeus.kernel.org ([209.10.41.242]:55784 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129590AbRCANVt>;
	Thu, 1 Mar 2001 08:21:49 -0500
Date: Thu, 1 Mar 2001 14:04:15 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ingo Molnar <mingo@chiara.elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac7
In-Reply-To: <E14YHw1-0006x4-00@the-village.bc.nu>
Message-ID: <Pine.GSO.3.96.1010301131145.15979D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2001, Alan Cox wrote:

> o	Handle broken PIV MP tables with a NULL ioapic

 That's not a right fix.  We should make a check in MP_ioapic_info() and
do not register bogus I/O APICs (hmm, I wonder what the next thing to be
broken in MP-tables is...).  We should handle the no I/O APIC case around
setup_IO_APIC() then.  This would be similar to specifying "noapic"  in
the command line.  There is absolutely no need to disable SMP support if
there is no I/O APIC -- we don't insist on having it.  We are able to
route interrupts through 8259A controllers if needed (we'd better avoid it
if at all possible due to various chip errata, though).

 I'll implement the idea together with my pending APIC clean-ups. 

 We don't handle P4-compatible I/O APICs at the moment, anyway... 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

