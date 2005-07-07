Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbVGGNhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVGGNhF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 09:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVGGNeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 09:34:46 -0400
Received: from nproxy.gmail.com ([64.233.182.205]:36876 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261507AbVGGNcn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 09:32:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eoai1aejanoCDV+ANuv9fbK3ldzm7X5u+bhe9r8HDdttuhXiGRw/AJipvSw4RqQW3DBm+5yA8AtKx/hDqaxqPNeZ7+1fELHRf0JX7Us4U0EWqV5npudJOWPX2xUcMQXhhmAq+nqP+/DZxFE47YkBhmmAqcQhuEsypGqxkTqHAo0=
Message-ID: <84144f0205070706326849b1e@mail.gmail.com>
Date: Thu, 7 Jul 2005 16:32:40 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [PATCH] [46/48] Suspend2 2.1.9.8 for 2.6.12: 622-swapwriter.patch
Cc: linux-kernel@vger.kernel.org, Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <11206164442712@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <11206164393426@foobar.com> <11206164442712@foobar.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nigel,

> diff -ruNp 623-generic-block-io.patch-old/kernel/power/suspend_block_io.c 623-generic-block-io.patch-new/kernel/power/suspend_block_io.c
> --- 623-generic-block-io.patch-old/kernel/power/suspend_block_io.c      1970-01-01 10:00:00.000000000 +1000
> +++ 623-generic-block-io.patch-new/kernel/power/suspend_block_io.c      2005-07-05 23:48:59.000000000 +1000
> @@ -0,0 +1,817 @@
> +struct io_info {
> +       struct bio * sys_struct;
> +       long block[PAGE_SIZE/512];

Aah, but for this you should use block_size(io_info->dev) instead. No
need to mess with sector sizes. Why is this long by the way?
PAGE_SIZE/512 is block size in bytes.

> +       struct page * buffer_page;
> +       struct page * data_page;
> +       unsigned long flags;
> +       struct block_device * dev;
> +       struct list_head list;
> +       int readahead_index;
> +       struct work_struct work;
> +};

                                    Pekka
