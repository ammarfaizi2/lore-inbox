Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263004AbTJ3XQt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 18:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263005AbTJ3XQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 18:16:49 -0500
Received: from mail004.syd.optusnet.com.au ([211.29.132.145]:2267 "EHLO
	mail004.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263004AbTJ3XQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 18:16:48 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16289.39801.239846.9369@wombat.chubb.wattle.id.au>
Date: Fri, 31 Oct 2003 10:15:05 +1100
To: root@chaos.analogic.com
Cc: George Anzinger <george@mvista.com>,
       Peter Chubb <peter@chubb.wattle.id.au>,
       Stephen Hemminger <shemminger@osdl.org>,
       Gabriel Paubert <paubert@iram.es>, john stultz <johnstul@us.ibm.com>,
       Joe Korty <joe.korty@ccur.com>, Linus Torvalds <torvalds@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: gettimeofday resolution seriously degraded in test9
In-Reply-To: <Pine.LNX.4.53.0310301645170.16005@chaos>
References: <20031027234447.GA7417@rudolph.ccur.com>
	<1067300966.1118.378.camel@cog.beaverton.ibm.com>
	<20031027171738.1f962565.shemminger@osdl.org>
	<20031028115558.GA20482@iram.es>
	<20031028102120.01987aa4.shemminger@osdl.org>
	<20031029100745.GA6674@iram.es>
	<20031029113850.047282c4.shemminger@osdl.org>
	<16288.17470.778408.883304@wombat.chubb.wattle.id.au>
	<3FA1838C.3060909@mvista.com>
	<Pine.LNX.4.53.0310301645170.16005@chaos>
X-Mailer: VM 7.14 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Richard" == Richard B Johnson <root@chaos.analogic.com> writes:

Richard> There isn't any magic that can solve this problem. It turns
Richard> out that with later Intel CPUs, one can get CPU-clock
Richard> resolution from rdtsc. However, this is hardware-specific. If
Richard> somebody modifies the gettimeofday() and the POSIX clock
Richard> routines to use rdtsc when available, a lot of problems will
Richard> go away.

gettimofday() and the posix clock routines (which use gettimeofday())
*do* use rdtsc if the processor has a reliable one --- do_gettimeofday() calls
cur_timer->get_offset(), which is essentially a scaled rdtsc if you're
using timers_tsc.c.

But when you have power management turned on, TSC doesn't run at a
constant rate.   If it gets *too* slow, the timer switches to use the
PIT instead, and one loses the cycle-resolution one would otherwise have.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories,   all slightly different.

