Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274887AbTHKWqv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 18:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274889AbTHKWqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 18:46:51 -0400
Received: from c210-49-26-171.randw1.nsw.optusnet.com.au ([210.49.26.171]:38338
	"EHLO mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id S274887AbTHKWqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 18:46:50 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: akpm@digeo.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] kill warning in jbd/revoke.c
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Message-Id: <S274889AbTHKWqv/20030811224651Z+13497@vger.kernel.org>
Date: Mon, 11 Aug 2003 18:46:51 -0400


If you need a long long format, then cast to long long, not u64.  u64
is long on 64-bit architectures.

===== fs/jbd/revoke.c 1.14 vs edited =====
- --- 1.14/fs/jbd/revoke.c	Sat Jun 21 06:16:32 2003
+++ edited/fs/jbd/revoke.c	Mon Aug 11 15:02:44 2003
@@ -438,7 +438,7 @@
 		record = find_revoke_record(journal, bh->b_blocknr);
 		if (record) {
 			jbd_debug(4, "cancelled existing revoke on "
- -				  "blocknr %llu\n", (u64)bh->b_blocknr);
+				  "blocknr %llu\n", (unsigned long long)bh->b_blocknr);
 			spin_lock(&journal->j_revoke_lock);
 			list_del(&record->hash);
 			spin_unlock(&journal->j_revoke_lock);


- --
Dr Peter Chubb     http://www.gelato.unsw.edu.au  peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories,   all slightly different.


---End encapsulation
