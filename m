Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbULAEtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbULAEtk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 23:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbULAEtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 23:49:40 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:64962
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261205AbULAEti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 23:49:38 -0500
Date: Tue, 30 Nov 2004 20:46:44 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Martin Lucina <mato@kotelna.sk>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: OOPS in Linux 2.6.9, fib_release_info
Message-Id: <20041130204644.4319f974.davem@davemloft.net>
In-Reply-To: <20041201011612.GA3423@kotelna.sk>
References: <20041201011612.GA3423@kotelna.sk>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Dec 2004 02:16:12 +0100
Martin Lucina <mato@kotelna.sk> wrote:

> I have found a reproducible OOPS in fib_release_info, in the 2.6.9 kernel.
> Tested on two different systems, one UP, one SMP, both i386, both w/
> CONFIG_PREEMPT=y, both Debian sarge, both w/ iproute2 version 20010824-13.1
> (Debian).

Already fixed in 2.6.10 by this patch.

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/10/25 20:09:20-07:00 ehrhardt@mathematik.uni-ulm.de 
#   [IPV4]: Do not try to unhash null-netdev nexthops.
#   
#   Signed-off-by: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
# net/ipv4/fib_semantics.c
#   2004/10/25 20:09:01-07:00 ehrhardt@mathematik.uni-ulm.de +2 -0
#   [IPV4]: Do not try to unhash null-netdev nexthops.
#   
#   Signed-off-by: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
diff -Nru a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
--- a/net/ipv4/fib_semantics.c	2004-11-30 20:22:10 -08:00
+++ b/net/ipv4/fib_semantics.c	2004-11-30 20:22:10 -08:00
@@ -163,6 +163,8 @@
 		if (fi->fib_prefsrc)
 			hlist_del(&fi->fib_lhash);
 		change_nexthops(fi) {
+			if (!nh->nh_dev)
+				continue;
 			hlist_del(&nh->nh_hash);
 		} endfor_nexthops(fi)
 		fi->fib_dead = 1;
