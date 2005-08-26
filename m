Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965057AbVHZIRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965057AbVHZIRX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 04:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965058AbVHZIRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 04:17:23 -0400
Received: from nproxy.gmail.com ([64.233.182.193]:22303 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965057AbVHZIRW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 04:17:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iaunI+qQrHVCgCR+4Hsua3veU+MkiOhLzpsBkNGxCQcU/Fq9bxKLk7WlsDHYMJTrNDh5WM0YNUpwmOzPD4SG+pmixHu4vBsCxYTDY+pc9hMgaf7TsaU+DZKSsQbPmbkQ/8Bh2nuHc/lC76Dtm7ocDorooQ3cTOmPMIrRZCf/4/Q=
Message-ID: <84144f02050826011778e1142@mail.gmail.com>
Date: Fri, 26 Aug 2005 11:17:19 +0300
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/7] spufs: The SPU file system
Cc: linuxppc64-dev@ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200508260003.40865.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508260003.40865.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

> This is a work-in-progress version of the SPU file system.

> --- linux-cg.orig/fs/spufs/file.c     1969-12-31 19:00:00.000000000 -0500
> +++ linux-cg/fs/spufs/file.c  2005-08-25 22:27:19.503976592 -0400
> @@ -0,0 +1,716 @@
> +/*
> + * SPU file system -- file contents
> +/* low-level mailbox write */
> +size_t spu_wbox_write(struct spu *spu, u32 data)
> +{
> +     int ret;
> +
> +     spin_lock_irq(&spu->register_lock);
> +
> +     if (in_be32(&spu->problem->mb_stat_R) & 0x00ff00) {
> +             /* we have space to write wbox_data to */
> +             out_be32(&spu->problem->spu_mb_W, data);
> +             ret = 4;
> +     } else {
> +             /* make sure we get woken up by the interrupt when space
> +                becomes available */
> +             out_be64(&spu->priv1->int_mask_class2_RW,
> +                     in_be64(&spu->priv1->int_mask_class2_RW) | 0x10);

I am confused. The code is architecture specific and does device I/O. Why do
you want to put this in fs/ and not drivers/?

                                    Pekka
