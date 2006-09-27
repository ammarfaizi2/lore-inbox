Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031189AbWI0WyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031189AbWI0WyM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 18:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031190AbWI0WyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 18:54:11 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:40908 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1031189AbWI0WyK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 18:54:10 -0400
Message-ID: <451B010F.4010308@pobox.com>
Date: Wed, 27 Sep 2006 18:54:07 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       rdunlap@xenotime.net
Subject: Re: [patch 2/2] libata: _SDD support
References: <20060927223441.205181000@localhost.localdomain> <20060927153634.716a8aa1.kristen.c.accardi@intel.com>
In-Reply-To: <20060927153634.716a8aa1.kristen.c.accardi@intel.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristen Carlson Accardi wrote:
> +	/* Don't continue if not a SATA device. */
> +	if (!ata_id_is_sata(atadev->id)) {
> +		if (ata_msg_probe(ap))
> +			ata_dev_printk(atadev, KERN_DEBUG,
> +				"%s: ata_id_is_sata is False\n", __FUNCTION__);
> +		goto out;
> +	}

I forgot to note this in patch #1, so this comment applies to both patch 
#1 and patch #2:

ata_id_is_sata() is probably not the check you want.  This tests Word 93 
of IDENTIFY DEVICE output, which is a check that's not in the ATA 
specification, but rather something I came up with.  It will indicate 
false for ATA devices that attach via SATA cables, but have a PATA 
bridge chip soldered onto the ATA device.

A better test is probably "ap->cbl == ATA_CBL_SATA".


> +EXPORT_SYMBOL_GPL(ata_acpi_push_id);

Remove the export, this is for exporting symbols to export kernel 
modules, not for making symbols visible at the C level, to other C modules.

	Jeff



