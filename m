Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964993AbVKGVki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbVKGVki (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965151AbVKGVkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:40:37 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:14991 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964993AbVKGVkf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:40:35 -0500
Message-ID: <436FC9D0.4060803@us.ibm.com>
Date: Mon, 07 Nov 2005 15:40:32 -0600
From: Brian King <brking@us.ibm.com>
Reply-To: brking@us.ibm.com
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linas <linas@austin.ibm.com>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       bluesmoke-devel@lists.sourceforge.net,
       Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 2/7]: Revised [PATCH 27/42]: SCSI: add PCI error recovery
 to IPR dev driver
References: <20051103235918.GA25616@mail.gnucash.org> <20051104005035.GA26929@mail.gnucash.org> <20051105061114.GA27016@kroah.com> <17262.37107.857718.184055@cargo.ozlabs.ibm.com> <20051107175541.GB19593@austin.ibm.com> <20051107182727.GD18861@kroah.com> <20051107195727.GF19593@austin.ibm.com> <20051107213003.GI19593@austin.ibm.com>
In-Reply-To: <20051107213003.GI19593@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linas wrote:
> +/** ipr_eeh_slot_reset - called when pci slot has been reset.
> + *
> + * This routine is called by the pci error recovery recovery
> + * code after the PCI slot has been reset, just before we
> + * should resume normal operations.
> + */
> +static pers_result_t ipr_eeh_slot_reset(struct pci_dev *pdev)
> +{
> +	unsigned long flags = 0;
> +	struct ipr_ioa_cfg *ioa_cfg = pci_get_drvdata(pdev);
> +
> +	// pci_enable_device(pdev);
> +	// pci_set_master(pdev);

I assume you want remove these two lines... The pci config space
restore in ipr's reset handling should cover them.

> +	spin_lock_irqsave(ioa_cfg->host->host_lock, flags);
> +	_ipr_initiate_ioa_reset(ioa_cfg, ipr_reset_restore_cfg_space,
> +	                                 IPR_SHUTDOWN_NONE);
> +	spin_unlock_irqrestore(ioa_cfg->host->host_lock, flags);
> +
> +	return PERS_RESULT_RECOVERED;
> +}



-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
