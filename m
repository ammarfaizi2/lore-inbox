Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965127AbWEOS3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965127AbWEOS3B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 14:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965124AbWEOS3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 14:29:01 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:16609 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965127AbWEOS27 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 14:28:59 -0400
Date: Mon, 15 May 2006 20:28:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: apw@shadowen.org, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH] x86 NUMA panic compile error
Message-ID: <20060515182855.GB18652@elte.hu>
References: <20060515005637.00b54560.akpm@osdl.org> <20060515140811.GA23750@shadowen.org> <20060515175306.GA18185@elte.hu> <20060515110814.11c74d70.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060515110814.11c74d70.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > (which has nothing to do with x86_64 anyway)
> 
> True.
> 
> I guess the concern here is that we don't want people building these 
> frankenkernels and then sending us bug reports against them.

sure - lets simply turn it into a printk, as per the patch below.

it's not like we are being swamped with these bugreports, it seems i was 
the only one who tried. So lets not over-react it. (and the panic was 
the worst possible thing we could do.)

	Ingo

---

warn users that running CONFIG_NUMA on non-x440 boxes is barely tested.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 arch/i386/kernel/srat.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

Index: linux/arch/i386/kernel/srat.c
===================================================================
--- linux.orig/arch/i386/kernel/srat.c
+++ linux/arch/i386/kernel/srat.c
@@ -267,12 +267,9 @@ int __init get_memcfg_from_srat(void)
 	int i = 0;
 
 	extern int use_cyclone;
-	if (use_cyclone == 0) {
-		/* Make sure user sees something */
-		static const char s[] __initdata = "Not an IBM x440/NUMAQ. Don't use i386 CONFIG_NUMA anywhere else."
-		early_printk(s);
-		panic(s);
-	}
+	/* Make sure user sees something */
+	if (use_cyclone == 0)
+		printk(KERN_WARN "WARNING: Not an IBM x440/NUMAQ and CONFIG_NUMA enabled!\n");
 
 	if (ACPI_FAILURE(acpi_find_root_pointer(ACPI_PHYSICAL_ADDRESSING,
 						rsdp_address))) {
