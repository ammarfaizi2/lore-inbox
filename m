Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbTH2T0I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 15:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbTH2T0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 15:26:08 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:32778 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261492AbTH2T0C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 15:26:02 -0400
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] s390 (5/8): common i/o layer.
References: <20030829171005.GF1242@mschwid3.boeblingen.de.ibm.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 30 Aug 2003 04:25:21 +0900
In-Reply-To: <20030829171005.GF1242@mschwid3.boeblingen.de.ibm.com>
Message-ID: <87vfsggtb2.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky <schwidefsky@de.ibm.com> writes:

> --- linux-2.6/drivers/s390/cio/css.c	Sat Aug 23 01:52:24 2003
> +++ linux-2.6-s390/drivers/s390/cio/css.c	Fri Aug 29 18:55:10 2003

[...]

> @@ -97,8 +85,7 @@
>  	sch->dev.bus = &css_bus_type;
>  
>  	/* Set a name for the subchannel */
> -	strlcpy (sch->dev.name, subchannel_types[sch->st], DEVICE_NAME_SIZE);
> -	snprintf (sch->dev.bus_id, DEVICE_ID_SIZE, "0:%04x", sch->irq);
> +	snprintf (sch->dev.bus_id, DEVICE_ID_SIZE, "0.0.%04x", sch->irq);
>  
>  	/* make it known to the system */
>  	ret = device_register(&sch->dev);
> diff -urN linux-2.6/drivers/s390/cio/device.c linux-2.6-s390/drivers/s390/cio/device.c
> --- linux-2.6/drivers/s390/cio/device.c	Sat Aug 23 01:58:10 2003
> +++ linux-2.6-s390/drivers/s390/cio/device.c	Fri Aug 29 18:55:10 2003

[...]

> @@ -537,8 +537,7 @@
>  	init_timer(&cdev->private->timer);
>  
>  	/* Set an initial name for the device. */
> -	snprintf (cdev->dev.name, DEVICE_NAME_SIZE,"ccw device");
> -	snprintf (cdev->dev.bus_id, DEVICE_ID_SIZE, "0:%04x",
> +	snprintf (cdev->dev.bus_id, DEVICE_ID_SIZE, "0.0.%04x",
>  		  sch->schib.pmcw.dev);
>  
>  	/* Increase counter of devices currently in recognition. */

Shouldn't the above use BUS_ID_SIZE instead of DEVICE_ID_SIZE?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
