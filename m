Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbWJBNI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWJBNI3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 09:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWJBNI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 09:08:28 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30090 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932291AbWJBNI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 09:08:28 -0400
Date: Mon, 2 Oct 2006 15:08:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: linux-ide@vger.intel.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       rdunlap@xenotime.net
Subject: Re: [patch 2/2] libata: _SDD support
Message-ID: <20061002130827.GB13617@elf.ucw.cz>
References: <20060928182211.076258000@localhost.localdomain> <20060928112912.d2ae0d8f.kristen.c.accardi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060928112912.d2ae0d8f.kristen.c.accardi@intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> _SDD (Set Device Data) is an ACPI method that is used to tell the 
> firmware what the identify data is of the device that is attached to
> the port.  It is an optional method, and it's ok for it to be missing. 
> Because of this, we always return success from the routine that calls
> this method, even if the execution fails.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
> 
> +	if (noacpi)
> +		return 0;

That variable needs better name, too.

> +	/* Don't continue if not a SATA device. */
> +	if (!(ap->cbl == ATA_CBL_SATA)) {

Can we just use != ?

> +	err = ACPI_FAILURE(status) ? -EIO : 0;
> +	if (err < 0) {
> +		if (ata_msg_probe(ap))
> +			ata_dev_printk(atadev, KERN_DEBUG,
> +				"ata%u(%u): %s _SDD error: status = 0x%x\n",
> +				ap->id, ap->device->devno,
> +				__FUNCTION__, status);
> +	}

err is unused, you always return 0; can we do if (ACPI_FAILURE()) instead?

> +	/* always return success */
> +out:
> +	return 0;
> +}
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
