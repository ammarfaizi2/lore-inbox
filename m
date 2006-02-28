Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbWB1MBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWB1MBt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 07:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWB1MBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 07:01:49 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:42668 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932244AbWB1MBs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 07:01:48 -0500
Date: Tue, 28 Feb 2006 12:59:54 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       akpm@osdl.org, jgarzik@pobox.com
Subject: Re: [PATCH 13/13] ATA ACPI: enable writing PATA taskfiles
Message-ID: <20060228115954.GG4081@elf.ucw.cz>
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com> <20060222140714.46c572e7.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222140714.46c572e7.randy_d_dunlap@linux.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 22-02-06 14:07:14, Randy Dunlap wrote:
> From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
> 
> Move 'noacpi' option handling to top of functions.
> Enable writing taskfiles for PATA drives.

Changes order of return and debug message. It does not seem too useful
to me.
								Pavel

> Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
> ---
>  drivers/scsi/libata-acpi.c |   16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> --- linux-2616-rc4-ata.orig/drivers/scsi/libata-acpi.c
> +++ linux-2616-rc4-ata/drivers/scsi/libata-acpi.c
> @@ -303,13 +303,14 @@ int ata_acpi_push_id(struct ata_port *ap
>  	struct acpi_object_list		input;
>  	union acpi_object 		in_params[1];
>  
> +	if (noacpi)
> +		return 0;
> +
>  	if (ap->legacy_mode) {
>  		printk(KERN_DEBUG "%s: skipping for PATA mode\n",
>  			__FUNCTION__);
>  		return 0;
>  	}
> -	if (noacpi)
> -		return 0;
>  
>  	if (ata_msg_probe(ap))
>  		printk(KERN_DEBUG
...
> @@ -707,12 +703,12 @@ int ata_acpi_exec_tfs(struct ata_port *a
>  	unsigned long	gtf_address;
>  	unsigned long	obj_loc;
>  
> -	if (ata_msg_probe(ap))
> -		printk(KERN_DEBUG "%s: ENTER:\n", __FUNCTION__);
> -
>  	if (noacpi)
>  		return 0;
>  
> +	if (ata_msg_probe(ap))
> +		printk(KERN_DEBUG "%s: ENTER:\n", __FUNCTION__);
> +
>  	for (ix = 0; ix < ATA_MAX_DEVICES; ix++) {
>  		if (ata_msg_probe(ap))
>  			printk(KERN_DEBUG "%s: call get_GTF, ix=%d\n",


-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
