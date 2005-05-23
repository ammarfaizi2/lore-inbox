Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVEWXpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVEWXpF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 19:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVEWX0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 19:26:39 -0400
Received: from fire.osdl.org ([65.172.181.4]:7814 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261250AbVEWX0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 19:26:03 -0400
Date: Mon, 23 May 2005 16:25:26 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, ralf@linux-mips.org,
       dsd@gentoo.org, davem@davemloft.net
Subject: [patch 08/16] [ROSE]: Fix minor security hole
Message-ID: <20050523232526.GT27549@shell0.pdx.osdl.net>
References: <20050523231529.GL27549@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050523231529.GL27549@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ROSE wasn't verifying the ndigis argument of a new route resulting in a
minor security hole.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 net/rose/rose_route.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.11.10.orig/net/rose/rose_route.c	2005-05-16 10:52:02.000000000 -0700
+++ linux-2.6.11.10/net/rose/rose_route.c	2005-05-20 09:36:34.381946976 -0700
@@ -727,7 +727,8 @@
 		}
 		if (rose_route.mask > 10) /* Mask can't be more than 10 digits */
 			return -EINVAL;
-
+		if (rose_route.ndigis > 8) /* No more than 8 digipeats */
+			return -EINVAL;
 		err = rose_add_node(&rose_route, dev);
 		dev_put(dev);
 		return err;

