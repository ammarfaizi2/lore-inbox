Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264524AbUGMAVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264524AbUGMAVN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 20:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264522AbUGMAVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 20:21:12 -0400
Received: from mail021.syd.optusnet.com.au ([211.29.132.132]:6865 "EHLO
	mail021.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264524AbUGMAUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 20:20:09 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16627.10931.53356.312224@wombat.chubb.wattle.id.au>
Date: Tue, 13 Jul 2004 10:20:03 +1000
From: peterc@gelato.unsw.edu.au
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: Maximum frequency of re-scheduling (minimum time quantum	) que
 stio n
CC: linux-kernel@vger.kernel.org
In-Reply-To: <320586863@toto.iv>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

F>>>>> "Nick" == Nick Piggin <nickpiggin@yahoo.com.au> writes:

Nick> However well tested your scheduler might be, it needs several
Nick> orders of magnitude more testing ;) Maybe the best we can hope
Nick> for is compile time selectable alternatives.  


Well, Solaris and other SVr4-based systems have run-time selectable
schedulers -- on a per-process basis.  (Of course, it only makes sense
to run schedulers that coexist nicely at the same time).  These
operating systems have the notion of a per-process scheduling class,
that is essentially some private data, and a vector of functions to be
called at particular times: when a thread is created, when something
goes to sleep or wakes up, at timeslice expiration, etc.  The
dispatcher then does queue management only, so there's a nice
separation of function.

By separating priority bands for each scheduler, you could have many
different schedulers cooperating simultaneously.  And if you don't
like the SCHED_OTHER scheduler you could replace it.  With care, this
could be done retrospectively to running processes.

We could perhaps think of doing this for the 2.7 timeframe.  I'm
cerrtainly interested, to allow easier experimentation with Gang and
other NUMA schedulers.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
