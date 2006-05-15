Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964928AbWEOOI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbWEOOI3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 10:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964930AbWEOOI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 10:08:29 -0400
Received: from 81-178-210-147.dsl.pipex.com ([81.178.210.147]:63969 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S964928AbWEOOI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 10:08:28 -0400
Date: Mon, 15 May 2006 15:08:11 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] x86 NUMA panic compile error
Message-ID: <20060515140811.GA23750@shadowen.org>
References: <20060515005637.00b54560.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <20060515005637.00b54560.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this check now needed given we have the zone alignment patches in
this -mm also?  I think we want to make it at least possible to
boot such a kernel on a 'flat' machine.

-apw

=== 8< ===
x86 NUMA panic compile error

Seem we have a syntax error rising from the the new panic added
to let people know NUMA didn't work on physically non-numa hardware.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 srat.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
diff -upN reference/arch/i386/kernel/srat.c current/arch/i386/kernel/srat.c
--- reference/arch/i386/kernel/srat.c
+++ current/arch/i386/kernel/srat.c
@@ -269,7 +269,7 @@ int __init get_memcfg_from_srat(void)
 	extern int use_cyclone;
 	if (use_cyclone == 0) {
 		/* Make sure user sees something */
-		static const char s[] __initdata = "Not an IBM x440/NUMAQ. Don't use i386 CONFIG_NUMA anywhere else."
+		static const char s[] __initdata = "Not an IBM x440/NUMAQ. Don't use i386 CONFIG_NUMA anywhere else.";
 		early_printk(s);
 		panic(s);
 	}
