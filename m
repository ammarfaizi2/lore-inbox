Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbWGWUEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWGWUEV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 16:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWGWUEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 16:04:21 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:45269 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751286AbWGWUEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 16:04:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=g5MnxSPTdVH5a5AER34E4SzmqFr2tEcoMLcQUGBKdRdtSFZuY/1z4A3hRx6b2a4JWqTiG8DwyYVF3+9H1R1ktdA0n042jDVwO5oBcJAhVZ8ji+QUQ8F93N2VtgQPe+o7JteJE682u3IEIMY4yavGBepBG2kTEjhedrIULtY0G2c=
Date: Sun, 23 Jul 2006 22:04:05 +0200
From: Luca <kronos.it@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Dave Airlie <airlied@linux.ie>
Subject: Re: [PATCH] gpu: Initial GPU layer addition. (03/07)
Message-ID: <20060723200405.GA12885@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11535827132905-git-send-email-airlied@linux.ie>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie <airlied@linux.ie> ha scritto:
> diff --git a/drivers/video/gpu_layer.c b/drivers/video/gpu_layer.c
> new file mode 100644
> index 0000000..36e7037
> --- /dev/null
> +++ b/drivers/video/gpu_layer.c
> @@ -0,0 +1,393 @@
> +/*
> + * drivers/video/gpu_layer.c
> + *
> + * (C) Copyright Dave Airlie 2006
> + *
> + */
> +#include <linux/device.h>
> +#include <linux/list.h>
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +#include <linux/gpu_layer.h>
> +
> +/* GPUs we manage */
> +LIST_HEAD(gpu_bus_list);
> +
> +/* used when allocating bus numbers */
> +#define GPU_MAXBUS             16
> +struct gpu_busmap {
> +       unsigned long busmap [GPU_MAXBUS / (8*sizeof (unsigned long))];
> +};

16 / (8 * 4) is zero (the same with sizeof(long) == 8). When doing bit
ops on that zero-sized array you are probably corrupting the BSS. 

Luca
-- 
Home: http://kronoz.cjb.net
Recursion n.:
	See Recursion.
