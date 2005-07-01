Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbVGAXGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbVGAXGe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 19:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbVGAXGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 19:06:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5101 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261626AbVGAXG3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 19:06:29 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17093.52338.481897.207125@segfault.boston.redhat.com>
Date: Fri, 1 Jul 2005 19:06:26 -0400
To: mpm@selenic.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [rfc | patch 0/6] netpoll: add support for the bonding driver
In-Reply-To: <17093.52306.136742.190912@segfault.boston.redhat.com>
References: <17093.52306.136742.190912@segfault.boston.redhat.com>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize npinfo->rx_flags.  The way it stands now, this will have random
garbage, and so will incur a locking penalty even when an rx_hook isn't
registered and we are not active in the netpoll polling code.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
---

--- linux-2.6.12/net/core/netpoll.c.orig	2005-07-01 14:02:56.039174635 -0400
+++ linux-2.6.12/net/core/netpoll.c	2005-07-01 14:03:16.688739508 -0400
@@ -639,6 +639,7 @@ int netpoll_setup(struct netpoll *np)
 		if (!npinfo)
 			goto release;
 
+		npinfo->rx_flags = 0;
 		npinfo->rx_np = NULL;
 		npinfo->poll_lock = SPIN_LOCK_UNLOCKED;
 		npinfo->poll_owner = -1;
