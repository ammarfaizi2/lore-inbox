Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129088AbQKBSfE>; Thu, 2 Nov 2000 13:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129099AbQKBSey>; Thu, 2 Nov 2000 13:34:54 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:36798 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129088AbQKBSei>; Thu, 2 Nov 2000 13:34:38 -0500
Date: Thu, 2 Nov 2000 19:23:41 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ulrich Drepper <drepper@cygnus.com>
cc: root@chaos.analogic.com, kernel@kvack.org,
        "Dr. David Gilbert" <dg@px.uk.com>, linux-kernel@vger.kernel.org
Subject: Re: Dual XEON - >>SLOW<< on SMP
In-Reply-To: <m3bsvy2qlb.fsf@otr.mynet.cygnus.com>
Message-ID: <Pine.GSO.3.96.1001102191400.23267A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 Nov 2000, Ulrich Drepper wrote:

> I'm seeing this as well, but only with PIII Xeon systems, not PII
> Xeon.  Every single timer interrupt on any CPU is accompanied by a NMI
> and LOC increment on every CPU.
> 
>            CPU0       CPU1       
>   0:     146727     153389    IO-APIC-edge  timer

 This is the legacy 8254 timer source, used for the system time, i.e. 
gettimeofday() and friends. 

> NMI:     300035     300035 

 This is the NMI watchdog at work.  Every tick of the legacy timer all
CPUs receive an NMI unless overridden by the "nmi_watchdog" command line
argument. 

> LOC:     300028     300028 

 This is the internal local APIC timer used for scheduling.  Every CPU is
equipped with such a private timer.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
