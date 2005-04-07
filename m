Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262403AbVDGJ1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbVDGJ1X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 05:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262313AbVDGJ1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 05:27:21 -0400
Received: from mailfe03.swip.net ([212.247.154.65]:23245 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262403AbVDGJ03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 05:26:29 -0400
X-T2-Posting-ID: dB8bZLHXm6KAmbp1mi7F+A==
Subject: Re: [PATCH] Dynamic Tick version 050406-1
From: Alexander Nyberg <alexn@dsv.su.se>
To: Tony Lindgren <tony@atomide.com>
Cc: Frank Sorenson <frank@tuxrocks.com>, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pavel Machek <pavel@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>, Thomas Renninger <trenn@suse.de>
In-Reply-To: <20050407082136.GF13475@atomide.com>
References: <20050406083000.GA8658@atomide.com>
	 <425451A0.7020000@tuxrocks.com>  <20050407082136.GF13475@atomide.com>
Content-Type: text/plain
Date: Thu, 07 Apr 2005 11:26:26 +0200
Message-Id: <1112865986.2344.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Here's an updated dyn-tick patch. Some minor fixes:
> > 
> > Doesn't look so good here.  I get this with 2.6.12-rc2 (plus a few other patches).
> > Disabling Dynamic Tick makes everything happy again (it boots).
> > 
> > [4294688.655000] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> 
> Thanks for trying it out. What kind of hardware do you have? Does it
> have HPET? It looks like no suitable timer for dyn-tick is found...
> Maybe the following patch helps?


===== arch/i386/kernel/Makefile 1.67 vs edited =====
--- 1.67/arch/i386/kernel/Makefile	2005-01-26 06:21:13 +01:00
+++ edited/arch/i386/kernel/Makefile	2005-04-07 11:21:19 +02:00
@@ -32,6 +32,7 @@ obj-$(CONFIG_ACPI_SRAT) 	+= srat.o
 obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o
 obj-$(CONFIG_EFI) 		+= efi.o efi_stub.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
+obj-$(CONFIG_NO_IDLE_HZ)	+= dyn-tick.o
 
 EXTRA_AFLAGS   := -traditional
 


