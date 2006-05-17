Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbWEQBYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbWEQBYu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 21:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbWEQBYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 21:24:50 -0400
Received: from mail26.syd.optusnet.com.au ([211.29.133.167]:17303 "EHLO
	mail26.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751051AbWEQBYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 21:24:49 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17514.31511.386806.484792@wombat.chubb.wattle.id.au>
Date: Wed, 17 May 2006 11:23:35 +1000
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Martin Peschke <mp3@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ak@suse.de, hch@infradead.org,
       arjan@infradead.org, James.Smart@emulex.com,
       James.Bottomley@steeleye.com
Subject: Re: [RFC] [Patch 7/8] statistics infrastructure - exploitation prerequisite
In-Reply-To: <200605170103.08917.arnd@arndb.de>
References: <446A1023.6020108@de.ibm.com>
	<20060516112824.39b49563.akpm@osdl.org>
	<446A53DE.6060400@de.ibm.com>
	<200605170103.08917.arnd@arndb.de>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Anrd> Am Wednesday 17 May 2006 00:36 schrieb Martin Peschke:
> Any other hints on how to replace my sched_clock() calls are welcome.
> (I want to measure elapsed times in units that are understandable to
> users without hardware manuals and calculator, such as milliseconds.)

Anrd> There are a number of APIs that allow you to get the time:

Anrd> - do_gettimeofday
Anrd>   potentially slow, reliable TOD clock, microsecond resolution

Slow, not necessarily safe to call in IRQ context.

Anrd> - ktime_get_ts
Anrd>   monotonic clock, nanosecond resolution

Actual resolution varies by platform, it may be as low as jiffy.

Anrd> - getnstimeofday
Anrd>   reliable, nanosecond TOD clock

(which is only currently implemented with ns resolution on IA64 and
Sparc64, AFAIK) 

Anrd> - xtime
Anrd>   jiffie accurate TOD clock, with fast reads

Too coarse a resolution.


Anrd> - get_cycles
Anrd>   highest supported resolution and accuracy, highly
Anrd>   HW-specific behaviour, may overflow.

Not very usable on SMP if you want to measure across migration; may be
variable rate.

-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
http://www.ertos.nicta.com.au           ERTOS within National ICT Australia
