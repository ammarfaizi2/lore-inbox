Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265574AbSJSJPQ>; Sat, 19 Oct 2002 05:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265575AbSJSJPQ>; Sat, 19 Oct 2002 05:15:16 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:39300 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S265574AbSJSJPP>; Sat, 19 Oct 2002 05:15:15 -0400
Date: Sat, 19 Oct 2002 11:21:10 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Adam Belay <ambx1@neo.rr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.44] pnp compilation fix.
Message-ID: <20021019092110.GA6138@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Adam Belay <ambx1@neo.rr.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

crusoe:~/kernel/linux-2.5 2 > grep PNP .config
CONFIG_PNP=y
CONFIG_PNP_NAMES=y
# CONFIG_PNP_DEBUG is not set
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_IP_PNP is not set

When using this config (maybe a little bit unusual to have PNP
defined but non ISAPNP, but anyway), the code in drivers/pnp/compat.c
tries to access the global isapnp variables, which are ifdef'ed out.

The attached patch fix the compilation, but maybe excluding the whole
compat.c file from compilation when ISAPNP is not defined (maybe by
moving it to isapnp/) would be a more proper fix.


===== drivers/pnp/compat.c 1.1 vs edited =====
--- 1.1/drivers/pnp/compat.c	Sat Oct 19 01:50:26 2002
+++ edited/drivers/pnp/compat.c	Sat Oct 19 10:09:16 2002
@@ -31,6 +31,7 @@
 				 unsigned short device,
 				 struct pnp_card *from)
 {
+#if CONFIG_ISAPNP
 	char id[7];
 	char any[7];
 	struct list_head *list;
@@ -46,6 +47,7 @@
 			return card;
 		list = list->next;
 	}
+#endif
 	return NULL;
 }
 

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
