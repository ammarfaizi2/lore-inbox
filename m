Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbUKMUIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbUKMUIV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 15:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbUKMUIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 15:08:21 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1285 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261162AbUKMUIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 15:08:10 -0500
Date: Sat, 13 Nov 2004 21:07:35 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Harald Welte <laforge@gnumonks.org>,
       "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, patrick@tykepenguin.com,
       linux-decnet-user@lists.sourceforge.net
Subject: [patch] 2.4.28-rc3: neigh_for_each must be EXPORT_SYMBOL'ed
Message-ID: <20041113200735.GD2249@stusta.de>
References: <20041112180052.GE23215@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041112180052.GE23215@logos.cnet>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the following error:

<--  snip  -->

depmod: *** Unresolved symbols in /lib/modules/2.4.28-rc3/kernel/net/decnet/decnet.o
depmod:         neigh_for_each

<--  snip  -->


This was caused by Harald's backport of the neighbour scalability fixes 
from 2.6 .


neigh_for_each must be EXPORT_SYMBOL'ed (as it is in 2.6):


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.4.28-rc3-modular/net/core/Makefile.old	2004-11-13 19:40:36.000000000 +0100
+++ linux-2.4.28-rc3-modular/net/core/Makefile	2004-11-13 19:40:50.000000000 +0100
@@ -9,7 +9,7 @@
 
 O_TARGET := core.o
 
-export-objs := netfilter.o profile.o ethtool.o
+export-objs := netfilter.o profile.o ethtool.o neighbour.o
 
 obj-y := sock.o skbuff.o iovec.o datagram.o scm.o
 
--- linux-2.4.28-rc3-modular/net/core/neighbour.c.old	2004-11-13 19:35:26.000000000 +0100
+++ linux-2.4.28-rc3-modular/net/core/neighbour.c	2004-11-13 19:35:59.000000000 +0100
@@ -1569,6 +1569,7 @@
 	}
 	read_unlock_bh(&tbl->lock);
 }
+EXPORT_SYMBOL(neigh_for_each);
 
 /* The tbl->lock must be held as a writer and BH disabled. */
 void __neigh_for_each_release(struct neigh_table *tbl,


