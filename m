Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132743AbRBEFQE>; Mon, 5 Feb 2001 00:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132803AbRBEFPz>; Mon, 5 Feb 2001 00:15:55 -0500
Received: from pizda.ninka.net ([216.101.162.242]:4745 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132743AbRBEFPm>;
	Mon, 5 Feb 2001 00:15:42 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14974.13952.347437.536161@pizda.ninka.net>
Date: Sun, 4 Feb 2001 21:13:36 -0800 (PST)
To: jamal <hadi@cyberus.ca>
Cc: Rick Jones <raj@cup.hp.com>, Ion Badulescu <ionut@cs.columbia.edu>,
        Andrew Morton <andrewm@uow.edu.au>,
        lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: Still not sexy! (Re: sendfile+zerocopy: fairly sexy (nothing 
 todowith ECN)
In-Reply-To: <Pine.GSO.4.30.0102041426180.15417-100000@shell.cyberus.ca>
In-Reply-To: <3A77777D.E1A998FC@cup.hp.com>
	<Pine.GSO.4.30.0102041426180.15417-100000@shell.cyberus.ca>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jamal writes:
 > > So, now you have to ask how well any given NIC follows chains of
 > > buffers. At what number of buffers is the overhead in the NIC of
 > > following the chains enough to keep it from achieving link-rate?
 > >
 > 
 > hmmm... not sure how you would enforce this today or why you would
 > want that. Alexey, Dave?
 > The kernel should be able to break it into two buffers(with netperf,
 > for example -- header + data).
 > Ok, probably with tux-http 3 (header, data, trailler).

First, just to make sure Jamal understands what Rick Jones is
trying to make note of.  He is trying to say that the cost of
dealing with extra TX descriptor ring entries can begin to
nullify the gains of zerocopy, depending upon HW implementation (both
at the NIC and the PCI controller).

Back to today, it is possible that this is an issue if your machine
is near PCI bandwidth saturation before zerocopy for these tests.
I think this may be one of the factors causing Jamal to see results
Alexey cannot reproduce.  Get two people with identical PCI host
bridges, Acenic in identical PCI slot, I bet the numbers begin to
jive.

Currently, you get "1 + ((MTU + PAGE_SIZE - 1) / PAGE_SIZE)" buffers
per packet when going over a zerocopy device using TCP.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
