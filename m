Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbVIHGn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbVIHGn2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 02:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVIHGn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 02:43:28 -0400
Received: from nproxy.gmail.com ([64.233.182.193]:50309 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751091AbVIHGn2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 02:43:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ROFRhefZnYpJZ/Clr1wyVUxgRSbjY9Pj7HgpggpfOrnZ06h0Sg7GodXnqZNnqKGy6HeGipaRa1G9/tt2U0hxdgVlWv6Zn3/Dfb4lVe3+zcJvNjB3Ns0YUo5Ic3vzg/Blk1H93rGSre65PDAjKVG+YQgLbuToAet3Unyf2/R9r08=
Message-ID: <84144f02050907234365616f@mail.gmail.com>
Date: Thu, 8 Sep 2005 09:43:24 +0300
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Miloslav Trmac <mitr@volny.cz>
Subject: Re: [PATCH] Wistron laptop button driver
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
In-Reply-To: <431E4E28.5020604@volny.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <431E4E28.5020604@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/05, Miloslav Trmac <mitr@volny.cz> wrote:
> +static int __init map_bios(void)
> +{
> +     static const unsigned char __initdata signature[]
> +             = { 0x42, 0x21, 0x55, 0x30 };
> +
> +     void __iomem *base;
> +     size_t offset;
> +     uint32_t entry_point;
> +
> +     base = ioremap(0xF0000, 0x10000); /* Can't fail */

How come? ioremap can return NULL if, for example, we run out of memory.

> +     for (offset = 0; offset < 0x10000; offset += 0x10) {
> +             if (check_signature(base + offset, signature,
> +                                 sizeof(signature)) != 0)
> +                     goto found;
> +     }

                              Pekka
