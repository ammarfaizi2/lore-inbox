Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751774AbWB1L7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbWB1L7j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 06:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751741AbWB1L7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 06:59:38 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40108 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751730AbWB1L7h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 06:59:37 -0500
Date: Tue, 28 Feb 2006 12:57:15 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       akpm@osdl.org, jgarzik@pobox.com
Subject: Re: [PATCH 10/13] ATA ACPI: do taskfile before mode commands
Message-ID: <20060228115715.GE4081@elf.ucw.cz>
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com> <20060222140140.0d9e41b7.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222140140.0d9e41b7.randy_d_dunlap@linux.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 22-02-06 14:01:40, Randy Dunlap wrote:
> From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
> 
> Do drive/taskfile-specific commands before setting the drive mode.
> This allows the taskfile to unlock the drive before trying to
> set the drive mode.
> 
> Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
> ---
>  drivers/scsi/libata-core.c |   13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> --- linux-2616-rc4-ata.orig/drivers/scsi/libata-core.c
> +++ linux-2616-rc4-ata/drivers/scsi/libata-core.c
> @@ -4297,13 +4297,17 @@ static int ata_start_drive(struct ata_po
>   */
>  int ata_device_resume(struct ata_port *ap, struct ata_device *dev)
>  {
> +	printk(KERN_DEBUG "ata%d: resume device\n", ap->id);

Yep, one more helpful printk. Not. Actually this is four more of them
in this patch alone. Please remove your debugging code prior to merge.

								Pavel

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
