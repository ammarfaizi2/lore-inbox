Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267693AbUHPPSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267693AbUHPPSs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 11:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267697AbUHPPRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 11:17:23 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:47585 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267693AbUHPPPf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 11:15:35 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@redhat.com>
Subject: Re: PATCH: quieten some IDE diagnostics we will be using much more
Date: Mon, 16 Aug 2004 17:14:40 +0200
User-Agent: KMail/1.6.2
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <20040815144624.GA8168@devserv.devel.redhat.com>
In-Reply-To: <20040815144624.GA8168@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408161714.40398.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This PATCH is intermixed with PATCH: IDE - do spin up for all platforms ...

On Sunday 15 August 2004 16:46, Alan Cox wrote:
> diff -u --new-file --recursive --exclude-from /usr/src/exclude
> linux.vanilla-2.6.8-rc3/drivers/ide/ide-probe.c
> linux-2.6.8-rc3/drivers/ide/ide-probe.c ---
> linux.vanilla-2.6.8-rc3/drivers/ide/ide-probe.c	2004-08-09
> 15:51:00.000000000 +0100 +++
> linux-2.6.8-rc3/drivers/ide/ide-probe.c	2004-08-14 21:03:03.000000000 +0100
> @@ -635,12 +680,11 @@
>  	device_register(&hwif->gendev);
>  }
>
> -#ifdef CONFIG_PPC
>  static int wait_hwif_ready(ide_hwif_t *hwif)
>  {
>  	int rc;
>
> -	printk(KERN_INFO "Probing IDE interface %s...\n", hwif->name);
> +	printk(KERN_DEBUG "Probing IDE interface %s...\n", hwif->name);
>
>  	/* Let HW settle down a bit from whatever init state we
>  	 * come from */
> @@ -671,7 +715,6 @@
>
>  	return rc;
>  }
> -#endif
>
>  /*
>   * This routine only knows how to look for drive units 0 and 1
> @@ -717,7 +760,6 @@
>
>  	local_irq_set(flags);
>
> -#ifdef CONFIG_PPC
>  	/* This is needed on some PPCs and a bunch of BIOS-less embedded
>  	 * platforms. Typical cases are:
>  	 *
> @@ -738,8 +780,7 @@
>  	 *  BenH.
>  	 */
>  	if (wait_hwif_ready(hwif))
> -		printk(KERN_WARNING "%s: Wait for ready failed before probe !\n",
> hwif->name); -#endif /* CONFIG_PPC */
> +		printk(KERN_DEBUG "%s: Wait for ready failed before probe !\n",
> hwif->name);
>
>  	/*
>  	 * Second drive should only exist if first drive was found,
