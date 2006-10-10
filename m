Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965142AbWJJJgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965142AbWJJJgf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 05:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965140AbWJJJgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 05:36:35 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:735 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965137AbWJJJge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 05:36:34 -0400
Date: Tue, 10 Oct 2006 10:36:30 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Henne <henne@nachtwindheim.de>
Cc: Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: remove hosts.h
Message-ID: <20061010093630.GH395@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Henne <henne@nachtwindheim.de>, Andrew Morton <akpm@osdl.org>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <45236F31.3070602@nachtwindheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45236F31.3070602@nachtwindheim.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 10:22:09AM +0200, Henne wrote:
> Remove the obsolete hosts.h file under drivers/scsi.
> Signed-off-by: Henrik Kretzschmar <henne@nachtwindheim.de>

Ok.  I thought we had remove this one long time ago.

> 
> ---
> 
>  b/drivers/scsi/dpt_i2o.c       |    2 +-
>  b/drivers/scsi/dpti.h          |    2 +-
>  b/drivers/scsi/ips.c           |    6 ------
>  b/drivers/scsi/pcmcia/nsp_cs.c |    1 -
>  drivers/scsi/hosts.h           |    2 --
>  5 files changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
> index 7b3bd34..b20b376 100644
> --- a/drivers/scsi/dpt_i2o.c
> +++ b/drivers/scsi/dpt_i2o.c
> @@ -2212,7 +2212,7 @@ static s32 adpt_scsi_register(adpt_hba* 
>  	 */
>  	host->io_port = 0;
>  	host->n_io_port = 0;
> -				/* see comments in hosts.h */
> +				/* see comments in scsi_host.h */
>  	host->max_id = 16;
>  	host->max_lun = 256;
>  	host->max_channel = pHba->top_scsi_channel + 1;
> diff --git a/drivers/scsi/dpti.h b/drivers/scsi/dpti.h
> index 2ad2a89..2899832 100644
> --- a/drivers/scsi/dpti.h
> +++ b/drivers/scsi/dpti.h
> @@ -44,7 +44,7 @@ static int adpt_device_reset(struct scsi
>  
>  
>  /*
> - * struct scsi_host_template (see hosts.h)
> + * struct scsi_host_template (see scsi/scsi_host.h)
>   */
>  
>  #define DPT_DRIVER_NAME	"Adaptec I2O RAID"
> diff --git a/drivers/scsi/hosts.h b/drivers/scsi/hosts.h
> deleted file mode 100644
> index c27264b..0000000
> --- a/drivers/scsi/hosts.h
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -#warning "This file is obsolete, please use <scsi/scsi_host.h> instead"
> -#include <scsi/scsi_host.h>
> diff --git a/drivers/scsi/ips.c b/drivers/scsi/ips.c
> index 3c63928..ea03dd7 100644
> --- a/drivers/scsi/ips.c
> +++ b/drivers/scsi/ips.c
> @@ -182,14 +182,8 @@ #include <linux/types.h>
>  #include <linux/dma-mapping.h>
>  
>  #include <scsi/sg.h>
> -
>  #include "scsi.h"
> -
> -#if LINUX_VERSION_CODE <= KERNEL_VERSION(2,5,0)
> -#include "hosts.h"
> -#else
>  #include <scsi/scsi_host.h>
> -#endif
>  
>  #include "ips.h"
>  
> diff --git a/drivers/scsi/pcmcia/nsp_cs.c b/drivers/scsi/pcmcia/nsp_cs.c
> index 0d4c04e..053303d 100644
> --- a/drivers/scsi/pcmcia/nsp_cs.c
> +++ b/drivers/scsi/pcmcia/nsp_cs.c
> @@ -80,7 +80,6 @@ static int       free_ports = 0;
>  module_param(free_ports, bool, 0);
>  MODULE_PARM_DESC(free_ports, "Release IO ports after configuration? (default: 0 (=no))");
>  
> -/* /usr/src/linux/drivers/scsi/hosts.h */
>  static struct scsi_host_template nsp_driver_template = {
>  	.proc_name	         = "nsp_cs",
>  	.proc_info		 = nsp_proc_info,
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
---end quoted text---
