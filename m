Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262107AbSJZMeb>; Sat, 26 Oct 2002 08:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262128AbSJZMeb>; Sat, 26 Oct 2002 08:34:31 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:6561 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S262107AbSJZMea>;
	Sat, 26 Oct 2002 08:34:30 -0400
Date: Sat, 26 Oct 2002 13:42:28 +0100
Message-Id: <200210261242.g9QCgSp7030268@noodles.internal>
To: linux-kernel@vger.kernel.org
From: davej@codemonkey.org.uk
Cc: alan@redhat.com
Subject: [PATCH] Clean up capabilities printing.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The machine check initialisation prints some blurb
which makes the capabilities dumping a little untidy.
By initialising it slightly later, we get something that
looks a lot better.

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/cpu/common.c linux-2.5/arch/i386/kernel/cpu/common.c
--- bk-linus/arch/i386/kernel/cpu/common.c	2002-10-20 20:21:24.000000000 -0100
+++ linux-2.5/arch/i386/kernel/cpu/common.c	2002-10-25 15:39:26.000000000 -0100
@@ -315,9 +315,6 @@ void __init identify_cpu(struct cpuinfo_
 		clear_bit(X86_FEATURE_XMM, c->x86_capability);
 	}
 
-	/* Init Machine Check Exception if available. */
-	mcheck_init(c);
-
 	/* If the model name is still unset, do table lookup. */
 	if ( !c->x86_model_id[0] ) {
 		char *p;
@@ -355,6 +352,9 @@ void __init identify_cpu(struct cpuinfo_
 	       boot_cpu_data.x86_capability[1],
 	       boot_cpu_data.x86_capability[2],
 	       boot_cpu_data.x86_capability[3]);
+
+	/* Init Machine Check Exception if available. */
+	mcheck_init(c);
 }
 /*
  *	Perform early boot up checks for a valid TSC. See arch/i386/kernel/time.c
