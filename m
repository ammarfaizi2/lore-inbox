Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVEKPLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVEKPLP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 11:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbVEKPLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 11:11:15 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:33935 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261211AbVEKPLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 11:11:02 -0400
Date: Wed, 11 May 2005 10:10:31 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: Andrew Morton <akpm@osdl.org>
cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
       linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] ppc32: Fix uImage make target to report success correctly
Message-ID: <Pine.LNX.4.61.0505111008010.9895@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The existing make rule when building a uImage would check to see
if the image file existed to report 'is ready' or 'not made'.
However make appeared to compute the file list before the rule
was executed.

Signed-off-by: Chris Clark <cpclark@xmission.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org> 

---
commit f772a90e948f019c3111a94394b3a649874417c7
tree c9d59c269792db4933039da49b3b3836ac5b01f5
parent c140244727aa88fcaefe34af4abc56e85b471da2
author Kumar K. Gala <kumar.gala@freescale.com> Tue, 10 May 2005 10:27:46 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Tue, 10 May 2005 10:27:46 -0500

 ppc/boot/images/Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: arch/ppc/boot/images/Makefile
===================================================================
--- dd5d97e6f88b8fbfcc09878d837c8e90590484b8/arch/ppc/boot/images/Makefile  (mode:100644)
+++ c9d59c269792db4933039da49b3b3836ac5b01f5/arch/ppc/boot/images/Makefile  (mode:100644)
@@ -22,7 +22,8 @@
 $(obj)/uImage: $(obj)/vmlinux.gz
 	$(Q)rm -f $@
 	$(call if_changed,uimage)
-	@echo '  Image: $@' $(if $(wildcard $@),'is ready','not made')
+	@echo -n '  Image: $@ '
+	@if [ -f $@ ]; then echo 'is ready' ; else echo 'not made'; fi
 
 # Files generated that shall be removed upon make clean
 clean-files	:= sImage vmapus vmlinux* miboot* zImage* uImage
