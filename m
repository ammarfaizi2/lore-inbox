Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319586AbSIMJq3>; Fri, 13 Sep 2002 05:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319588AbSIMJq2>; Fri, 13 Sep 2002 05:46:28 -0400
Received: from ipx.zarz.agh.edu.pl ([149.156.125.1]:57092 "EHLO
	zarz.agh.edu.pl") by vger.kernel.org with ESMTP id <S319586AbSIMJq2>;
	Fri, 13 Sep 2002 05:46:28 -0400
Date: Fri, 13 Sep 2002 11:35:56 +0200 (CEST)
From: "Wojciech \"Sas\" Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: 2.4.19, PPC and AGP
In-Reply-To: <Pine.LNX.4.44.0209122313470.30211-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.44L.0209131115460.5612-100000@alpha.zarz.agh.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I try to compile 2.4.19 [2.4.20-pre7 too] on PPC.
But in file drivers/char/agp/agpgart_be.c in function flush_cache 
line 68-86 isn't defined PowerPC.

Thanx.
					Sas.
Here is small patch to fix this:

--- linux-2.4.19/drivers/char/agp/agpgart_be.c.org	Fri Sep 13 10:26:51 2002
+++ linux-2.4.19/drivers/char/agp/agpgart_be.c	Fri Sep 13 10:26:29 2002
@@ -69,7 +69,7 @@
 {
 #if defined(__i386__) || defined(__x86_64__)
 	asm volatile ("wbinvd":::"memory");
-#elif defined(__alpha__) || defined(__ia64__) || defined(__sparc__)
+#elif defined(__alpha__) || defined(__ia64__) || defined(__sparc__) || defined(__powerpc__)
 	/* ??? I wonder if we'll really need to flush caches, or if the
 	   core logic can manage to keep the system coherent.  The ARM
 	   speaks only of using `cflush' to get things in memory in


-- 
{Wojciech 'Sas' Cieciwa}  {Member of PLD Team                               }
{e-mail: cieciwa@alpha.zarz.agh.edu.pl, http://www2.zarz.agh.edu.pl/~cieciwa}


