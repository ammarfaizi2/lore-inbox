Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266115AbUJEWSp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266115AbUJEWSp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 18:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266200AbUJEWSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 18:18:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:25222 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266181AbUJEWRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 18:17:37 -0400
Date: Tue, 5 Oct 2004 15:21:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org, markus.lidel@shadowconnect.com,
       alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] add missing checks of __copy_to_user return value in
 i2o_config.c
Message-Id: <20041005152126.6de415dc.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0410052317350.2913@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0410052317350.2913@dragon.hygekrogen.localhost>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <juhl-lkml@dif.dk> wrote:
>
> -	__copy_to_user(kxfer.buf, buffer.virt, fragsize);
> +	if (__copy_to_user(kxfer.buf, buffer.virt, fragsize))
> +		return -EFAULT;
> +
>  	i2o_dma_free(&c->pdev->dev, &buffer);
>  

Obvious leak.
