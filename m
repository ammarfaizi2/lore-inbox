Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263142AbTKTXCb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 18:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263463AbTKTXAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 18:00:39 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:61906 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S263142AbTKTW5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 17:57:30 -0500
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: B.Zolnierkiewicz@elka.pw.edu.pl, akpm@osld.org
Date: Fri, 21 Nov 2003 09:57:17 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16317.18125.869980.877589@wombat.disy.cse.unsw.edu.au>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: (2.6.0-test9) Disabling IDE DMA removes ability to select chipsets
X-Mailer: VM 7.14 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	In drivers/ide/Kconfig at present, if you deselect
BLK_DEV_IDEDMA_PCI you can then *not* select any of the non-generic
chipsets.  Thus you lose the ability to auto-tune PIO modes, for
example.

This patch rearranges where the endif moves to disable just the config
options that depend on DMA.

===== Kconfig 1.32 vs edited =====
--- 1.32/drivers/ide/Kconfig	Wed Nov 19 18:40:45 2003
+++ edited/Kconfig	Thu Nov 20 14:32:13 2003
@@ -531,6 +531,8 @@
 	depends on PCI && BLK_DEV_IDEPCI
 	default BLK_DEV_IDEDMA_PCI
 
+endif
+
 config BLK_DEV_AEC62XX
 	tristate "AEC62XX chipset support"
 	help
@@ -800,7 +802,6 @@
 	  This allows the kernel to change PIO, DMA and UDMA speeds and to
 	  configure the chip to optimum performance.
 
-endif
 
 config BLK_DEV_IDE_PMAC
 	bool "Builtin PowerMac IDE support"
