Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbUJ3Xna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbUJ3Xna (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 19:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbUJ3Xn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 19:43:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3260 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261415AbUJ3XnK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 19:43:10 -0400
Message-ID: <418426FF.1050801@pobox.com>
Date: Sat, 30 Oct 2004 19:42:55 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthijs Melchior <mmelchior@xs4all.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.10-rc1] ahci: Intel ICH6R (925X) corrections
References: <417A7E0D.6060704@xs4all.nl> <418423C8.309@xs4all.nl>
In-Reply-To: <418423C8.309@xs4all.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthijs Melchior wrote:
> This patch makes the following changes to drivers/scsi/ahci.c
> 
> - Add definition for SActive register
> - Add most interrupt sources to default interrupt mask
> - Write low 32 bits of FIS address to PxFB, where they belong
> - Set command active bit in PxSACT before setting command issue bit in PxCI
> - Announce Sub Class Code in driver info message [IDE, SATA or RAID]
> 
> 
> ------------------------------------------------------------------------
> 
> --- a/drivers/scsi/ahci.c	2004-10-23 01:37:22.000000000 +0200
> +++ b/drivers/scsi/ahci.c	2004-10-31 00:20:13.000000000 +0200
> @@ -90,6 +90,7 @@
>  	PORT_SCR_STAT		= 0x28, /* SATA phy register: SStatus */
>  	PORT_SCR_CTL		= 0x2c, /* SATA phy register: SControl */
>  	PORT_SCR_ERR		= 0x30, /* SATA phy register: SError */
> +        PORT_SCR_ACT            = 0x34, /* SATA phy register: SActive */
>  
>  	/* PORT_IRQ_{STAT,MASK} bits */
>  	PORT_IRQ_COLD_PRES	= (1 << 31), /* cold presence detect */
> @@ -116,6 +117,9 @@
>  				  PORT_IRQ_HBUS_DATA_ERR |
>  				  PORT_IRQ_IF_ERR,
>  	DEF_PORT_IRQ		= PORT_IRQ_FATAL | PORT_IRQ_PHYRDY |
> +                                  PORT_IRQ_CONNECT | PORT_IRQ_SG_DONE |
> +                                  PORT_IRQ_UNK_FIS | PORT_IRQ_SDB_FIS |
> +                                  PORT_IRQ_DMAS_FIS | PORT_IRQ_PIOS_FIS |
>  				  PORT_IRQ_D2H_REG_FIS,
>  

oh BTW, several parts of your patch had all the tabs converted to spaces 
for some reason.  I hand-converted them back.

	Jeff



