Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263528AbTLSQ6t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 11:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263564AbTLSQ6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 11:58:49 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:2506 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263528AbTLSQ6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 11:58:46 -0500
Date: Fri, 19 Dec 2003 17:58:38 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mac@melware.de,
       isdn4linux@listserv.isdn4linux.de, kkeil@suse.de,
       kai.germaschewski@gmx.de
Subject: [patch] 2.6.0-test11-mm1: isdn/eicon/eicon_mod.c doesn't compile
Message-ID: <20031219165837.GN12750@fs.tum.de>
References: <20031217014350.028460b2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031217014350.028460b2.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

I got the following compile error in 2.6.0-test11-mm1:

<--  snip  -->

...
  CC [M]  drivers/isdn/eicon/eicon_mod.o
drivers/isdn/eicon/eicon_mod.c: In function `eicon_exit':
drivers/isdn/eicon/eicon_mod.c:1362: warning: implicit declaration of 
function `mca_mark_as_unused'
drivers/isdn/eicon/eicon_mod.c: In function `eicon_mca_find_card':
drivers/isdn/eicon/eicon_mod.c:1500: warning: implicit declaration of 
function `mca_find_unused_adapter'
drivers/isdn/eicon/eicon_mod.c:1502: `MCA_NOTFOUND' undeclared (first 
use in this function)
drivers/isdn/eicon/eicon_mod.c:1502: (Each undeclared identifier is 
reported only once
drivers/isdn/eicon/eicon_mod.c:1502: for each function it appears in.)
drivers/isdn/eicon/eicon_mod.c: In function `eicon_mca_probe':
drivers/isdn/eicon/eicon_mod.c:1558: warning: implicit declaration of 
function `mca_read_stored_pos'
drivers/isdn/eicon/eicon_mod.c:1619: warning: implicit declaration of 
function `mca_set_adapter_name'
drivers/isdn/eicon/eicon_mod.c:1622: warning: implicit declaration of 
function `mca_mark_as_used'
make[3]: *** [drivers/isdn/eicon/eicon_mod.o] Error 1

<--  snip  -->


The fix is simple:


--- linux-2.6.0-test11-mm1-modular-no-smp/drivers/isdn/eicon/eicon_mod.c.old	2003-12-19 17:26:56.000000000 +0100
+++ linux-2.6.0-test11-mm1-modular-no-smp/drivers/isdn/eicon/eicon_mod.c	2003-12-19 17:28:29.000000000 +0100
@@ -29,6 +29,7 @@
 #include <linux/init.h>
 #ifdef CONFIG_MCA
 #include <linux/mca.h>
+#include <linux/mca-legacy.h>
 #endif /* CONFIG_MCA */
 
 #include "eicon.h"



Please apply
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

