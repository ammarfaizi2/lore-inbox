Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267324AbUJRSOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267324AbUJRSOQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 14:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267312AbUJRSOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 14:14:10 -0400
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:12302 "EHLO
	anchor-post-36.mail.demon.net") by vger.kernel.org with ESMTP
	id S267254AbUJRSLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 14:11:23 -0400
Date: Mon, 18 Oct 2004 19:07:07 +0100 (BST)
From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
To: linux-kernel@vger.kernel.org
Subject: PATCH to fix depmod failure for modules-install of a cross compiled
 kernel. (fwd)
Message-ID: <Pine.LNX.4.10.10410181905110.29938-100000@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Opps. Sorry, I did not read all of the lists of things to so for
submitting a patch.  

---------- Forwarded message ----------
Date: Sun, 17 Oct 2004 21:30:02 +0100 (BST)
From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
To: kai@germaschewski.name, sam@ravnborg.org
Cc: trivial@rustcorp.com.au
Subject: depmod failure for modules-install of a cross compiled kernel.

Hi all,

I ran into a small but inconvinient problem today when doing a
modules-install. The tempory solution is do disable depmod
when corss compiling. See the patch below.

Regards
	Mark Fortescue.
 
##############################################################################
#
# Mark Fortescue (mark@mtfhpc.demon.co.uk) 17th Oct 2004
#
# (from 2.6.8.1 with patch-2.6.9-rc2 and patch-2.6.9-rc2-bk6 applied.)
#
# When cross compiling for sparc on an i586 system,
# 'depmod' (module-init-tools-3.0) core dumped. The tempory
# solution is to disable 'depmod' when cross compiling.
# The correct solution is to fix 'depmod'.
#
##############################################################################
diff -ruNpd linux-2.6.8.1/Makefile linux-2.6.8.1-p02/Makefile
--- linux-2.6.8.1/Makefile	Fri Oct 15 20:19:18 2004
+++ linux-2.6.8.1-p02/Makefile	Sun Oct 17 02:38:34 2004
@@ -868,7 +868,7 @@ depmod_opts	:= -b $(INSTALL_MOD_PATH) -r
 endif
 .PHONY: _modinst_post
 _modinst_post: _modinst_
-	if [ -r System.map ]; then $(DEPMOD) -ae -F System.map $(depmod_opts) $(KERNELRELEASE); fi
+	if [ -r System.map -a -z "$(CROSS_COMPILE)" ]; then $(DEPMOD) -ae -F System.map $(depmod_opts) $(KERNELRELEASE); fi
 
 else # CONFIG_MODULES
 
-----------------------------------------------------------------



