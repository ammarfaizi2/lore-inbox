Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312466AbSDNVPd>; Sun, 14 Apr 2002 17:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312476AbSDNVPc>; Sun, 14 Apr 2002 17:15:32 -0400
Received: from hera.cwi.nl ([192.16.191.8]:26367 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S312466AbSDNVPc>;
	Sun, 14 Apr 2002 17:15:32 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 14 Apr 2002 21:15:29 GMT
Message-Id: <UTC200204142115.VAA627059.aeb@cwi.nl>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] setup_per_cpu_areas in 2.5.8pre3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Now that I am writing anyway, one of the changes I needed
to compile 2.5.8pre3 is the following.

--- main.c~	Fri Apr 12 12:10:48 2002
+++ main.c	Sun Apr 14 16:11:33 2002
@@ -270,7 +270,9 @@
 #else
 #define smp_init()	do { } while (0)
 #endif
-
+static inline void setup_per_cpu_areas(void)
+{
+}
 #else
 
 #ifdef __GENERIC_PER_CPU

There is a nest of #ifdef's there, and in some branches
setup_per_cpu_areas() is not defined.

Of course the real fix is to remove the #ifdef's,
maybe using a weak symbol instead, or some other construction
that defines an empty default that can be replaced by an actual
routine.

Andries
