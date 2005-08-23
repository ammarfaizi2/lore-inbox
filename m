Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbVHWArq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbVHWArq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 20:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbVHWArq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 20:47:46 -0400
Received: from lemon.gelato.unsw.edu.au ([203.143.174.44]:26845 "EHLO
	lemon.gelato.unsw.edu.au") by vger.kernel.org with ESMTP
	id S932270AbVHWArp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 20:47:45 -0400
From: Peter Chubb <peterc@gelato.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17162.29210.35219.544638@berry.gelato.unsw.EDU.AU>
Date: Tue, 23 Aug 2005 10:47:22 +1000
To: sam@ravnborg.org
CC: linux-kernel@vger.kernel.org
X-Mailer: VM 7.19 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
X-SA-Exim-Connect-IP: 203.143.160.117
X-SA-Exim-Mail-From: peterc@gelato.unsw.edu.au
Subject: Include assembly entry points in TAGS
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:39:27 +0000)
X-SA-Exim-Scanned: Yes (on lemon.gelato.unsw.edu.au)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As it stands, etags doesn't find labels in the IA64 or i386 assembler source
code, because they're disguised inside a preprocessor macro.

I propose the attached fix, which adds a regular expression to enable
labels disguised by ENTRY() and GLOBAL_ENTRY() macros.

There's a similar problem for MIPS, which needs to match LEAF(entrypoint)

Signed-off-by: Peter Chubb <peterc@gelato.unsw.edu.au>

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -1187,7 +1187,7 @@ cscope: FORCE
 	$(call cmd,cscope)
 
 quiet_cmd_TAGS = MAKE   $@
-cmd_TAGS = $(all-sources) | etags -
+cmd_TAGS = $(all-sources) | etags --regex='{asm}/\(GLOBAL_\)?ENTRY(\([^)]+\))/\2/' -
 
 # 	Exuberant ctags works better with -I
 
