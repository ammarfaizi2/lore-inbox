Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbWGQQjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbWGQQjA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbWGQQiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:38:20 -0400
Received: from mail.kroah.org ([69.55.234.183]:44476 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750990AbWGQQdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:33:41 -0400
Date: Mon, 17 Jul 2006 09:26:29 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Santiago Garcia Mantinan <manty@manty.net>,
       Chris Wright <chrisw@sous-sol.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 09/45] pnp: suppress request_irq() warning
Message-ID: <20060717162629.GJ4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pnp-suppress-request_irq-warning.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
Suppress the "setup_irq: irq handler mismatch" coming out of pnp_check_irq():
failures are expected here.

Cc: Santiago Garcia Mantinan <manty@manty.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/pnp/resource.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.17.3.orig/drivers/pnp/resource.c
+++ linux-2.6.17.3/drivers/pnp/resource.c
@@ -396,7 +396,8 @@ int pnp_check_irq(struct pnp_dev * dev, 
 	/* check if the resource is already in use, skip if the
 	 * device is active because it itself may be in use */
 	if(!dev->active) {
-		if (request_irq(*irq, pnp_test_handler, SA_INTERRUPT, "pnp", NULL))
+		if (request_irq(*irq, pnp_test_handler,
+				SA_INTERRUPT|SA_PROBEIRQ, "pnp", NULL))
 			return 0;
 		free_irq(*irq, NULL);
 	}

--
