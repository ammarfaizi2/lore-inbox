Return-Path: <linux-kernel-owner+w=401wt.eu-S1751229AbXAPTTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbXAPTTG (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 14:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbXAPTTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 14:19:05 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:4801 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751229AbXAPTTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 14:19:04 -0500
Date: Tue, 16 Jan 2007 20:19:02 +0100
From: Olivier Galibert <galibert@pobox.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@linux.intel.com>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] MMCONFIG: Reject a broken MCFG tables on Asus etc
Message-ID: <20070116191902.GA4192@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Andrew Morton <akpm@osdl.org>,
	Arjan van de Ven <arjan@linux.intel.com>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org
References: <87hcuusjm1.fsf@duaron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87hcuusjm1.fsf@duaron.myhome.or.jp>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14, 2007 at 06:27:18AM +0900, OGAWA Hirofumi wrote:
> This rejects a broken MCFG tables on Asus etc.
> Arjan and Andi suggest this.

And I agree completely with the principle.  If you don't know the
chipset on a first-name basis, trash the MCFG unless it's squeaky
clean (or you don't have a choice).


> +static void __init pci_mmcfg_reject_broken(void)
> +{
> +	struct acpi_table_mcfg_config *cfg = &pci_mmcfg_config[0];
> +
> +	/*
> +	 * Handle more broken MCFG tables on Asus etc.
> +	 * They only contain a single entry for bus 0-0.
> +	 */
> +	if (pci_mmcfg_config_num == 1 &&
> +	    cfg->pci_segment_group_number == 0 &&
> +	    (cfg->start_bus_number | cfg->end_bus_number) == 0) {
> +		kfree(pci_mmcfg_config);
> +		pci_mmcfg_config = NULL;
> +		pci_mmcfg_config_num = 0;
> +
> +		printk(KERN_ERR "PCI: start and end of bus number is 0. "
> +		       "Rejected as broken MCFG.");
> +	}
> +}
> +

If you're going to do a MCFG validation function, and I don't have a
problem with that, you should put the e820 test in it too.

  OG.
