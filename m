Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264676AbTGBDW0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 23:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264678AbTGBDWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 23:22:25 -0400
Received: from c16805.randw1.nsw.optusnet.com.au ([210.49.26.171]:53138 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id S264676AbTGBDWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 23:22:22 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16130.21283.122787.362837@wombat.chubb.wattle.id.au>
Date: Wed, 2 Jul 2003 13:36:03 +1000
To: Bernardo Innocenti <bernie@develer.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Kill div64.h dupes, parenthesize do_div() macro params
In-Reply-To: <200307020424.47629.bernie@develer.com>
References: <200307020232.20726.bernie@develer.com>
	<20030701173612.280d1296.akpm@digeo.com>
	<200307020424.47629.bernie@develer.com>
X-Mailer: VM 7.07 under 21.4 (patch 12) "Portable Code" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Bernardo" == Bernardo Innocenti <bernie@develer.com> writes:

Bernardo> On Wednesday 02 July 2003 02:36, Andrew Morton wrote:

Bernardo> If there are architectures where gcc doesn't implement
Bernardo> divisions correctly, this issue should be solved in gcc, not
Bernardo> by adding a silly macro to the kernel.

The issue is that on 32-bit platforms, 64bit divided by 32 bit is
handed off to a subroutine _udivdi3 which isn't linked into the
kernel, and  which in any case does a full 64 bit by 64-bit division
(which is slow).

Using do_div() allows one to generate near-optimal code for a 64by32
bit division/remainder on platforms (e.g., IA32) which have problems,
and generating something sane for other platforms (e.g., IA64).

Platforms that never expect to deal with a 64-bit number just redefine
the macro in terms of long.  Which means that printing out long longs
doesn't work properly on those architectures.


--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories,   all slightly different.
