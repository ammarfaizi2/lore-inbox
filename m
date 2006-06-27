Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161311AbWF0Ve5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161311AbWF0Ve5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 17:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161316AbWF0Ve5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 17:34:57 -0400
Received: from titanium.sabren.com ([67.19.173.4]:53450 "EHLO
	titanium.sabren.com") by vger.kernel.org with ESMTP
	id S1161311AbWF0Ve4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 17:34:56 -0400
Date: Tue, 27 Jun 2006 23:34:51 +0200
From: Grzegorz Adam Hankiewicz <gradha@titanium.sabren.com>
To: Allen Martin <AMartin@nvidia.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Linux kernel 2.6.10 sata_nv.c stops working on my hardware
Message-ID: <20060627213451.GA2443@noir>
Mail-Followup-To: Allen Martin <AMartin@nvidia.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20060626192309.GA10711@noir> <DBFABB80F7FD3143A911F9E6CFD477B00E48CF38@hqemmail02.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B00E48CF38@hqemmail02.nvidia.com>
X-Accept-Language: es,en
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-06-26, Allen Martin <AMartin@nvidia.com> wrote:
> Have you tried the 2.6.9 sata_nv.c on 2.6.10?  All you should have
> to do to get it working is change the host_set->pdev references
> to use to_pci_dev().
> 
> The only functional change in sata_nv that should make any
> difference is the following:
> 
>  static struct ata_port_info nv_port_info = {
>         .sht            = &nv_sht,
>         .host_flags     = ATA_FLAG_SATA |
> -                         ATA_FLAG_SATA_RESET |
> +                         /* ATA_FLAG_SATA_RESET | */
>                           ATA_FLAG_SRST |
>                           ATA_FLAG_NO_LEGACY,
>         .pio_mask       = NV_PIO_MASK,
> 
> 
> You can try changing that back to see if it makes a difference.
> I would also investigate changes in libata too.

Actually the change you proposed works on my system. A 2.6.10 with
the ATA_FLAG_SATA_RESET works.  I did the same to a 2.6.16 kernel
but there it didn't work. I guess something else was introduced
between 2.6.10 and 2.6.16.  I'll start recompiling again everything
from 2.6.10 up to 2.6.16 with that flag turned on to see where it
stops working again.
