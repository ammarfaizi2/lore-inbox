Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130272AbQLPQDK>; Sat, 16 Dec 2000 11:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131150AbQLPQDB>; Sat, 16 Dec 2000 11:03:01 -0500
Received: from capitanata.ca.astro.it ([192.167.8.254]:5636 "EHLO
	capitanata.ca.astro.it") by vger.kernel.org with ESMTP
	id <S130272AbQLPQCr>; Sat, 16 Dec 2000 11:02:47 -0500
Date: Sat, 16 Dec 2000 17:32:04 +0100 (CET)
From: Giacomo Mulas <gmulas@ca.astro.it>
To: linux-kernel@vger.kernel.org
Subject: a single fragmented IP packet kills the 2.4.0-t12 kernel
Message-ID: <Pine.LNX.4.21.0012161717220.1211-100000@capitanata.ca.astro.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	It seems that a bad bug (in the netfilter code?) was exposed by
the changes from 2.4.0-t11 to t12. If a box has the ip_tables and
ip_conntrack modules loaded, sending it a single fragmented IP packet
(e.g. with "ping -s 65000") is enough to immediately freeze it. It does
not respond to the keyboard, does not write the oops(es) to disk... Some
people initially stumbled upon this when trying to use nfs, probably
because nfs uses large packets and therefore produces fragmented packets.
I also tried reverting the netfilter code to that of test11, but it dies
exactly in the same way, so that if the bug is in netfilter it was there
already.

By the way, the bug is only triggered when using netfilter in native mode:
the ipchains compatibility mode apparently works fine.

Does anybody have a clue? I need the stateful firewalling capabilities of
netfilter. I will gladly help, if possible. But I cannot connect a console
to the serial port to capture the oops...

And, since we are talking about fragments: where did the ip_always_defrag
switch that used to be in /proc/sys/net/ipv4 (in 2.2.x kernels) go? 

Bye, thanks

________________________________________________________________________

Giacomo Mulas <gmulas@ca.astro.it, gmulas@tiscalinet.it, gmulas@eso.org>
________________________________________________________________________

OSSERVATORIO  ASTRONOMICO                                                
Str. 54, Loc. Poggio dei Pini * 09012 Capoterra (CA)

Tel.: +39 070 71180 216     Fax : +39 070 71180 222
________________________________________________________________________

"When the storms are raging around you, stay right where you are"
                         (Freddy Mercury)
________________________________________________________________________

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
