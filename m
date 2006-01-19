Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161381AbWASXYB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161381AbWASXYB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 18:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161471AbWASXYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 18:24:01 -0500
Received: from lemon.ken.nicta.com.au ([203.143.174.44]:14045 "EHLO
	lemon.gelato.unsw.edu.au") by vger.kernel.org with ESMTP
	id S1161381AbWASXYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 18:24:00 -0500
From: Peter Chubb <peterc@gelato.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17360.8073.622104.500429@berry.gelato.unsw.EDU.AU>
Date: Fri, 20 Jan 2006 10:23:53 +1100
To: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
X-Mailer: VM 7.19 under 21.4 (patch 18) "Social Property" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
X-SA-Exim-Connect-IP: 203.143.160.117
X-SA-Exim-Mail-From: peterc@gelato.unsw.edu.au
Subject: Re: Include assembly entry points in TAGS 
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
 

If you're using Emacs and TAGS, it's useful to be able to get the
global assembler variables as tags into the TAGS file.  But they're
hidden by a macro.  This patch teaches etags about the macro.

 Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6-vmm/Makefile
===================================================================
--- linux-2.6-vmm.orig/Makefile	2006-01-17 11:38:27.544972040 +1100
+++ linux-2.6-vmm/Makefile	2006-01-17 11:42:02.587956460 +1100
@@ -1251,7 +1251,7 @@ define cmd_TAGS
                 echo "-I __initdata,__exitdata,__acquires,__releases  \
                       -I EXPORT_SYMBOL,EXPORT_SYMBOL_GPL              \
                       --extra=+f --c-kinds=+px"`;                     \
-                $(all-sources) | xargs etags $$ETAGSF -a
+                $(all-sources) | xargs etags $$ETAGSF -a  --regex='{asm}/^\(GLOBAL_\)?ENTRY(\([^)]*\))/\2/'
 endef
 
 TAGS: FORCE
