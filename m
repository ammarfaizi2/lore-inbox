Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbVBOBt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVBOBt7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 20:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbVBOBt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 20:49:59 -0500
Received: from mail19.syd.optusnet.com.au ([211.29.132.200]:49112 "EHLO
	mail19.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261587AbVBOBt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 20:49:57 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16913.21817.702372.962991@wombat.chubb.wattle.id.au>
Date: Tue, 15 Feb 2005 12:49:45 +1100
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Repeatable hang with XFS under 2.6.11-rc4
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Running Reaim-7 on a 4G ram disk with 4 processors on
Itanium... Every few runs, as the multiprocessing level increases, we
see 22 processes hung in sync(), all except one waiting in
sync_filesystems() and that one waiting in pagebuf_iowait().

There's lots of free memory, the ram-disk is not full, ...
Load average is low; nothing in the logs or on the console.

root@trixie:/proc# vmstat 2 
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0     0 23027552 1091472 218496  0    0     1 42107   12     6 1 21 78  0
 0  0     0 23027552 1091472 218496  0    0     0     0 4110    10 0  0 100 0
 0  0     0 23027552 1091472 218496  0    0     0     0 4109     8 0  0 100 0
 0  0     0 23027488 1091472 218496  0    0     0    32 4114    15 0  0 100 0
 0  0     0 23027488 1091472 218496  0    0     0     0 4110     9 0  0 100 0
 0  0     0 23027488 1091472 218496  0    0     0     0 4109     9 0  0 100 0
 
root@trixie:/proc/fs/xfs# df /mnt/ram-disk
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/ram1              1038336    127800    910536  13% /mnt/ram-disk


-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
