Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275029AbTHAEUV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 00:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275037AbTHAEUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 00:20:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:53192 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S275029AbTHAEUU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 00:20:20 -0400
Date: Thu, 31 Jul 2003 21:21:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michael Bakos <bakhos@msi.umn.edu>
Cc: linux-kernel@vger.kernel.org, Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: compile error for Opteron CPU with kernel 2.6.0-test2
Message-Id: <20030731212105.75fb4191.akpm@osdl.org>
In-Reply-To: <Pine.SGI.4.33.0307312127190.23643-100000@ir12.msi.umn.edu>
References: <20030731182705.5b4f2b33.akpm@osdl.org>
	<Pine.SGI.4.33.0307312127190.23643-100000@ir12.msi.umn.edu>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Bakos <bakhos@msi.umn.edu> wrote:
>
> that patch did fix the cpumask_t problem, however another one is present
> 
>    CC      arch/x86_64/kernel/mpparse.o
>  arch/x86_64/kernel/mpparse.c: In function `mp_parse_prt':
>  arch/x86_64/kernel/mpparse.c:899: error: too few arguments to function
>  `acpi_pci_link_get_irq'
>  make[1]: *** [arch/x86_64/kernel/mpparse.o] Error 1
>  make: *** [arch/x86_64/kernel] Error 2

OK, I'd be doing this:

 arch/x86_64/kernel/mpparse.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN arch/x86_64/kernel/mpparse.c~nforce2-acpi-fixes-fix arch/x86_64/kernel/mpparse.c
--- 25/arch/x86_64/kernel/mpparse.c~nforce2-acpi-fixes-fix	2003-07-31 21:18:45.000000000 -0700
+++ 25-akpm/arch/x86_64/kernel/mpparse.c	2003-07-31 21:18:59.000000000 -0700
@@ -896,7 +896,8 @@ void __init mp_parse_prt (void)
 
 		/* Need to get irq for dynamic entry */
 		if (entry->link.handle) {
-			irq = acpi_pci_link_get_irq(entry->link.handle, entry->link.index);
+			irq = acpi_pci_link_get_irq(entry->link.handle,
+				entry->link.index, NULL, NULL);
 			if (!irq)
 			continue;
 		}

_

