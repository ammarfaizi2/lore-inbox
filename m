Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262699AbVDHGWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262699AbVDHGWn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 02:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbVDHGWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 02:22:43 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:897 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S262699AbVDHGWl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 02:22:41 -0400
X-ORBL: [67.117.73.34]
Date: Thu, 7 Apr 2005 23:22:01 -0700
From: Tony Lindgren <tony@atomide.com>
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: Frank Sorenson <frank@tuxrocks.com>, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pavel Machek <pavel@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>, Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Dynamic Tick version 050406-1
Message-ID: <20050408062200.GA4477@atomide.com>
References: <20050406083000.GA8658@atomide.com> <425451A0.7020000@tuxrocks.com> <20050407082136.GF13475@atomide.com> <1112865986.2344.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112865986.2344.2.camel@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alexander Nyberg <alexn@dsv.su.se> [050407 02:31]:
> > > > Here's an updated dyn-tick patch. Some minor fixes:
> > > 
> > > Doesn't look so good here.  I get this with 2.6.12-rc2 (plus a few other patches).
> > > Disabling Dynamic Tick makes everything happy again (it boots).
> > > 
> > > [4294688.655000] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> > 
> > Thanks for trying it out. What kind of hardware do you have? Does it
> > have HPET? It looks like no suitable timer for dyn-tick is found...
> > Maybe the following patch helps?
> 
> 
> ===== arch/i386/kernel/Makefile 1.67 vs edited =====
> --- 1.67/arch/i386/kernel/Makefile	2005-01-26 06:21:13 +01:00
> +++ edited/arch/i386/kernel/Makefile	2005-04-07 11:21:19 +02:00
> @@ -32,6 +32,7 @@ obj-$(CONFIG_ACPI_SRAT) 	+= srat.o
>  obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o
>  obj-$(CONFIG_EFI) 		+= efi.o efi_stub.o
>  obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
> +obj-$(CONFIG_NO_IDLE_HZ)	+= dyn-tick.o
>  
>  EXTRA_AFLAGS   := -traditional

Ah, that explains :) Thanks!

Tony
