Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268111AbUH3H4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268111AbUH3H4Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 03:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267801AbUH3H4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 03:56:24 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:62701 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S268111AbUH3Hz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 03:55:58 -0400
Date: Mon, 30 Aug 2004 09:55:29 +0200
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Andrew Morton <akpm@osdl.org>, linux.nics@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: e1000 driver failed to call pci_enable_device
Message-ID: <20040830075529.GA1990@frec.bull.fr>
References: <20040827114408.GA6490@frec.bull.fr> <200408270942.57621.bjorn.helgaas@hp.com>
Mime-Version: 1.0
In-Reply-To: <200408270942.57621.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.5.6+20040722i
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/08/2004 10:00:48,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 30/08/2004 10:00:51,
	Serialize complete at 30/08/2004 10:00:51
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 09:42:57AM -0600, Bjorn Helgaas wrote:
> On Friday 27 August 2004 5:44 am, you wrote:
> >  I tried to boot the linux-2.6.9-rc1-mm1 kernel and it generates an oops
> > because the e1000 driver failed to call pci_enable_device(). The kernel
> > boots normally with "pci=routeirq" argument sets. I copy the output of
> > "lspci" and also the oops message generated during the boot.
> Thanks very much for your testing and detailed problem report.  This
> problem actually isn't in e1000.  Can you try the attached patch,
> please?  I thought I'd seen this patch before, but it doesn't seem to
> be in -mm yet.
> 
> Make assign_irq_vector() non-__init always (it's called from
> io_apic_set_pci_routing(), which is used in the pci_enable_device()
> path).
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
> ===== arch/i386/kernel/io_apic.c 1.109 vs edited =====
> --- 1.109/arch/i386/kernel/io_apic.c	2004-08-24 03:08:37 -06:00
> +++ edited/arch/i386/kernel/io_apic.c	2004-08-27 09:30:37 -06:00
> @@ -1120,11 +1120,7 @@
>  /* irq_vectors is indexed by the sum of all RTEs in all I/O APICs. */
>  u8 irq_vector[NR_IRQ_VECTORS] = { FIRST_DEVICE_VECTOR , 0 };
>  
> -#ifdef CONFIG_PCI_MSI
>  int assign_irq_vector(int irq)
> -#else
> -int __init assign_irq_vector(int irq)
> -#endif
>  {
>  	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;

The patch fixes the problem. Everything works fine.
Thank you very much for your help

Best regards,
Guillaume
