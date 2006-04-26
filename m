Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbWDZEgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWDZEgQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 00:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWDZEgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 00:36:16 -0400
Received: from xenotime.net ([66.160.160.81]:58338 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932258AbWDZEgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 00:36:16 -0400
Date: Tue, 25 Apr 2006 21:38:41 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jeff Chua <jchua@fedex.com>
Cc: lkml@rtr.ca, jeff.chua.linux@gmail.com, hugh@veritas.com,
       cjb@mrao.cam.ac.uk, pavel@suse.cz, arekm@maven.pl, jeff@garzik.org,
       mpm@selenic.com, axboe@suse.de, randy_d_dunlap@linux.intel.com,
       linux-kernel@vger.kernel.org, ncunningham@linuxmail.org
Subject: Re: sata suspend resume ... (fwd)
Message-Id: <20060425213841.63f0641e.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.64.0604250810370.5533@boston.corp.fedex.com>
References: <Pine.LNX.4.64.0604232153230.2890@boston.corp.fedex.com>
	<444C2821.5090409@rtr.ca>
	<Pine.LNX.4.64.0604250810370.5533@boston.corp.fedex.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2006 08:54:21 +0800 (SGT) Jeff Chua wrote:

> 
> On Sun, 23 Apr 2006, Mark Lord wrote:
> 
> > Try Randy Dunlop's libata-acpi patches -- I've been using variants of them
> > for a *very long time* here now, as they're the only thing that works for me.
> 
> This the one that makes does it!!! I've tried just about all patches 
> including the famous "mdelay(2000);" but none worked. ... perhaps it's 
> just something to do with IBM X60s which is dual-core.
> 
> Here's what I did to make it work...
> 
> Linux is vanilla linux-2.6.17-rc2.
> 
> Pavel suggested the right step as I was going no where with SMP suspend. 
> Switching to UP and using "suspend2" (CONFIG_SUSPEND2) didn't work either 
> with PIIX or AHCI. Patch is suspend2-2.2.5-for-2.6.17-rc2.tar.bz2
> 
> Then I tried "suspend" (CONFIG_SOFTWARE_SUSPEND) with both PIIX and 
> AHIC in UP mode ... still didn't work.
> 
> Next, I applied libata-acpi.patch with a little modification. No sure 
> what the implication is but the original patch seems to use "i" outside 
> the loop. Here's what I added to libata-acpi.patch ... can someone verify 
> this or do we need this at all?
> 
> +
> +       for (i = 0; i < ATA_MAX_DEVICES; i++)
> +               ata_acpi_push_id(ap, i);

Yes, that looks appropriate.  The function that code lives in
has changed quite a bit since this patch was written.

> Tried both PIIX and AHCI in UP mode. Failed with AHCI, but worked in 
> "suspend to disk" in PIIX mode (configured in BIOS under SATA -> 
> "COMPATIBILITY").

---
~Randy
