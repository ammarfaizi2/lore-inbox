Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265147AbUADJyJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 04:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265151AbUADJyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 04:54:09 -0500
Received: from mail006.syd.optusnet.com.au ([211.29.132.63]:38024 "EHLO
	mail006.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265147AbUADJyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 04:54:07 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16375.57972.132841.32878@wombat.chubb.wattle.id.au>
Date: Sun, 4 Jan 2004 20:52:52 +1100
To: Jens Axboe <axboe@suse.de>
Cc: Hugang <hugang@soulinfo.com>, Bart Samwel <bart@samwel.tk>,
       Andrew Morton <akpm@osdl.org>, smackinlay@mail.com,
       Bartek Kania <mrbk@gnarf.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] laptop-mode-2.6.0 version 5
In-Reply-To: <20040102120327.GA19822@suse.de>
References: <20031231210756.315.qmail@mail.com>
	<3FF3887C.90404@samwel.tk>
	<20031231184830.1168b8ff.akpm@osdl.org>
	<3FF43BAF.7040704@samwel.tk>
	<3FF457C0.2040303@samwel.tk>
	<20040101183545.GD5523@suse.de>
	<20040102170234.66d6811d@localhost>
	<20040102112733.GA19526@suse.de>
	<20040102193849.6ff090da@localhost>
	<20040102120327.GA19822@suse.de>
X-Mailer: VM 7.14 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jens" == Jens Axboe <axboe@suse.de> writes:

Jens> The dump printk() needs to be changed anyways, the rw
Jens> deciphering is not correct. Something like this is more
Jens> appropriate:

Jens>	if (unlikely(block_dump)) { 
Jens>		char b[BDEVNAME_SIZE];
Jens>		printk("%s(%d): %s block %Lu on %s\n", current->comm, current-> pid, (rw & WRITE) ? "WRITE" : "READ",
Jens>		(u64) bio->bi_sector, bdevname(bio->bi_bdev, b)); 
Jens>	}

Please cast to (unsigned long long) not (u64) because on 64-bit
architectures u64 is unsigned long, and you'll get a compiler warning.

