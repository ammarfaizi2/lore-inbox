Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290802AbSAaBSs>; Wed, 30 Jan 2002 20:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290798AbSAaBS3>; Wed, 30 Jan 2002 20:18:29 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3088 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290796AbSAaBSK>;
	Wed, 30 Jan 2002 20:18:10 -0500
Message-ID: <3C5899A5.5A5F7272@zip.com.au>
Date: Wed, 30 Jan 2002 17:11:01 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ulrich Weigand <weigand@immd1.informatik.uni-erlangen.de>
CC: velco@fadata.bg, linux-kernel@vger.kernel.org
Subject: Re: linux-kernel@vger.kernel.org
In-Reply-To: <200201310102.CAA17256@faui1a.informatik.uni-erlangen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Weigand wrote:
> 
> Momchil Velikov wrote:
> 
> +int move_from_swap_cache(struct page *page, unsigned long index,
> +               struct address_space *mapping)
> +{
> +       void **pslot;
> +       int err;
> +
> +       if (!PageLocked(page))
> +               BUG();
> +
> +       spin_lock(&swapper_space.i_shared_lock);
> +       spin_lock(&mapping->i_shared_lock);
> +
> +       err = radix_tree_reserve(&mapping->page_tree, index, &pslot);
> +       if (!err) {
> +               swp_entry_t entry;
> +
> +               block_flushpage(page, 0);

block_flushpage inside spinlock is a no-no.  It does I/O,
and sleeps.

-
