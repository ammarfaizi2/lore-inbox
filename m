Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbTIMCpj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 22:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbTIMCpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 22:45:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55213 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261850AbTIMCpi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 22:45:38 -0400
Message-ID: <3F6284C3.306@pobox.com>
Date: Fri, 12 Sep 2003 22:45:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Bernhard Rosenkraenzer <bero@arklinux.org>
CC: Samuel Flory <sflory@rackable.com>, linux-kernel@vger.kernel.org
Subject: Re: [FIX] Re: 2.4.23-pre3-pac2 broke PIIX ata-scsi
References: <Pine.LNX.4.56.0309111417580.31337@dot.kde.org> <3F6254A1.1020006@rackable.com> <Pine.LNX.4.56.0309130130050.17972@dot.kde.org>
In-Reply-To: <Pine.LNX.4.56.0309130130050.17972@dot.kde.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Rosenkraenzer wrote:
> Since this is probably the first version of ATA_PIIX that does compile 
> with modular SCSI, I'd like some feedback on whether or not it actually 
> works w/ modular SCSI (I don't have any test hardware).

Red Hat ships it modular.  This version of libata of woefully out of 
date.  I need to get you an update :)


> diff -urN linux-2.4.23-pre3-pac2/drivers/scsi/Config.in linux-2.4.23-pre3-pac3/drivers/scsi/Config.in
> --- linux-2.4.23-pre3-pac2/drivers/scsi/Config.in	2003-09-13 02:35:08.000000000 +0200
> +++ linux-2.4.23-pre3-pac3/drivers/scsi/Config.in	2003-09-13 02:41:35.000000000 +0200
> @@ -71,7 +71,7 @@
>     dep_tristate 'AMI MegaRAID support (new driver)' CONFIG_SCSI_MEGARAID2 $CONFIG_SCSI
>  fi
>  
> -dep_bool 'SATA support' CONFIG_SCSI_ATA $CONFIG_SCSI
> +dep_tristate 'SATA support' CONFIG_SCSI_ATA $CONFIG_SCSI

This is not correct.  It should "dep_mbool".


> diff -urN linux-2.4.23-pre3-pac2/include/linux/ata.h linux-2.4.23-pre3-pac3/include/linux/ata.h
> --- linux-2.4.23-pre3-pac2/include/linux/ata.h	2003-09-13 02:35:11.000000000 +0200
> +++ linux-2.4.23-pre3-pac3/include/linux/ata.h	2003-09-13 02:41:51.000000000 +0200
> @@ -629,13 +629,6 @@
>  	return status;
>  }
>  
> -/*
> - * 2.5 compat.
> - */
> -
> -typedef void irqreturn_t;
> -#define IRQ_RETVAL(x)	/* nothing */
> -

Yes, this is what I have checked in locally.

Once I return from a conference next week, I'll send you an update patch 
specific with -pac kernels...

	Jeff



