Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965178AbWEOTGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965178AbWEOTGx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 15:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965162AbWEOTGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 15:06:53 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:60599 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932343AbWEOTGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 15:06:51 -0400
Date: Mon, 15 May 2006 21:06:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: apw@shadowen.org, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH] x86 NUMA panic compile error
Message-ID: <20060515190645.GA21899@elte.hu>
References: <20060515005637.00b54560.akpm@osdl.org> <20060515140811.GA23750@shadowen.org> <20060515175306.GA18185@elte.hu> <20060515110814.11c74d70.akpm@osdl.org> <20060515182855.GB18652@elte.hu> <20060515115208.57a11dcb.akpm@osdl.org> <20060515185657.GA19888@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060515185657.GA19888@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> updated patch below. Or lets drop the original patch that adds the 
> panic?

another update: s/KERN_WARN/KERN_WARNING ...

	Ingo

---

re-enable dummy NUMA on i386.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 arch/i386/kernel/srat.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

Index: linux/arch/i386/kernel/srat.c
===================================================================
--- linux.orig/arch/i386/kernel/srat.c
+++ linux/arch/i386/kernel/srat.c
@@ -266,13 +266,12 @@ int __init get_memcfg_from_srat(void)
 	int tables = 0;
 	int i = 0;
 
+#ifdef CONFIG_X86_CYCLONE_TIMER
 	extern int use_cyclone;
-	if (use_cyclone == 0) {
-		/* Make sure user sees something */
-		static const char s[] __initdata = "Not an IBM x440/NUMAQ. Don't use i386 CONFIG_NUMA anywhere else."
-		early_printk(s);
-		panic(s);
-	}
+	/* Make sure user sees something */
+	if (use_cyclone == 0)
+#endif
+		printk(KERN_WARNING "WARNING: Not an IBM x440/NUMAQ and CONFIG_NUMA enabled!\n");
 
 	if (ACPI_FAILURE(acpi_find_root_pointer(ACPI_PHYSICAL_ADDRESSING,
 						rsdp_address))) {
