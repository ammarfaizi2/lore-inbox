Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbVIMVz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbVIMVz2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 17:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbVIMVz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 17:55:28 -0400
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:63398 "EHLO
	mail02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751070AbVIMVz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 17:55:26 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17191.19125.826388.938552@wombat.chubb.wattle.id.au>
Date: Wed, 14 Sep 2005 07:55:01 +1000
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Burton Windle <bwindle@fint.org>
Cc: linux-kernel@vger.kernel.org, James.Bottomley@steeleye.com
Subject: Re: SCSI issue with 2.6.14-rc1
In-Reply-To: <Pine.LNX.4.63.0509131202170.1684@postal>
References: <Pine.LNX.4.63.0509131202170.1684@postal>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Burton" == Burton Windle <bwindle@fint.org> writes:

Burton> Dell Poweredge 1300, MegaRAID SCSI with hardware RAID1. With
Burton> 2.6.13, system was fine, but on 2.6.14-rc1, it sees the RAID
Burton> array as a 0mb drive with 1 512-byte sector, and seems to have
Burton> a bit of a problem mounting /

This sounds like the same problem I saw with the IA64 simscsi driver
--- the READ_CAPACITY scsi command now generates a scatterlist, and
some drivers don't cope.

I don't know whether the right fix is to change all the drivers to
understand a scatterlist, or to change sd_read_capacity() to not use 
scsi_execute_command().

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
