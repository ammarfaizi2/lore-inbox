Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbUJXJKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbUJXJKW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 05:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbUJXJKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 05:10:21 -0400
Received: from witte.sonytel.be ([80.88.33.193]:14820 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261395AbUJXJJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 05:09:58 -0400
Date: Sun, 24 Oct 2004 11:08:54 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christoph Hellwig <hch@infradead.org>,
       "James E.J. Bottomley" <James.Bottomley@SteelEye.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: Re: qla1280: ISP1020/1040 support
In-Reply-To: <200410190022.i9J0MgeH006088@hera.kernel.org>
Message-ID: <Pine.GSO.4.61.0410241106500.7904@waterleaf.sonytel.be>
References: <200410190022.i9J0MgeH006088@hera.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sep 2004, Linux Kernel Mailing List wrote:
> ChangeSet 1.1832.79.83, 2004/09/29 11:29:12-04:00, jejb@mulgrave.(none)
> 
> 	qla1280: ISP1020/1040 support
> 	
> 	From: Christoph Hellwig <hch@lst.de>
> 	
> 	This patch adds support for the older ISP1020/1040 chips to the qla1280
> 	driver.  In fact it does not add much support but enables the work
> 	merged earlier. 
> 	
> 	It's been tested to work nicely on x86 and alpha machines by multiple
> 	people, it unfortunately doesn't work on SGI mips systems yet, but I'm
> 	pretty sure that's due to bugginess in the pci code for those
> 	plattforms.
> 	
> 	Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>
> 
> 
> 
>  Kconfig     |   16 
>  ql1040_fw.h | 2101 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  qla1280.c   |   31 
>  3 files changed, 2135 insertions(+), 13 deletions(-)
> 
> 
> diff -Nru a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
> --- a/drivers/scsi/Kconfig	2004-10-18 17:22:51 -07:00
> +++ b/drivers/scsi/Kconfig	2004-10-18 17:22:51 -07:00
> @@ -1222,7 +1222,7 @@
>  	  module will be called qlogicfas.
>  
>  config SCSI_QLOGIC_ISP
> -	tristate "Qlogic ISP SCSI support"
> +	tristate "Qlogic ISP SCSI support (old driver)"
>  	depends on PCI && SCSI
>  	---help---
>  	  This driver works for all QLogic PCI SCSI host adapters (IQ-PCI,
> @@ -1239,6 +1239,9 @@
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called qlogicisp.
>  
> +	  These days the hardware is also supported by the more modern qla1280
> +	  driver.  In doubt use that one instead of qlogicisp.
> +
>  config SCSI_QLOGIC_FC
>  	tristate "Qlogic ISP FC SCSI support"
>  	depends on PCI && SCSI
> @@ -1257,13 +1260,20 @@
>  	  qlogicfc driver. This is required on some platforms.
>  
>  config SCSI_QLOGIC_1280
> -	tristate "Qlogic QLA 1280 SCSI support"
> +	tristate "Qlogic QLA 1240/1x80/1x160 SCSI support"
>  	depends on PCI && SCSI
>  	help
> -	  Say Y if you have a QLogic ISP1x80/1x160 SCSI host adapter.
> +	  Say Y if you have a QLogic ISP1240/1x80/1x160 SCSI host adapter.
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called qla1280.
> +
> +config SCSI_QLOGIC_1280_1040
> +	bool "Qlogic QLA 1020/1040 SCSI support"

Can we please have a few dependencies here? E.g. PCI, SCSI, and probably
SCSI_QLOGIC_1280 come into my mind...

> +	help
> +	  Say Y here if you have a QLogic ISP1020/1040 SCSI host adapter and
> +	  do not want to use the old driver.  This option enables support in
> +	  the qla1280 driver for those host adapters.
>  
>  config SCSI_QLOGICPTI
>  	tristate "PTI Qlogic, ISP Driver"

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
