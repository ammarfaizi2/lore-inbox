Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129604AbRAZNOo>; Fri, 26 Jan 2001 08:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129956AbRAZNOg>; Fri, 26 Jan 2001 08:14:36 -0500
Received: from pizda.ninka.net ([216.101.162.242]:36753 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129604AbRAZNO0>;
	Fri, 26 Jan 2001 08:14:26 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14961.30709.761096.910725@pizda.ninka.net>
Date: Fri, 26 Jan 2001 05:13:25 -0800 (PST)
To: Ion Badulescu <ionut@cs.columbia.edu>
Cc: <kuznet@ms2.inr.ac.ru>, <linux-kernel@vger.kernel.org>
Subject: Re: [UPDATE] Zerocopy patches, against 2.4.1-pre10
In-Reply-To: <Pine.LNX.4.30.0101252156170.20615-100000@age.cs.columbia.edu>
In-Reply-To: <14960.38705.859136.36297@pizda.ninka.net>
	<Pine.LNX.4.30.0101252156170.20615-100000@age.cs.columbia.edu>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ion Badulescu writes:
 > Well, in the meantime I've ported the starfire driver to the zerocopy
 > framework, it now takes almost full advantage of the card sg+csum
 > capabilities. The patch is attached; I'd appreciate it if you could
 > include it into the main zerocopy patch.

Great, some commentary, see below.

 > BTW, it looks like not many people are using this driver: the original had
 > a bug which made it spit out one printk per Tx packet, which was *not*
 > funny. Also, the module could not be unloaded and reloaded, as it failed
 > to release some of its resources (Alan already has a fix for that)..

Indeed.

Firstly, I would not configure the card to drop packets with bad
checksums.  If you do this, the errors do not propagate into the
correct ipv4 snmp tables, which is bad.  Also consider the case where
the card has some bug and it erroneously verifies rx checksums in some
strange cases, we would be hard pressed to find out with how you are
configuring it in this way.

Next, please remove the unconditional:

+				printk(KERN_DEBUG "sf: checksum_hw, status2 = %x\n", np->rx_done_q[np->rx_done].status2);

or at the very least make it print out netdev->name instead of the
cryptic "sf: " prefix.

Finally, what are the listed distribution terms of this firmware?
I want to make sure it is legal to distribute it.

Deal with these three issues, and I'll stick this into my zerocopy
patch sets.  Thanks again.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
