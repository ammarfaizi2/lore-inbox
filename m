Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263052AbTH0Bum (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 21:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263049AbTH0Bum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 21:50:42 -0400
Received: from c210-49-26-171.randw1.nsw.optusnet.com.au ([210.49.26.171]:675
	"EHLO mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id S263052AbTH0Buf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 21:50:35 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16204.3686.972704.91444@wombat.chubb.wattle.id.au>
Date: Wed, 27 Aug 2003 11:50:30 +1000
To: Andrew Morton <akpm@osdl.org>
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test4 -- add context switch counters
In-Reply-To: <20030826181807.1edb8c48.akpm@osdl.org>
References: <16204.520.61149.961640@wombat.disy.cse.unsw.edu.au>
	<20030826181807.1edb8c48.akpm@osdl.org>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Morton <akpm@osdl.org> writes:

Andrew> Peter Chubb <peterc@gelato.unsw.edu.au> wrote:
>> Currently, the context switch counters reported by getrusage() are
>> always zero.  The appended patch adds fields to struct task_struct
>> to count context switches, and adds code to do the counting.
>> 
>> The patch adds 4 longs to struct task struct, and a single addition
>> to the fast path in schedule().

Andrew> OK...  Why is this useful?  A bit of googling doesn't show
Andrew> much interest in it.

/usr/bin/time reports the info, yes.

It's useful for tuning the scheduler, and when developing and tuning
posix thread apps. 

I wanted to know if the work I did on adding preemption support to IA64
actually made much difference in the number of involuntary context
switches.  It doesn't, at least on the measurements I've made so far.

I'm actually intested in getting most of the rusage fields filled in
properly, at least the ones that make sense for Linux.

Things to do are:
       -- Track maxrss and report it.
       -- Track and integrate rss.
       -- Fix the page fault accounting (currently some minor faults
          are counted as major faults)
       -- add signal accounting

Block I/O isn't that important -- it almost all goes through the page
cache anyway, and it's a bit difficult to assign a particular I/O to a
particular process.  Likewise, message I.O isn't that important AFAIK.

The stack, data and unshared data sizes aren't currently
accounted for separately at all, so it'd be a bit difficult to track
the integral of those numbers.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories,   all slightly different.


