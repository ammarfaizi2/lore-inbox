Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269598AbUI3WsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269598AbUI3WsA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 18:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269603AbUI3Wr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 18:47:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:36577 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269598AbUI3Wrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 18:47:49 -0400
Date: Thu, 30 Sep 2004 15:51:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: zwane@linuxpower.ca, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       asit.k.mallick@intel.com, ak@suse.de
Subject: Re: [Patch 0/2] Disable SW irqbalance/irqaffinity for
 E7520/E7320/E7525
Message-Id: <20040930155134.35cf1235.akpm@osdl.org>
In-Reply-To: <20040928141157.D18131@unix-os.sc.intel.com>
References: <20040923233410.A19555@unix-os.sc.intel.com>
	<Pine.LNX.4.53.0409241805020.2791@musoma.fsmlabs.com>
	<4154828F.6090205@pobox.com>
	<20040924152026.A25742@unix-os.sc.intel.com>
	<Pine.LNX.4.53.0409251206120.2914@musoma.fsmlabs.com>
	<20040927110350.C18131@unix-os.sc.intel.com>
	<20040928141157.D18131@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suresh Siddha <suresh.b.siddha@intel.com> wrote:
>
> --- linux-2.6.9-rc2/drivers/pci/quirks.c	2004-09-12 22:31:27.000000000 -0700
> +++ linux-irq/drivers/pci/quirks.c	2004-09-08 18:20:59.794026624 -0700
> @@ -814,6 +814,55 @@
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801DB_12,	asus_hides_smbus_lpc );
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801EB_0,	asus_hides_smbus_lpc );
>  
> +#if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_SMP)
> +#include <asm/hw_irq.h>
> +#ifdef CONFIG_IRQBALANCE
> +extern int irqbalance_disable(char *str);
> +#endif
> +extern int no_irq_affinity;
> +extern int noirqdebug_setup(char *str);

Please don't put extern declarations in .c files.  Try to find a suitable
header file which is included by both the definition and the users of these
variables/functions.

If there is no appropriate header file, feel free to create a new one.
