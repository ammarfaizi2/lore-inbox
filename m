Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbVBHDCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVBHDCo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 22:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbVBHDCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 22:02:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15833 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261448AbVBHDCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 22:02:41 -0500
Date: Tue, 8 Feb 2005 03:02:28 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Sam Ravnborg <sam@ravnborg.org>,
       Kai Germaschewski <kai@germaschewski.name>
Cc: linux-kernel@vger.kernel.org, dholland@eecs.harvard.edu
Subject: [PATCH] Makefiles are not built using a Fortran compiler
Message-ID: <20050208030228.GE20386@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David Holland pointed out that Make has a lot of implicit suffix rules
built in and you can disable them by setting ".SUFFIXES:".  As an
example, checking the debugging information shows we no longer try to
compile anything from a '.f' suffix.  This turns out to be good for a 15%
speedup on a build with nothing to do; down from 29.1 seconds to 24.7
seconds on my K6.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

Index: Makefile
===================================================================
RCS file: /var/cvs/linux-2.6/Makefile,v
retrieving revision 1.338
diff -u -p -r1.338 Makefile
--- Makefile	6 Feb 2005 06:43:49 -0000	1.338
+++ Makefile	8 Feb 2005 02:39:28 -0000
@@ -4,6 +4,8 @@ SUBLEVEL = 11
 EXTRAVERSION =-rc3-pa3
 NAME=Woozy Numbat
 
+.SUFFIXES:
+
 # *DOCUMENTATION*
 # To see a list of typical targets execute "make help"
 # More info can be located in ./README
Index: scripts/Makefile.build
===================================================================
RCS file: /var/cvs/linux-2.6/scripts/Makefile.build,v
retrieving revision 1.9
diff -u -p -r1.9 Makefile.build
--- scripts/Makefile.build	12 Jan 2005 20:18:19 -0000	1.9
+++ scripts/Makefile.build	8 Feb 2005 02:39:28 -0000
@@ -4,6 +4,8 @@
 
 src := $(obj)
 
+.SUFFIXES:
+
 .PHONY: __build
 __build:
 

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
