Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266708AbTADEkH>; Fri, 3 Jan 2003 23:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266716AbTADEkH>; Fri, 3 Jan 2003 23:40:07 -0500
Received: from relief.getitback.org ([208.49.116.17]:40712 "EHLO
	relief.getitback.org") by vger.kernel.org with ESMTP
	id <S266708AbTADEkG>; Fri, 3 Jan 2003 23:40:06 -0500
Date: Fri, 3 Jan 2003 23:48:14 -0500
From: Paul <set@pobox.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCHSET] New Year's Linux 2.4.21-pre2-jam2
Message-ID: <20030104044814.GN1732@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>,
	"J.A. Magallon" <jamagallon@able.es>,
	Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <20030104012243.GA1541@werewolf.able.es>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <20030104012243.GA1541@werewolf.able.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

"J.A. Magallon" <jamagallon@able.es>, on Sat Jan 04, 2003 [02:22:43 AM] said:
> HI, and HAPPY NEW YEAR to everybody !!
> 
> New release of this kinda-hacked-kernel. Now that Andre's ide and many bugfixes
> are in mainline, there is hole for more things ;)
> 03-memparam.bz2
>     Fix mem=XXX kernel parameter when user gives a size bigger than what
>     kernel autodetected (kill a previous change)
>     Author: Adrian Bunk <bunk@fs.tum.de>,
>             Leonardo Gomes Figueira <sabbath@planetarium.com.br>
> 
> 
> Enjoy!!
> 
> -- 
> J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:

	Hi;

	This reversion should probably kill limit_regions()
too... as I think it eliminates the only reference to it.

Paul
set@pobox.com

--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=03-memparam-extra

--- 2.4.20-mem/arch/i386/kernel/setup.c.orig	2003-01-03 23:08:41.000000000 -0500
+++ 2.4.20-mem/arch/i386/kernel/setup.c	2003-01-03 23:09:34.000000000 -0500
@@ -418,22 +418,6 @@
 	}
 }
 
-static void __init limit_regions (unsigned long long size)
-{
-	unsigned long long current_addr = 0;
-	int i;
-
-	for (i = 0; i < e820.nr_map; i++) {
-		if (e820.map[i].type == E820_RAM) {
-			current_addr = e820.map[i].addr + e820.map[i].size;
-			if (current_addr >= size) {
-				e820.map[i].size -= current_addr-size;
-				e820.nr_map = i + 1;
-				return;
-			}
-		}
-	}
-}
 static void __init add_memory_region(unsigned long long start,
                                   unsigned long long size, int type)
 {

--qDbXVdCdHGoSgWSk--
