Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265310AbSKEXD3>; Tue, 5 Nov 2002 18:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265314AbSKEXD3>; Tue, 5 Nov 2002 18:03:29 -0500
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:2289 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S265310AbSKEXD2>; Tue, 5 Nov 2002 18:03:28 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15816.20406.532821.177470@wombat.chubb.wattle.id.au>
Date: Wed, 6 Nov 2002 10:09:42 +1100
To: Andreas Dilger <adilger@clusterfs.com>
Cc: reiser <reiser@namesys.com>, Nikita Danilov <Nikita@namesys.com>,
       Tomas Szepe <szepe@pinerecords.com>,
       Alexander Zarochentcev <zam@namesys.com>,
       lkml <linux-kernel@vger.kernel.org>, Oleg Drokin <green@namesys.com>,
       umka <umka@namesys.com>
Subject: Re: [BK][PATCH] Reiser4, will double Linux FS performance, pleaseapply
In-Reply-To: <877555917@toto.iv>
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andreas" == Andreas Dilger <adilger@clusterfs.com> writes:


Andreas> I think the bdflush defaults are (were?) something like 5
Andreas> seconds for metadata, and 30 seconds for file data. reiser4
Andreas> should (if it doesn't already) use the parameters set by
Andreas> sys_bdflush() to tune the writeout intervals.

...

Andreas> So, except for the very unusual case of files with lifespans
Andreas> between 30 seconds and 300 seconds, or files that are written
Andreas> to between those intervals, I would guess that you are not
Andreas> gaining much extra benefit by deferring the writes another
Andreas> 270 seconds.


Some benchmarking done at Berkeley showed that for development loads,
30seconds was too short to avoid excessive writes.

See Roselli, Lorch and Anderson, `A Comparison of File System
Workloads' in Usenix 2000.

http://research.microsoft.com/~lorch/papers/fs-workloads/fs-workloads.html

Their observations (summarised) were that most blocks die because of
overwriting, not because of file deletes.  Their workloads show that
for NT, the write timeout to avoid commits blocks that will soon
become dead needs to be around a day; for typical Unix loads (web
serving, research, software development), an hour is enough.  To catch
75%, a timeout of around 11 minutes is needed.  30seconds worked only
for webserving and undergraduate teaching workloads, and caught around
40% for those workloads; for a research workload and NT fileserving,
30seconds catches only 10-20% of the rewrites.

See especially figure 3 in that paper.

--
Dr Peter Chubb				    peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories, all almost the same.
