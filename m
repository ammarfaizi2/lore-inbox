Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262122AbSJZMfg>; Sat, 26 Oct 2002 08:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262128AbSJZMed>; Sat, 26 Oct 2002 08:34:33 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:7073 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S262119AbSJZMeb>;
	Sat, 26 Oct 2002 08:34:31 -0400
Date: Sat, 26 Oct 2002 13:42:28 +0100
Message-Id: <200210261242.g9QCgSDh030286@noodles.internal>
From: davej@codemonkey.org.uk
To: linux-kernel@vger.kernel.org
Cc: alan@redhat.com
Subject: [PATCH] max_cpus overflow.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Without the below patch, my HT 2-way prints out
"CPUS Done 4294967295" on boot, which whilst amusing
is somewhat exaggerated.


diff -urpN --exclude-from=/home/davej/.exclude bk-linus/init/main.c linux-2.5/init/main.c
--- bk-linus/init/main.c	2002-10-20 20:34:00.000000000 -0100
+++ linux-2.5/init/main.c	2002-10-25 15:43:43.000000000 -0100
@@ -100,7 +100,7 @@ int rows, cols;
 char *execute_command;
 
 /* Setup configured maximum number of CPUs to activate */
-static unsigned int max_cpus = UINT_MAX;
+static unsigned int max_cpus = NR_CPUS;
 
 /*
  * Setup routine for controlling SMP activation
