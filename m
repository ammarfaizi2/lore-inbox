Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752174AbWAEMXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174AbWAEMXm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 07:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752175AbWAEMXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 07:23:42 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:57587 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752174AbWAEMXl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 07:23:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ROIPzrq9jFFiqXAJky+Ah9frQWZ/M0XoSfhInPfIkk63+0xnF52mKX8HbOGKwd2SCXiVi6I1AhS1gSJQC3O1QpXwobVpTHP+L3P7CR5otaRzQJ8Yd8USSO+vyvrAN03NEc0W4V0sxziu7RYn/5ap8wQpLKwrGt4pgeOaHyD1obo=
Message-ID: <84144f020601050423j19b73446l143162a9ef6067b@mail.gmail.com>
Date: Thu, 5 Jan 2006 14:23:06 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: takis@issaris.org
Subject: Re: [PATCH] drivers/media: Conversions from kmalloc+memset to kzalloc.
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
In-Reply-To: <20060105104332.3E5CC6ADE@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060105104332.3E5CC6ADE@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/06, Panagiotis Issaris <takis@issaris.org> wrote:
> 993e5ce2979baa3df3d8dd238d74ea3b607e4693
> diff --git a/drivers/media/common/saa7146_core.c b/drivers/media/common/saa7146_core.c
> index 2899d34..38982a7 100644
> --- a/drivers/media/common/saa7146_core.c
> +++ b/drivers/media/common/saa7146_core.c
> @@ -109,10 +109,9 @@ static struct scatterlist* vmalloc_to_sg
>         struct page *pg;
>         int i;
>
> -       sglist = kmalloc(sizeof(struct scatterlist)*nr_pages, GFP_KERNEL);
> +       sglist = kzalloc(sizeof(struct scatterlist)*nr_pages, GFP_KERNEL);

Hmm, these should be converted to kcalloc().

                                      Pekka
