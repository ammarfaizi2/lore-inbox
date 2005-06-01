Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVFAA5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVFAA5k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 20:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVFAA5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 20:57:40 -0400
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:29640 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261244AbVFAAyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 20:54:39 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17053.180.604190.389481@wombat.chubb.wattle.id.au>
Date: Wed, 1 Jun 2005 10:26:28 +1000
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: James Bruce <bruce@andrew.cmu.edu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
In-Reply-To: <Pine.OSF.4.05.10505311347290.1707-100000@da410.phys.au.dk>
References: <429C4112.2010808@andrew.cmu.edu>
	<Pine.OSF.4.05.10505311347290.1707-100000@da410.phys.au.dk>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Esben" == Esben Nielsen <simlo@phys.au.dk> writes:

Esben> On Tue, 31 May 2005, James Bruce wrote:
>> 
>> It is only better in that if you need provable hard-RT *right now*,
>> then you have to use a nanokernel.

Esben> What do you mean by "provable"? Security critical? Forget about
Esben> nanokernels then. The WHOLE system has to be validated. 

The whole point of a nanokernel is it's *small*.  The whole thing can
be formally verified.  And its semantics will provide isolation
between the real-time processes and anything else that's running.

We're currently working on a system called Iguana, which will have
provable WCET for real-time scheduled tasks, and a Linux envionrment
(called `wombat') that provides compatibility for 

Esben> I can't see it would be easier prove that a nano-kernel with
Esben> various needed mutex and queuing mechanism works correct than
Esben> it is to prove that the Linux scheduler with mutex and queueing
Esben> mechanisms works correctly.  

Except that the nano-kernel is less than one percent of the size.

Both systems does the same thing
Esben> and is most likely based on the same principles!  If a module
Esben> in Linux disables interrupts for a non-deterministic amount of
Esben> time, it destroys the RT in both scenarious. With the
Esben> nanokernel, the Linux kernel is patched not to disable
Esben> interrupts, but if someone didn't use the official
Esben> local_irq_disable() macro the patch didn't work anyway...  The
Esben> only way you can be absolutely sure Linux doesn't hurt RT is to
Esben> run it in a full blown virtuel machine where it doesn't have
Esben> access to disable interrupts and otherwise interfere with the
Esben> nano-kernel.

This is precisely the approach we (and others) are taking.   A
virtualised Linux to provide interactive and soft realtime (think java
games on your mobile phone), and a nanokernel for your hard realtime
tasks (think the radio controller on your mobile phone).  
See http://www.disy.cse.unsw.edu.au/Software/Iguana/ for our work.

In addition to our work, there's the Adeos system
(http://www.hyades-itea.org/) uses a very similar approach.

-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
