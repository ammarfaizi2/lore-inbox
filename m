Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWCaDA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWCaDA1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 22:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWCaDA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 22:00:27 -0500
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:55517 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751125AbWCaDA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 22:00:26 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17452.39743.625417.599298@wombat.chubb.wattle.id.au>
Date: Fri, 31 Mar 2006 14:00:15 +1100
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Ram Gupta <ram.gupta5@gmail.com>,
       linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: RSS Limit implementation issue
In-Reply-To: <442AEB3A.9030503@tmr.com>
References: <728201270602091310r67a3f2dcq4788199f26a69528@mail.gmail.com>
	<1139526447.6692.7.camel@localhost.localdomain>
	<728201270603230855l11faeb6ah33ee88568843068f@mail.gmail.com>
	<442AEB3A.9030503@tmr.com>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Bill" == Bill Davidsen <davidsen@tmr.com> writes:

Bill> Ram Gupta wrote:

Bill> If you want to make rss a hard limit the result should be
Bill> swapping, not failure to run. I'm not sure the limit in that
Bill> form is a good idea, and before someone reminds me, I do
Bill> remember liking it better a few years ago.

Bill> If you can come up with a better way to adjust rss to get better
Bill> overall greater throughput while being fair to all processes, go
Bill> to it. But in general these things are a tradeoff, like
Bill> swappiness, you tune until the volume of complaints reaches a
Bill> minimum.

What I did in one experiment was to:
     1.  delay swapin requests if the process was over its rsslimit,
         until it fell below, and
     2.  Poke the swapper to try to swap out the current process's
         pages in that case.

The problem with the approach is that it behaved poorly under memory
pressure.  If a process's optimum working set was larger than its RSS
limit, then either it was delayed to the point of glaciality, or it
could saturate the swap device (and so disturb other processes's
operation). 

-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
http://www.ertos.nicta.com.au           ERTOS within National ICT Australia
