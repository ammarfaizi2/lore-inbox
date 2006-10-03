Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWJCNKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWJCNKm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 09:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWJCNKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 09:10:42 -0400
Received: from alnrmhc13.comcast.net ([206.18.177.53]:15251 "EHLO
	alnrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S932138AbWJCNKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 09:10:41 -0400
Date: Tue, 3 Oct 2006 08:12:43 -0500
From: Corey Minyard <minyard@acm.org>
To: Andi Kleen <ak@muc.de>, Vojtech Pavlik <vojtech@suse.cz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix for arch/x86_64/pci/Makefile CFLAGS
Message-ID: <20061003131242.GA32190@localdomain>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The arch/x86_64/pci directory was giving problems in a wierd
cross-compile environment.  The exact cause is unknown, but
the Makefile used CFLAGS instead of EXTRA_CFLAGS.  From what
I can tell from Documentation/kbuild/makefiles.txt, CFLAGS
should not be used for this, it should be EXTRA_CFLAGS.
And it solves the cross-compile problem.

Signed-off-by: Corey Minyard <cminyard@mvista.com>

Index: linux-2.6.18/arch/x86_64/pci/Makefile
===================================================================
--- linux-2.6.18.orig/arch/x86_64/pci/Makefile
+++ linux-2.6.18/arch/x86_64/pci/Makefile
@@ -3,7 +3,7 @@
 #
 # Reuse the i386 PCI subsystem
 #
-CFLAGS += -Iarch/i386/pci
+EXTRA_CFLAGS += -Iarch/i386/pci
 
 obj-y		:= i386.o
 obj-$(CONFIG_PCI_DIRECT)+= direct.o
