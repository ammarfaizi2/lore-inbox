Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132127AbQKBO4w>; Thu, 2 Nov 2000 09:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132163AbQKBO4l>; Thu, 2 Nov 2000 09:56:41 -0500
Received: from nnj-dialup-60-237.nni.com ([216.107.60.237]:4800 "EHLO
	nnj-dialup-60-237.nni.com") by vger.kernel.org with ESMTP
	id <S132127AbQKBO40>; Thu, 2 Nov 2000 09:56:26 -0500
Message-ID: <3A017FBB.AF8C596D@cybernex.net>
Date: Thu, 02 Nov 2000 09:52:43 -0500
From: TenThumbs <tenthumbs@cybernex.net>
Reply-To: tenthumbs@cybernex.net
Organization: <>
X-Mailer: Mozilla 4.08C-See the fnords. [en] (X11; U; Linux 2.2.18pre18 i486)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.2.18pre18: many calls to kwhich
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that kwhich is called a lot:

make oldconfig:        10
make dep:              65
make bzImage modules: 142

Assuming that this is unintentional, this patch helps a lot.

--- Makefile.orig       Sun Oct 29 09:09:16 2000
+++ Makefile    Tue Oct 31 11:39:11 2000
@@ -28,7 +28,7 @@
 #      kgcc for Conectiva and Red Hat 7
 #      otherwise 'cc'
 #
-CC     =$(shell if [ -n "$(CROSS_COMPILE)" ]; then echo $(CROSS_COMPILE)gcc; else \
+CC     :=$(shell if [ -n "$(CROSS_COMPILE)" ]; then echo $(CROSS_COMPILE)gcc; else \
        $(CONFIG_SHELL) scripts/kwhich gcc272 2>/dev/null || $(CONFIG_SHELL) scripts/kwhich kgcc 2>/dev/null || echo cc; fi) \
        -D__KERNEL__ -I$(HPATH)
 CPP    =$(CC) -E

(If it gets wrapped, it's just "=" -> ":=").

It's also interesting that make dep calls kwhich an odd number
of times including one case where it looked for "gcc." I suspect
a makefile isn't playing nice but I haven't looked for it.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
