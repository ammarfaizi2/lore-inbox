Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270537AbTGNDxn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 23:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270538AbTGNDxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 23:53:43 -0400
Received: from c16805.randw1.nsw.optusnet.com.au ([210.49.26.171]:2459 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id S270537AbTGNDxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 23:53:40 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16146.11415.860568.750334@wombat.chubb.wattle.id.au>
Date: Mon, 14 Jul 2003 14:07:51 +1000
To: Matthew Wilcox <willy@debian.org>
Cc: Bernardo Innocenti <bernie@develer.com>, Andrew Morton <akpm@zip.com.au>,
       linux-kernel@vger.kernel.org
Subject: do_div vs sector_t
In-Reply-To: <20030711223359.GP20424@parcelfarce.linux.theplanet.co.uk>
References: <20030711223359.GP20424@parcelfarce.linux.theplanet.co.uk>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Matthew" == Matthew Wilcox <willy@debian.org> writes:


Matthew>                         do_div(aic->seek_mean, aic->seek_samples); }

Matthew> seek_mean is a sector_t so sometimes it's 64-bit on a 32-bit
Matthew> platform.  so we can't avoid calling do_div().

Use sector_div() instead! -- it uses a 63/32 bit divide/remainder if
sector_t is 64-bit, and 32/32 if it's 32-bit.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories,   all slightly different.
