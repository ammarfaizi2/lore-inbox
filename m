Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267884AbTBRReJ>; Tue, 18 Feb 2003 12:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267897AbTBRReJ>; Tue, 18 Feb 2003 12:34:09 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:22208 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267884AbTBRRdp>; Tue, 18 Feb 2003 12:33:45 -0500
Date: Tue, 18 Feb 2003 11:43:25 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Beat Bolli <bbolli@ymail.ch>
cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild: error with parallel make and modules
In-Reply-To: <20030218081203.GA20989@bolli.homeip.net>
Message-ID: <Pine.LNX.4.44.0302181141470.24975-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2003, Beat Bolli wrote:

> It seems like scripts/Makefile.modpost starts before vmlinux has finished linking.

Right, that's because for the non modversions case, I don't want to force 
people to build a vmlinux first when they only want modules. So I'm using 
vmlinux if it's there, otherwise not. That goes wrong when vmlinux is just 
being built ;-(

This should fix it - could you test it?

--Kai

===== Makefile 1.378 vs edited =====
--- 1.378/Makefile	Sun Feb 16 09:18:01 2003
+++ edited/Makefile	Tue Feb 18 11:37:19 2003
@@ -506,7 +506,7 @@
 #	Build modules
 
 .PHONY: modules
-modules: $(SUBDIRS) $(if $(CONFIG_MODVERSIONS),vmlinux)
+modules: $(SUBDIRS) $(if $(KBUILD_BUILTIN),vmlinux)
 	@echo '  Building modules, stage 2.';
 	$(Q)$(MAKE) -rR -f scripts/Makefile.modpost
 

