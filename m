Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVFAUq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVFAUq3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 16:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVFAUp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 16:45:29 -0400
Received: from fire.osdl.org ([65.172.181.4]:14810 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261212AbVFAUh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 16:37:59 -0400
Date: Wed, 1 Jun 2005 13:37:57 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/3] RapidIO support: core
Message-ID: <20050601133757.624059c4@dxpl.pdx.osdl.net>
In-Reply-To: <20050601110836.A16559@cox.net>
References: <20050601110836.A16559@cox.net>
Organization: Open Source Development Lab
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quick review comments:


1. Why hack up vmlinux.lds.h? wouldn't declaring rio_route_ops
to be a constant do what you want?


2. Unnecessary initializers

+struct bus_type rio_bus_type = {
+	.name = "rapidio",
+	.match = rio_match_bus,
+	.suspend = NULL,
+	.resume = NULL,

	NULL is unnecessary here.


3. Use existing macro's

+#define DEBUG
+
+#ifdef DEBUG
+#define DBG(x...) printk(x)
+#else
+#define DBG(x...)
+#endif
+

	Use pr_debug() and isn't this debugged yet?

4. Lists should be static if possible

+
+LIST_HEAD(rio_mports);
	static LIST_HEAD(rio_mports)

5. rio_nets defined but not used (if it is used later then
   make it visible to only that code.)

6. rio_net_lock does it need to be global.
   also maybe a name change to rio_global_list_lock


