Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262252AbUKBWb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262252AbUKBWb3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 17:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbUKBWb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 17:31:29 -0500
Received: from mail22.syd.optusnet.com.au ([211.29.133.160]:32657 "EHLO
	mail22.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262450AbUKBWa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 17:30:56 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16776.2694.218108.742708@wombat.chubb.wattle.id.au>
Date: Wed, 3 Nov 2004 09:30:30 +1100
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][plugsched 0/28] Pluggable cpu scheduler framework
Newsgroups: smurf.list.linux.kernel
In-Reply-To: <pan.2004.11.02.21.28.32.869425@smurf.noris.de>
References: <4183A602.7090403@kolivas.org>
	<20041031233313.GB6909@elf.ucw.cz>
	<20041101114124.GA31458@elte.hu>
	<pan.2004.11.02.21.28.32.869425@smurf.noris.de>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Matthias" == Matthias Urlichs <smurf@smurf.noris.de> writes:

Matthias> Hi, Ingo Molnar wrote:
>> I believe that by compartmenting in the wrong way [*] we kill the
>> natural integration effects. We'd end up with 5 (or 20) bad generic
>> schedulers that happen to work in one precise workload only, but
>> there would not be enough push to build one good generic scheduler,
>> because the people who are now forced to care about the Linux
>> scheduler would be content about their specialized schedulers.

Matthias> I hate that. Ideally, the scheduler would be
Matthias> hotpluggable... but I can live with a reboot. I don't think
Matthias> a kernel recompile to switch schedulers makes sense, though,
Matthias> so I for one am likely not to bother. So far.

Matthias> You can't actually develop a better scheduler if people need
Matthias> to go too far out of their way to compare them.

I'd like to go further and be able to have families of schedulers that
work together  --- if you're going to vector to a scheduler anyway,
why not do it per process?  That way the special cases for SCHED_FIFO and
SCHED_RR can be moved into separate functions (likewise SCHED_ISO,
SCHED_BATCH, SCHED_GANG etc., as and when they're developed), rather
than being controlled by if() or switch() statements in a common
do-everything scheduler.

In general, it's the interactive SCHED_OTHER scheduler that's been the
problem, and the focus of most of the work.  We more-or-less know how
to do the basic POSIX schedulers.  
-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
