Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265821AbUBJL1d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 06:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265833AbUBJL1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 06:27:33 -0500
Received: from intra.cyclades.com ([64.186.161.6]:61413 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265821AbUBJL1a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 06:27:30 -0500
Date: Tue, 10 Feb 2004 09:11:33 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] PCI Update for 2.6.3-rc1
In-Reply-To: <10763689443294@kroah.com>
Message-ID: <Pine.LNX.4.58L.0402100909320.14727@logos.cnet>
References: <10763689443294@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 9 Feb 2004, Greg KH wrote:

> ChangeSet 1.1607, 2004/02/09 14:05:33-08:00, greg@kroah.com
>
> dmapool: fix up list_for_each() calls to list_for_each_entry()
>
> Now this should get that Rusty^Wmonkey off my back...
>
>
>  drivers/base/dmapool.c |   29 +++++++++++------------------
>  1 files changed, 11 insertions(+), 18 deletions(-)
>
>
> diff -Nru a/drivers/base/dmapool.c b/drivers/base/dmapool.c
> --- a/drivers/base/dmapool.c	Mon Feb  9 14:58:07 2004
> +++ b/drivers/base/dmapool.c	Mon Feb  9 14:58:07 2004
> @@ -43,9 +43,11 @@
>  static ssize_t
>  show_pools (struct device *dev, char *buf)
>  {
> -	unsigned		temp, size;
> -	char			*next;
> -	struct list_head	*i, *j;
> +	unsigned temp;
> +	unsigned size;
> +	char *next;
> +	struct dma_page *page;
> +	struct dma_pool *pool;
>
>  	next = buf;
>  	size = PAGE_SIZE;
> @@ -55,16 +57,11 @@
>  	next += temp;
>
>  	down (&pools_lock);
> -	list_for_each (i, &dev->dma_pools) {
> -		struct dma_pool	*pool;
> -		unsigned	pages = 0, blocks = 0;
> +	list_for_each_entry(pool, &dev->dma_pools, pools) {
> +		unsigned pages = 0;
> +		unsigned blocks = 0;
>
> -		pool = list_entry (i, struct dma_pool, pools);
> -
> -		list_for_each (j, &pool->page_list) {
> -			struct dma_page	*page;
> -
> -			page = list_entry (j, struct dma_page, page_list);
> +		list_for_each_entry(page, &pool->page_list, page_list) {
>  			pages++;
>  			blocks += page->in_use;

Hi Rusty,

I have you ask riel to use list_for_each_entry() instead list_for_each()
in the 2.4 inode highmem patches.

Is this a "beauty" only modification or is there any potential problem
with "list_for_each()" ?

Thank you.
