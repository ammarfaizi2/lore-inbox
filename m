Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbVCNEO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbVCNEO0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 23:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbVCNEOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 23:14:25 -0500
Received: from mail20.syd.optusnet.com.au ([211.29.132.201]:65463 "EHLO
	mail20.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262003AbVCNEOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 23:14:00 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16949.4010.174143.391599@wombat.chubb.wattle.id.au>
Date: Mon, 14 Mar 2005 15:14:34 +1100
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: linux-kernel@vger.kernel.org
Subject: inode_lock heavily contended in 2.6.11
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When running reaim7 on a 12-way IA64 on an ext2 filesystem on a ram
disc, I see very heavy contention on inode_lock.

lockstat output shows:

SPINLOCKS         HOLD            WAIT
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )(% CPU)     TOTAL NOWAIT SPIN RJECT  NAME
 46.8% 52.4%  1.9us( 130us)   20us(8073us)(21.5%)   5072151 47.6% 52.4%    0%  inode_lock
 15.9% 59.5%  3.8us(  61us)   18us(7067us)( 3.9%)    852983 40.5% 59.5%    0%    __sync_single_inode+0xf0
  9.2% 59.0%  1.2us(  25us)   20us(8073us)( 7.8%)   1596487 41.0% 59.0%    0%    generic_osync_inode+0xe0

 (etc).

Is anyone else seeing this on more realistic workloads?

-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
