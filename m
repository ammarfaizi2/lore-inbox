Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbVKMVRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbVKMVRF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 16:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbVKMVRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 16:17:05 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:59577 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750709AbVKMVRE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 16:17:04 -0500
Date: Sun, 13 Nov 2005 22:16:52 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFT][PATCH 2/3] swsusp: introduce the swap map structure
Message-ID: <20051113211652.GE2119@elf.ucw.cz>
References: <200511122113.22177.rjw@sisk.pl> <200511122122.45063.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200511122122.45063.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch introduces the swap map structure that can be used by swsusp for
> keeping tracks of data pages written to the swap.  The structure itself is
> described in a comment within the patch.
> 
> The overall idea is to reduce the amount of metadata written to the swap
> and to write and read the image pages sequentially, in a file-alike way.
> This makes the swap-handling part of swsusp fairly independent of its
> snapshot-handling part and will hopefully allow us to completely
> separate these two parts in the future.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

> +struct swap_map_handle {
> +	void			*tfm; /* Needed for the encryption */
> +	struct swap_map_page	*cur;
> +	unsigned int		k;
> +};

I thought you killed encryption in 1/3?

> @@ -33,6 +33,9 @@
>  
>  #include "power.h"
>  
> +struct pbe *pagedir_nosave = NULL;
> +unsigned int nr_copy_pages = 0;
> +
>  #ifdef CONFIG_HIGHMEM
>  struct highmem_page {
>  	char *data;

You don't need to initialize to zero/NULL.

								Pavel
-- 
Thanks, Sharp!
