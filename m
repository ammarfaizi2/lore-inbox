Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVFNXHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVFNXHP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 19:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbVFNXHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 19:07:15 -0400
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:60809 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261403AbVFNXHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 19:07:02 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17071.25351.996975.416810@wombat.chubb.wattle.id.au>
Date: Wed, 15 Jun 2005 09:06:47 +1000
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: linux-kernel@vger.kernel.org
Subject: Tuning ext3 for large disk arrays
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
CC: Andreas Hirstius <Andreas.Hirstius@cern.ch>
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi folks,
   We've been doing a few scalability measurements on disk arrays.  We
know how to tune xfs to give reasonable performance.  But I'm not sure
how to tune ext3, and the default parameters give poor performance.

See http://scalability.gelato.org/DiskScalability/Results for the
graphs.

iozone for 24 10k SATA disks spread across 3 3ware controllers gives a
peak read throughput on XFS of around 1050M/sec; but ext3 conks out
at around half that.  The maximum single threaded read performance we
got was 450M/sec, and it's pretty constant from 12 through 24
spindles.  We see no difference between setting -E stride=XX and
leaving this parameter off.

The system uses 64k pages; we can set XFS up with 64k blocks; it may
be that part of the problem is that ext3 can't use larger blocks.  We
repeated the XFs measurements configuring the kernel and filesystem to
use 4k pages/blocks, and although the throughput is lower than with
the 64k page size, it's still significantly better than with ext3.
Moreover, configuring XFS with 4k blocks, but using 64k pages gives
results (not shown on the Wiki page) almost the same as the 64k
pages/64k blocks.

Before going on and starting to look for bottlenecks, I'd like to be
sure that ext3 is tuned appropriately.  mke2fs doesn't seem to have
many appropriate tweaks, however...???

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
