Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbWIUVaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbWIUVaZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 17:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbWIUVaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 17:30:25 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14503 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750856AbWIUVaY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 17:30:24 -0400
Date: Thu, 21 Sep 2006 23:30:21 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -mm 3/6] swsusp: Use block device offsets to identify swap locations
Message-ID: <20060921213021.GD2245@elf.ucw.cz>
References: <200609202120.58082.rjw@sisk.pl> <200609202141.58043.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609202141.58043.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Make swsusp use block device offsets instead of swap offsets to identify swap
> locations and make it use the same code paths for writing as well as for
> reading data.
> 
> This allows us to use the same code for handling swap files and swap
> partitions and to simplify the code, eg. by dropping rw_swap_page_sync().
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK. You may want to fix the comments, but that's probably separate
patch.


> Index: linux-2.6.18-rc7-mm1/mm/swapfile.c
> ===================================================================
> --- linux-2.6.18-rc7-mm1.orig/mm/swapfile.c
> +++ linux-2.6.18-rc7-mm1/mm/swapfile.c
> @@ -945,6 +945,23 @@ sector_t map_swap_page(struct swap_info_
>  	}
>  }
>  
> +#ifdef CONFIG_SOFTWARE_SUSPEND
> +/*
> + * Get the (PAGE_SIZE) block corrsponding to given offset on the swapdev

corresponding?

> + * corrsponding to given index in swap_info (swap type).

here too...


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
