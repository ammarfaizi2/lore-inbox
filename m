Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbTJFRmx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 13:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263087AbTJFRmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 13:42:53 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:46510 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262765AbTJFRmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 13:42:50 -0400
Date: Mon, 6 Oct 2003 13:42:47 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200310061742.h96Hglq15920@devserv.devel.redhat.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (6/7): qeth driver.
In-Reply-To: <mailman.1065433200.1921.linux-kernel2news@redhat.com>
References: <mailman.1065433200.1921.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  		PRINT_WARN("received an IDX TERMINATE on device %s "
>  			   "with cause code 0x%02x%s\n",
> -			   card->rdev->dev.bus_id, buffer[4],
> +			   CARD_BUS_ID(card), buffer[4],
>  			   (buffer[4] ==
>  			    0x22) ? " -- try another portname" : "");

>  #define PROBLEM_TX_TIMEOUT 12
>  
> +#define CARD_RDEV(card) card->gdev->cdev[0]
> +#define CARD_WDEV(card) card->gdev->cdev[1]
> +#define CARD_DDEV(card) card->gdev->cdev[2]
> +#define CARD_BUS_ID(card) card->gdev->dev.bus_id
> +#define CARD_RDEV_ID(card) card->gdev->cdev[0]->dev.bus_id
> +#define CARD_WDEV_ID(card) card->gdev->cdev[1]->dev.bus_id
> +#define CARD_DDEV_ID(card) card->gdev->cdev[2]->dev.bus_id

IMHO, this meaningless hiding is poorly concieved and
was discredited by its usage in UNIX. I object. On paper
is sounds fine, allowing to change implementation details
underneath the macro, yada yada. In practice, it adds
unnecessary opaquity.

-- Pete
