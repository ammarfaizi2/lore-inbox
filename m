Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbVBHVaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbVBHVaw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 16:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbVBHVaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 16:30:52 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:59403 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261668AbVBHVap
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 16:30:45 -0500
Message-Id: <200502082221.j18MLqs0013717@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Blaisorblade <blaisorblade@yahoo.it>
cc: user-mode-linux-devel@lists.sourceforge.net,
       Anton Altaparmakov <aia21@cam.ac.uk>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [uml-devel] Re: [BUG report] UML linux-2.6 latest BK doesn't compile 
In-Reply-To: Your message of "Tue, 08 Feb 2005 18:48:46 +0100."
             <200502081848.46270.blaisorblade@yahoo.it> 
References: <1107857395.15872.2.camel@imp.csi.cam.ac.uk> <200502081122.22613.blaisorblade@yahoo.it> <1107859254.582.4.camel@imp.csi.cam.ac.uk>  <200502081848.46270.blaisorblade@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 08 Feb 2005 17:21:52 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

blaisorblade@yahoo.it said:
> the Makefiles were heavily changed, however, recently (after 2.6.10). 

There was a bug in that patch.  The fix is:

Index: 2.6.10/arch/um/Makefile
===================================================================
--- 2.6.10.orig/arch/um/Makefile        2005-02-08 12:33:23.000000000 -0500
+++ 2.6.10/arch/um/Makefile     2005-02-08 12:33:23.000000000 -0500
@@ -36,8 +36,8 @@
 MAKEFILES-INCL += $(foreach mode,$(um-modes-y),\
                   $(srctree)/$(ARCH_DIR)/Makefile-$(mode))
 
-ifneq ($(MAKEFILE-INCL),)
-  include $(MAKEFILE-INCL)
+ifneq ($(MAKEFILES-INCL),)
+  include $(MAKEFILES-INCL)
 endif
 
 ARCH_INCLUDE   := -I$(ARCH_DIR)/include

				Jeff

