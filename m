Return-Path: <linux-kernel-owner+w=401wt.eu-S932651AbXAHUcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932651AbXAHUcP (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 15:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbXAHUcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 15:32:15 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:2469 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932651AbXAHUcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 15:32:14 -0500
Date: Mon, 8 Jan 2007 21:32:12 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] update MMConfig patches w/915 support
Message-ID: <20070108203212.GA15481@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-kernel@vger.kernel.org,
	Arjan van de Ven <arjan@infradead.org>
References: <200701071142.09428.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701071142.09428.jbarnes@virtuousgeek.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2007 at 11:42:09AM -0800, Jesse Barnes wrote:
> This patch updates Oliver's MMConfig bridge detection patches with support
> for 915G bridges.  It seems to work ok on my 915GM laptop.

Looks ok to me.


> I also tried adding 965 support, but it doesn't work (at least not on my
> G965 box).  When I enable MMConfig support when the register value is
> 0xf00000003 (should be a 256M enabled window at 0xf0000000) the box hangs
> at boot, so I'm not sure what I'm doing wrong...
> 
> The routines could probably be consolidated into a single probe_intel_9xx
> routine or something, but I really looked at that yet (though there are
> many similarities between the 91[05], 945 and 965 families, they may not
> be enough that the code would actually be simpler if shared.

The individual functions are so simple, it's probably way better for
maintainance simplicity to keep them separate, at least for now.


> +	pci_conf1_read(0, 0, PCI_DEVFN(0,0), 0x48, 4, &pciexbar);
> +
> +	/* No enable bit or size field, so assume 256M range is enabled. */
> +	len = 0x10000000U;
> +	pci_mmcfg_config_num = 1;
> +
> +	pci_mmcfg_config = kzalloc(sizeof(pci_mmcfg_config[0]), GFP_KERNEL);
> +	pci_mmcfg_config[0].base_address = pciexbar;

Hmmm, I'd mask out the reserved bits if I were you.  Paranoia :-)

  OG.
