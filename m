Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932526AbVIHQil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbVIHQil (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 12:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbVIHQil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 12:38:41 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:14813 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932526AbVIHQik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 12:38:40 -0400
Date: Thu, 8 Sep 2005 09:38:40 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>
Subject: [PATCH 2.6.13] x86_64: Add notify_die() to another spot in do_page_fault()
Message-ID: <20050908163840.GR3966@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a call to notify_die() in the "no context" portion of
do_page_fault() as someone on the chain might care and want to do a fixup.

---

 linux-2.6.13-trini/arch/x86_64/mm/fault.c |    4 ++++
 1 files changed, 4 insertions(+)

diff -puN arch/x86_64/mm/fault.c~x86_64-no_context_hook arch/x86_64/mm/fault.c
--- linux-2.6.13/arch/x86_64/mm/fault.c~x86_64-no_context_hook	2005-09-01 12:00:43.000000000 -0700
+++ linux-2.6.13-trini/arch/x86_64/mm/fault.c	2005-09-01 12:00:43.000000000 -0700
@@ -514,6 +514,10 @@ no_context:
 	if (is_errata93(regs, address))
 		return; 
 
+	if (notify_die(DIE_PAGE_FAULT, "no context", regs, error_code, 14,
+				SIGSEGV) == NOTIFY_STOP)
+		return;
+
 /*
  * Oops. The kernel tried to access some bad page. We'll have to
  * terminate things with extreme prejudice.

-- 
Tom Rini
http://gate.crashing.org/~trini/
