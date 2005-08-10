Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbVHJXsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbVHJXsU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 19:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbVHJXsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 19:48:20 -0400
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:3990 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S964815AbVHJXsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 19:48:19 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17146.37443.505736.147373@wombat.chubb.wattle.id.au>
Date: Thu, 11 Aug 2005 09:48:19 +1000
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: linux-kernel@vger.kernel.org
Subject: fcntl(F_GETLEASE) semantics??
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	The LTP test fcntl23 is failing.  It does, in essence, 
	fd = open(xxx, O_RDWR|O_CREAT, 0777);
	if (fcntl(fd, F_SETLEASE, F_RDLCK) == -1)
	   fail;

fcntl always returns EAGAIN here.  The manual page says that a read
lease causes notification when `another process' opens the file for
writing or truncates it.  The kernel implements `any process'
(including the current one).

Which semantics are correct?  Personally I think that what the kernel
implements is correct (you can't get a read lease unsless there are no
writers _at_ _all_)


-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
