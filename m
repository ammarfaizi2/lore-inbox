Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312982AbSDJMfG>; Wed, 10 Apr 2002 08:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312983AbSDJMfF>; Wed, 10 Apr 2002 08:35:05 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:64011 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S312982AbSDJMfF>; Wed, 10 Apr 2002 08:35:05 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: 2.5.8-pre3 linking error
Date: 10 Apr 2002 10:42:38 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrnab85ou.pn6.kraxel@bytesex.org>
In-Reply-To: <3CB418B7.BB5CFEB9@delusion.de>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 1018435358 26343 127.0.0.1 (10 Apr 2002 10:42:38 GMT)
User-Agent: slrn/0.9.7.1 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Udo A. Steinberg wrote:
>  
>  Hi,
>  
>  2.5.8-pre3 fails to link here:
>  
>  init/main.o: In function `start_kernel':
>  init/main.o(.text.init+0x681): undefined reference to `setup_per_cpu_areas'

Rusty patch deleted setup_per_cpu_areas() for the UP case.  The patch
below simply adds it again.

  Gerd

===== main.c 1.39 vs edited =====
--- 1.39/init/main.c	Fri Mar 15 15:01:31 2002
+++ edited/main.c	Wed Apr 10 13:11:56 2002
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
