Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbVEJNSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbVEJNSk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 09:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVEJNSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 09:18:40 -0400
Received: from ns2.suse.de ([195.135.220.15]:12191 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261638AbVEJNSi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 09:18:38 -0400
From: Andreas Schwab <schwab@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>
Subject: Re: [PATCH] Fix PCI mmap on ppc and ppc64
References: <1115700814.6157.7.camel@gaston>
X-Yow: I'm meditating on the FORMALDEHYDE and the ASBESTOS leaking into my
 PERSONAL SPACE!!
Date: Tue, 10 May 2005 15:18:35 +0200
In-Reply-To: <1115700814.6157.7.camel@gaston> (Benjamin Herrenschmidt's
	message of "Tue, 10 May 2005 14:53:33 +1000")
Message-ID: <je8y2nqkwk.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> @@ -351,9 +351,12 @@
>  		*offset += hose->pci_mem_offset;
>  		res_bit = IORESOURCE_MEM;
>  	} else {
> -		io_offset = (unsigned long)hose->io_base_virt;
> +		io_offset = (unsigned long)hose->io_base_virt - pci_io_base;
> +		printk("offset: %lx, io_base_virt: %p, pci_io_base: %lx, io_offset: %
> lx\n",
> +		       *offset, hose->io_base_virt, pci_io_base, io_offset);
>  		*offset += io_offset;
>  		res_bit = IORESOURCE_IO;
> +		printk(" -> offset: %lx\n", *offset);

I don't think you want those debugging printks be left here.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
