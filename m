Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbTISEQt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 00:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbTISEQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 00:16:49 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:21664 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S261240AbTISEQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 00:16:47 -0400
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: linux-ns83820@kvack.org
Date: Fri, 19 Sep 2003 14:16:29 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16234.33565.64383.838490@wombat.disy.cse.unsw.edu.au>
Subject: NS83820 2.6.0-test5 driver seems unstable on IA64
CC: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	I'm having some problems with the NS83820 driver on Itanium-1.

1.  I see many many `unaligned accesses' when the IP header is
accessed (ip_input.c:410 and 423)
It looks as if the IP header is two byte aligned, when it ought to be
4-byte aligned.

The error message is, e.g., 
 kernel unaligned access to 0xe000000128d8881e, ip=0xe0000000047ba2d1

0xe0000000047ba2d1 is             
ip_input:410
		   if (iph->ihl < 5 || iph->version != 4)
		                goto inhdr_error; 

0xe000000128d8881e is what's calculated as &iph->ihl

The obvious approach of realigning the SKB by 2 bytes seems not to
work.

Any ideas?

--
Dr Peter Chubb     http://www.gelato.unsw.edu.au  peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories,   all slightly different.

