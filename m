Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266114AbUIAKz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266114AbUIAKz0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 06:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266129AbUIAKz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 06:55:26 -0400
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:57555 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266114AbUIAKzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 06:55:24 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16693.43645.643290.178050@wombat.chubb.wattle.id.au>
Date: Wed, 1 Sep 2004 20:54:53 +1000
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: rmk@arm.linux.org.uk
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.9-rc1] Fix ARM compilation with GCC 3.4
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



gcc 3.4 passes -mfpu=softfpa to the assembler if -msoft-float is
specified.

This conflicts with -mno-fpu which the Makefile passes exlicitly.

I fixed by not appending -Wa,-mno-fpu  to the command line, but of
course you probably only want to do this for sufficiently recent GCC
and binutils.  $(call cc-option) doesn't work in this case (or doesn't
appear to, anyway).

--- /tmp/geta18380	2004-09-01 20:46:26.000000000 +1000
+++ Linux-2.6/arch/arm/Makefile		2004-09-01 20:36:44.000000000 +1000
@@ -55,8 +55,8 @@
 tune-$(CONFIG_CPU_V6)		:=-mtune=strongarm
 
 # Need -Uarm for gcc < 3.x
-CFLAGS		+=-mapcs-32 $(arch-y) $(tune-y) $(call cc-option,-malignment-traps,-mshort-load-bytes) -msoft-float -Wa,-mno-fpu -Uarm
-AFLAGS		+=-mapcs-32 $(arch-y) $(tune-y) -msoft-float -Wa,-mno-fpu
+CFLAGS		+=-mapcs-32 $(arch-y) $(tune-y) $(call cc-option,-malignment-traps,-mshort-load-bytes) -msoft-float -Uarm
+AFLAGS		+=-mapcs-32 $(arch-y) $(tune-y) -msoft-float
 
 CHECKFLAGS	+= -D__arm__=1
 

-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
