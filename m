Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932722AbVJ2W5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932722AbVJ2W5X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 18:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932724AbVJ2W5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 18:57:23 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12740 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932722AbVJ2W5W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 18:57:22 -0400
Date: Sun, 30 Oct 2005 00:57:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@osdl.org
Subject: Re: [RFC][PATCH 3/6] swsusp: introduce the swap map structure and interface functions
Message-ID: <20051029225708.GD14209@elf.ucw.cz>
References: <200510292158.11089.rjw@sisk.pl> <200510292232.35403.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510292232.35403.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This is the main part.  It introduces a new data structure for the
> swap-handling part of swsusp (the swap map structure, described in a comment)
> and new functions for writing the image data to and reading them from swap.
> It also introduces the interface functions allowing the snapshot-handling part
> to communicate with the swap-handling part and modifies the struct pbe
> structure (the swap_address member of it is no longer needed as the
> swap-handling part uses its own independent data structures).

One small comment. I miss "a" in "swap". Pretty please...

> + * Rafael J. Wysocki <rjw@sisk.pl>
> + * Added the swap map data structure and reworked the handling of swap
> + *

Feel free to add yourself to CREDITS, too. CREDITS are going to stay,
but this does not really belong here, and may have to be moved
somewhere else in future.

> + *	During resume we only need to use one swp_map_page structure
> + *	at a time, which means that we only need to use two memory pages for
> + *	reading the image - one for reading the swp_map_page structures
> + *	and the second for reading the data pages from swap.
>   */

Nice...

> +struct swp_map_page {
> +	swp_entry_t		entries[MAP_PAGE_SIZE];
> +	swp_entry_t		next_swp;
> +	struct swp_map_page	*next;
> +};
> +
> +typedef struct swp_map_page swp_map_t;

Please don't. Just use "struct swap_map_page" instead.

> +extern unsigned snapshot_pages_to_save(void);
> +extern unsigned snapshot_image_pages(void);

Make it "extern unsigned int". (That is in more than one place).

> +int snapshot_recv_init(unsigned nr_pages, unsigned img_pages)

Please, usefull words, that's receive_init and image_pages....

Otherwise it looks good. I'll check it once more...

							Pavel
-- 
Thanks, Sharp!
