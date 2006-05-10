Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbWEJDRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWEJDRN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 23:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbWEJDRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 23:17:13 -0400
Received: from gate.crashing.org ([63.228.1.57]:63703 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964776AbWEJDRM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 23:17:12 -0400
Subject: Re: [PATCH -mm] scsi sata_svw gcc 4.1 warning fix
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <200605100256.k4A2u6Kd031755@dwalker1.mvista.com>
References: <200605100256.k4A2u6Kd031755@dwalker1.mvista.com>
Content-Type: text/plain
Date: Wed, 10 May 2006 13:16:32 +1000
Message-Id: <1147230992.32448.61.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-09 at 19:56 -0700, Daniel Walker wrote:
> Fixes the following warning,

Nack... ugly casts. Jeff, what is the status with these ?

Cheers,
Ben.


> drivers/scsi/sata_svw.c: In function 'k2_sata_tf_load':
> drivers/scsi/sata_svw.c:115: warning: passing argument 2 of 'writeb' makes pointer from integer without a cast
> drivers/scsi/sata_svw.c:120: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
> drivers/scsi/sata_svw.c:121: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
> drivers/scsi/sata_svw.c:122: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
> drivers/scsi/sata_svw.c:123: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
> drivers/scsi/sata_svw.c:124: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
> drivers/scsi/sata_svw.c:126: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
> drivers/scsi/sata_svw.c:127: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
> drivers/scsi/sata_svw.c:128: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
> drivers/scsi/sata_svw.c:129: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
> drivers/scsi/sata_svw.c:130: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
> drivers/scsi/sata_svw.c:134: warning: passing argument 2 of 'writeb' makes pointer from integer without a cast
> drivers/scsi/sata_svw.c: In function 'k2_sata_tf_read':
> drivers/scsi/sata_svw.c:146: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
> drivers/scsi/sata_svw.c:147: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
> drivers/scsi/sata_svw.c:148: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
> drivers/scsi/sata_svw.c:149: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
> drivers/scsi/sata_svw.c:150: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
> drivers/scsi/sata_svw.c:151: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
> 
> Signed-Off-By: Daniel Walker <dwalker@mvista.com>
> 
> Index: linux-2.6.16/drivers/scsi/sata_svw.c
> ===================================================================
> --- linux-2.6.16.orig/drivers/scsi/sata_svw.c
> +++ linux-2.6.16/drivers/scsi/sata_svw.c
> @@ -112,26 +112,26 @@ static void k2_sata_tf_load(struct ata_p
>  	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
>  
>  	if (tf->ctl != ap->last_ctl) {
> -		writeb(tf->ctl, ioaddr->ctl_addr);
> +		writeb(tf->ctl, (void *)ioaddr->ctl_addr);
>  		ap->last_ctl = tf->ctl;
>  		ata_wait_idle(ap);
>  	}
>  	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
> -		writew(tf->feature | (((u16)tf->hob_feature) << 8), ioaddr->feature_addr);
> -		writew(tf->nsect | (((u16)tf->hob_nsect) << 8), ioaddr->nsect_addr);
> -		writew(tf->lbal | (((u16)tf->hob_lbal) << 8), ioaddr->lbal_addr);
> -		writew(tf->lbam | (((u16)tf->hob_lbam) << 8), ioaddr->lbam_addr);
> -		writew(tf->lbah | (((u16)tf->hob_lbah) << 8), ioaddr->lbah_addr);
> +		writew(tf->feature | (((u16)tf->hob_feature) << 8), (void *)ioaddr->feature_addr);
> +		writew(tf->nsect | (((u16)tf->hob_nsect) << 8), (void *)ioaddr->nsect_addr);
> +		writew(tf->lbal | (((u16)tf->hob_lbal) << 8), (void *)ioaddr->lbal_addr);
> +		writew(tf->lbam | (((u16)tf->hob_lbam) << 8), (void *)ioaddr->lbam_addr);
> +		writew(tf->lbah | (((u16)tf->hob_lbah) << 8), (void *)ioaddr->lbah_addr);
>  	} else if (is_addr) {
> -		writew(tf->feature, ioaddr->feature_addr);
> -		writew(tf->nsect, ioaddr->nsect_addr);
> -		writew(tf->lbal, ioaddr->lbal_addr);
> -		writew(tf->lbam, ioaddr->lbam_addr);
> -		writew(tf->lbah, ioaddr->lbah_addr);
> +		writew(tf->feature, (void *)ioaddr->feature_addr);
> +		writew(tf->nsect, (void *)ioaddr->nsect_addr);
> +		writew(tf->lbal, (void *)ioaddr->lbal_addr);
> +		writew(tf->lbam, (void *)ioaddr->lbam_addr);
> +		writew(tf->lbah, (void *)ioaddr->lbah_addr);
>  	}
>  
>  	if (tf->flags & ATA_TFLAG_DEVICE)
> -		writeb(tf->device, ioaddr->device_addr);
> +		writeb(tf->device, (void *)ioaddr->device_addr);
>  
>  	ata_wait_idle(ap);
>  }
> @@ -143,12 +143,12 @@ static void k2_sata_tf_read(struct ata_p
>  	u16 nsect, lbal, lbam, lbah, feature;
>  
>  	tf->command = k2_stat_check_status(ap);
> -	tf->device = readw(ioaddr->device_addr);
> -	feature = readw(ioaddr->error_addr);
> -	nsect = readw(ioaddr->nsect_addr);
> -	lbal = readw(ioaddr->lbal_addr);
> -	lbam = readw(ioaddr->lbam_addr);
> -	lbah = readw(ioaddr->lbah_addr);
> +	tf->device = readw((void *)ioaddr->device_addr);
> +	feature = readw((void *)ioaddr->error_addr);
> +	nsect = readw((void *)ioaddr->nsect_addr);
> +	lbal = readw((void *)ioaddr->lbal_addr);
> +	lbam = readw((void *)ioaddr->lbam_addr);
> +	lbah = readw((void *)ioaddr->lbah_addr);
>  
>  	tf->feature = feature;
>  	tf->nsect = nsect;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

