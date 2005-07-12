Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbVGLLlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVGLLlH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 07:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVGLLk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 07:40:58 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:47070 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261346AbVGLLi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 07:38:56 -0400
Subject: Re: SCSI luns
From: Arjan van de Ven <arjan@infradead.org>
To: Amrut Joshi <amrut.joshi@gmail.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1ba727770507120422562d525d@mail.gmail.com>
References: <1ba727770507120422562d525d@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 12 Jul 2005 13:38:51 +0200
Message-Id: <1121168331.3171.21.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-12 at 16:52 +0530, Amrut Joshi wrote:
> Hi,
> 
> Currently linux scsi subsystem doesnt store the 8-byte luns which are
> recieved in REPORT_LUNS reply. This information is forver lost once
> the scan is over. In my LDD  I need this information. Currently I have
> to snoop REPORT_LUNS reply, do scsilun_to_int for all the luns and

which LDD is this? Is it ready for merging into the linux kernel yet?

> store this mapping somewhere. This can be simplified by storing it in
> scsi_device. This field will be meaningful only if sdev->scsi_level >=
> SCSI_3.

> Heres the patch

your patch is whitespace damanged unfortunately... 

> -----------------------------------------------------------------------------------------------------------------
> --- drivers/scsi/scsi_scan.c.orig       2005-06-30 04:30:53.000000000 +0530
> +++ drivers/scsi/scsi_scan.c    2005-07-12 16:19:48.533788528 +0530
> @@ -1170,6 +1170,7 @@
>                                        " aborted\n", devname, lun);
>                                 break;
>                         }
> +                        memcpy(sdev->lun_address, lunp,
> sizeof(sdev->lun_address));
>                 }
>         }
> 
> --- include/scsi/scsi_device.h.orig     2005-06-30 04:30:53.000000000 +0530
> +++ include/scsi/scsi_device.h  2005-07-12 16:19:48.534788376 +0530
> @@ -58,6 +58,8 @@
>                                            could all be from the same event. */
> 
>         unsigned int id, lun, channel;
> +        struct scsi_lun lun_address;    /* scsi address returned by REPORT_LUNS
> +                                         * usable only if
> sdev->scsi_lun >= SCSI_3 */
> 
>         unsigned int manufacturer;      /* Manufacturer of device, for using
>                                          * vendor-specific cmd's */
> 
> ----------------------------------------------------------------------------------------------------------------------
> 
> Please CC replies to me as I am not on the list.
> 
> Thanks,
> -Amrut!
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

