Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbWBSX5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbWBSX5U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 18:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWBSX5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 18:57:20 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:63452 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932461AbWBSX5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 18:57:19 -0500
Message-ID: <43F9063A.9090700@jp.fujitsu.com>
Date: Mon, 20 Feb 2006 08:58:50 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Jim Duchek <jim.duchek@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: page_order private bit causes problems with dma_alloc_coherent?
References: <dead81ad0602190139t20b3805bt@mail.gmail.com>
In-Reply-To: <dead81ad0602190139t20b3805bt@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Duchek wrote:
> I'm attempting to debug a problem where pci_free_consistent causes a spewage
> of bad_page's due to the LG_private bit being set.  The remove goes through
> free_pages_ok, which does the free_page_check (which errors on the private
> bit) _BEFORE_ free_pages_bulk (which removes the private bit)
> 

When page is free , page_count(page) == 0. But this just means page is 'free'.
To show page is a head of buddy (contiguous pages of 2^order pages), order is
stored into page->private. To show page->private has a valid 'order', PG_private
is used.

See page_is_buddy() function.

> I'm not entirely sure why the pages are getting this bit -- this is a DRI
> driver and the bits don't get added during the whole time I'm running an
> application -- they get added shortly before I kill the GL client.  Any
> hints?  Is there a way to force pages never to use the page_order stuff?
> Should free_pages_check not consider the private bit such a bad thing?
> Should I just hack in something where I remove all the bits right before I
> do my free? :)
> 
I think removing PG_private before freeing is sane.
The page is free, so it's needless to use PG_private bit when free_pages() is called.

Thanks,
-- Kame

