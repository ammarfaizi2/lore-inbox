Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317152AbSFBIQ2>; Sun, 2 Jun 2002 04:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317153AbSFBIQ1>; Sun, 2 Jun 2002 04:16:27 -0400
Received: from wsip68-14-236-254.ph.ph.cox.net ([68.14.236.254]:20137 "EHLO
	mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S317152AbSFBIQ0>; Sun, 2 Jun 2002 04:16:26 -0400
Date: Sun, 2 Jun 2002 01:16:13 -0700
From: Paul Dickson <dickson@permanentmail.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.19 IDE 78
Message-Id: <20020602011613.2b3dc7e3.dickson@permanentmail.com>
In-Reply-To: <3CF9B58B.9080509@evision-ventures.com>
X-Mailer: Sylpheed version 0.7.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Jun 2002 08:04:59 +0200, Martin Dalecki wrote:

>  static void hpt3xx_maskproc(struct ata_device *drive)
>  {
>  	struct pci_dev *dev = drive->channel->pci_dev;
> -	const int mask = 0;
> +	struct ata_channel *ch = drive->channel;
>  
>  	if (drive->quirk_list) {
>  		if (hpt_min_rev(dev, 3)) {
>  			u8 reg5a;
>  			pci_read_config_byte(dev, 0x5a, &reg5a);
> -			if (((reg5a & 0x10) >> 4) != mask)
> -				pci_write_config_byte(dev, 0x5a, mask ? (reg5a | 0x10) : (reg5a & ~0x10));

[...]

> +			if ((reg5a & 0x10) >> 4)
> +				pci_write_config_byte(dev, 0x5a, reg5a & ~0x10);


Perhaps you can remove the " >> 4" too.

	-Paul

