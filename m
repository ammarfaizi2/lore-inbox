Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269501AbUHZUJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269501AbUHZUJY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269549AbUHZUG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:06:26 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:14308 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S269546AbUHZUAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:00:45 -0400
Date: Thu, 26 Aug 2004 21:59:43 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, irda-users@lists.sourceforge.net,
       Dag Brattli <dagb@cs.uit.no>
Subject: [2.4 patch][3/6] ircomm_param.c: fix __FUNCTION__ paste error
Message-ID: <20040826195943.GE12772@fs.tum.de>
References: <20040826195133.GB12772@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826195133.GB12772@fs.tum.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile error when trying to build 2.4.28-pre2 using
gcc 3.4:

<--  snip  -->

...
gcc-3.4 -D__KERNEL__ 
-I/home/bunk/linux/kernel-2.4/linux-2.4.28-pre2-full/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon 
-fno-unit-at-a-time   -nostdinc -iwithprefix include 
-DKBUILD_BASENAME=ircomm_param  -c -o ircomm_param.o ircomm_param.c
ircomm_param.c: In function `ircomm_param_service_type':
ircomm_param.c:201: error: parse error before "__FUNCTION__"
make[4]: *** [ircomm_param.o] Error 1
make[4]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.28-pre2-full/net/irda/ircomm'

<--  snip  -->

 
The patch below fixes this issue by removing the superfluous 
__FUNCTION__ (similar to how it is in 2.6).


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.4.28-pre2-full/net/irda/ircomm/ircomm_param.c.old	2004-08-26 19:28:00.000000000 +0200
+++ linux-2.4.28-pre2-full/net/irda/ircomm/ircomm_param.c	2004-08-26 19:29:46.000000000 +0200
@@ -198,7 +198,7 @@
 		IRDA_DEBUG(2, "%s(), No common service type to use!\n", __FUNCTION__);
 		return -1;
 	}
-	IRDA_DEBUG(0, __FUNCTION__ "%s(), services in common=%02x\n", __FUNCTION__,
+	IRDA_DEBUG(0, "%s(), services in common=%02x\n", __FUNCTION__ ,
 		   service_type);
 
 	/*
