Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbWB1Lsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWB1Lsf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 06:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWB1Lsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 06:48:35 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48091 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751520AbWB1Lse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 06:48:34 -0500
Date: Tue, 28 Feb 2006 12:45:00 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
       akpm@osdl.org, jgarzik@pobox.com
Subject: Re: [PATCH 2/13] ATA ACPI: debugging infrastructure
Message-ID: <20060228114500.GA4057@elf.ucw.cz>
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com> <20060222135133.3f80fbf9.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222135133.3f80fbf9.randy_d_dunlap@linux.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> --- linux-2616-rc4-ata.orig/include/linux/libata.h
> +++ linux-2616-rc4-ata/include/linux/libata.h
> @@ -36,7 +36,8 @@
>  #include <acpi/acpi.h>
>  
>  /*
> - * compile-time options
> + * compile-time options: to be removed as soon as all the drivers are
> + * converted to the new debugging mechanism
>   */
>  #undef ATA_DEBUG		/* debugging output */
>  #undef ATA_VERBOSE_DEBUG	/* yet more debugging output */
> @@ -72,6 +73,38 @@
>          }
>  #endif
>  
> +/* NEW: debug levels */
> +#define HAVE_LIBATA_MSG 1

What is new with them?

> +enum {
> +	ATA_MSG_DRV	= 0x0001,
> +	ATA_MSG_INFO	= 0x0002,
> +	ATA_MSG_PROBE	= 0x0004,
> +	ATA_MSG_WARN	= 0x0008,
> +	ATA_MSG_MALLOC	= 0x0010,
> +	ATA_MSG_CTL	= 0x0020,
> +	ATA_MSG_INTR	= 0x0040,
> +	ATA_MSG_ERR	= 0x0080,
> +};
> +
> +#define ata_msg_drv(p)    ((p)->msg_enable & ATA_MSG_DRV)
> +#define ata_msg_info(p)   ((p)->msg_enable & ATA_MSG_INFO)
> +#define ata_msg_probe(p)  ((p)->msg_enable & ATA_MSG_PROBE)
> +#define ata_msg_warn(p)   ((p)->msg_enable & ATA_MSG_WARN)
> +#define ata_msg_malloc(p) ((p)->msg_enable & ATA_MSG_MALLOC)
> +#define ata_msg_ctl(p)    ((p)->msg_enable & ATA_MSG_CTL)
> +#define ata_msg_intr(p)   ((p)->msg_enable & ATA_MSG_INTR)
> +#define ata_msg_err(p)    ((p)->msg_enable & ATA_MSG_ERR)

I hate to see debugging infrastructure like this. We already have it
in ACPI and it is nasty/useless. It hides serious errors during normal
run, while if you turn on the debugging, it floods logs so that
it is unusable, too. I end up having to replace dprintks with
printks... nasty.
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
