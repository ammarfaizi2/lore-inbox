Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbVGGVQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbVGGVQq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 17:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbVGGVPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 17:15:13 -0400
Received: from [203.171.93.254] ([203.171.93.254]:51378 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261437AbVGGVPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 17:15:09 -0400
Subject: Re: [PATCH] [46/48] Suspend2 2.1.9.8 for 2.6.12:
	622-swapwriter.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <84144f0205070706326849b1e@mail.gmail.com>
References: <11206164393426@foobar.com> <11206164442712@foobar.com>
	 <84144f0205070706326849b1e@mail.gmail.com>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1120770991.4860.1554.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 08 Jul 2005 07:16:32 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2005-07-07 at 23:32, Pekka Enberg wrote:
> Hi Nigel,
> 
> > diff -ruNp 623-generic-block-io.patch-old/kernel/power/suspend_block_io.c 623-generic-block-io.patch-new/kernel/power/suspend_block_io.c
> > --- 623-generic-block-io.patch-old/kernel/power/suspend_block_io.c      1970-01-01 10:00:00.000000000 +1000
> > +++ 623-generic-block-io.patch-new/kernel/power/suspend_block_io.c      2005-07-05 23:48:59.000000000 +1000
> > @@ -0,0 +1,817 @@
> > +struct io_info {
> > +       struct bio * sys_struct;
> > +       long block[PAGE_SIZE/512];
> 
> Aah, but for this you should use block_size(io_info->dev) instead. No
> need to mess with sector sizes. Why is this long by the way?
> PAGE_SIZE/512 is block size in bytes.

No...  it's the maximum number of blocks per page. Depending upon how
the user has set the blocksize when they created the filesystem (in the
case of filesystems), the number of blocks we use per page might be 1,
2, 4 or 8.

It's long because a sector number is stored in it.

Regards,

Nigel

> > +       struct page * buffer_page;
> > +       struct page * data_page;
> > +       unsigned long flags;
> > +       struct block_device * dev;
> > +       struct list_head list;
> > +       int readahead_index;
> > +       struct work_struct work;
> > +};
> 
>                                     Pekka
> 
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

