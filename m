Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2993145AbWJUQv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993145AbWJUQv5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 12:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993155AbWJUQvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 12:51:55 -0400
Received: from cantor2.suse.de ([195.135.220.15]:1720 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S2993145AbWJUQvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 12:51:36 -0400
From: Andi Kleen <ak@suse.de>
References: <20061021 651.356252000@suse.de>
In-Reply-To: <20061021 651.356252000@suse.de>
To: Corey Minyard <minyard@acm.org>, Andi Kleen <ak@muc.de>,
       Vojtech Pavlik <vojtech@suse.cz>, Sam Ravnborg <sam@ravnborg.org>,
       patches@x86-64.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [6/19] x86_64: Fix for arch/x86_64/pci/Makefile CFLAGS
Message-Id: <20061021165126.02E1013CB4@wotan.suse.de>
Date: Sat, 21 Oct 2006 18:51:25 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Corey Minyard <minyard@acm.org>

The arch/x86_64/pci directory was giving problems in a wierd cross-compile
environment.  The exact cause is unknown, but the Makefile used CFLAGS
instead of EXTRA_CFLAGS.  From what I can tell from
Documentation/kbuild/makefiles.txt, CFLAGS should not be used for this, it
should be EXTRA_CFLAGS.  And it solves the cross-compile problem.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Andi Kleen <ak@suse.de>
Cc: Andi Kleen <ak@muc.de>
Cc: Vojtech Pavlik <vojtech@suse.cz>
Cc: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/x86_64/pci/Makefile |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux/arch/x86_64/pci/Makefile
===================================================================
--- linux.orig/arch/x86_64/pci/Makefile
+++ linux/arch/x86_64/pci/Makefile
@@ -3,7 +3,7 @@
 #
 # Reuse the i386 PCI subsystem
 #
-CFLAGS += -Iarch/i386/pci
+EXTRA_CFLAGS += -Iarch/i386/pci
 
 obj-y		:= i386.o
 obj-$(CONFIG_PCI_DIRECT)+= direct.o
