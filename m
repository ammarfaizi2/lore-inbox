Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266187AbUITXOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266187AbUITXOf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 19:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266910AbUITXOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 19:14:34 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:55457 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S266187AbUITXOc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 19:14:32 -0400
Subject: [PATCH] Warn people that ipchains and ipfwadm are going away.
From: "Rusty Russell (IBM)" <rusty@au1.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: netfilter-devel@lists.netfilter.org,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain
Organization: IBM
Message-Id: <1095721742.5886.128.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 21 Sep 2004 09:09:02 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: Warn that ipchains and ipfwadm are going away
Status: Trivial
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

At the recent netfilter workshop in Erlangen, we was decided to remove
the backwards compatibility code for ipchains and ipfwadm.  This will
allow significant cleanup of interfaces, since we had to have a
mid-level interface for the backwards compatibility layer to use.

Start off with a warning for 2.6.9, so any remaining users have a
chance to migrate.  Their firewall scripts might not check return
values, and they might get a nasty surprise when this goes away.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5978-linux-2.6.9-rc2-bk6/net/ipv4/netfilter/ipchains_core.c .5978-linux-2.6.9-rc2-bk6.updated/net/ipv4/netfilter/ipchains_core.c
--- .5978-linux-2.6.9-rc2-bk6/net/ipv4/netfilter/ipchains_core.c	2004-09-16 00:17:16.000000000 +1000
+++ .5978-linux-2.6.9-rc2-bk6.updated/net/ipv4/netfilter/ipchains_core.c	2004-09-21 09:06:07.000000000 +1000
@@ -1,3 +1,5 @@
+#warning ipchains is obsolete, and will be removed soon.
+
 /* Minor modifications to fit on compatibility framework:
    Rusty.Russell@rustcorp.com.au
 */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .5978-linux-2.6.9-rc2-bk6/net/ipv4/netfilter/ipfwadm_core.c .5978-linux-2.6.9-rc2-bk6.updated/net/ipv4/netfilter/ipfwadm_core.c
--- .5978-linux-2.6.9-rc2-bk6/net/ipv4/netfilter/ipfwadm_core.c	2004-09-16 00:17:16.000000000 +1000
+++ .5978-linux-2.6.9-rc2-bk6.updated/net/ipv4/netfilter/ipfwadm_core.c	2004-09-21 09:06:18.000000000 +1000
@@ -1,3 +1,5 @@
+#warning ipfwadm is obsolete, and will be removed soon.
+
 /* Minor modifications to fit on compatibility framework:
    Rusty.Russell@rustcorp.com.au
 */


