Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129696AbRBHLfB>; Thu, 8 Feb 2001 06:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129919AbRBHLev>; Thu, 8 Feb 2001 06:34:51 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:24070 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129696AbRBHLeg>;
	Thu, 8 Feb 2001 06:34:36 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Mikael Pettersson <mikpe@csd.uu.se>
Date: Thu, 8 Feb 2001 12:32:01 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] Re: UP APIC reenabling vs. cpu type detection o
CC: linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@transmeta.com,
        marco@ds2.pg.gda.pl
X-mailer: Pegasus Mail v3.40
Message-ID: <14E3B9B878C2@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  8 Feb 01 at 6:04, Mikael Pettersson wrote:

> ordering and offsets in processor.h and head.S. The resulting
> kernel works ok on my UP P6.
> (Petr: can you check that it still works on your K7?)

I'll try.

I have another question for UP APIC NMI: As I reported some time ago,
if performance counters overflow when LVTPC has 'disabled' bit set,
NMI is lost forever. This causes problems with VMware - it has to
disable NMI deliveries during CR3 (memory mapping) switching, and if 
performance counter overflows at that time, you'll not receive another 
NMI for couple of days on K7 (4.1 * 65536 seconds on fully loaded 1GHz 
Athlon. And 410 * 65536 seconds on idle Athlon)...

So it came to my mind - why (on K7 we easy can, as counter has 48 bits)
we do not reload NMI watchdog in each timer interrupt with 5sec timeout,
and if we receive even one NMI, we are locked up? It should increase
performance, as we'll do same number of MSR writes anyway (100/s), but
we will not receive any NMI during normal operation, so we save time
spent in processing this. Or do I miss something?

It may be problem on P6, as it has only 32bit perfctrs, so we are limited
to 4.1s watchdog timeout on 1GHz PIII :-(
                                    Thanks,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
