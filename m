Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWC3IxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWC3IxA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 03:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWC3IxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 03:53:00 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:3468 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751197AbWC3Iw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 03:52:59 -0500
Date: Thu, 30 Mar 2006 17:54:06 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH][RFC] splice support
Message-Id: <20060330175406.fbd6d82c.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060329122841.GC8186@suse.de>
References: <20060329122841.GC8186@suse.de>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2006 14:28:41 +0200
Jens Axboe <axboe@suse.de> wrote:
>
> +	/*
> +	 * Get as many pages from the page cache as possible..
> +	 * Start IO on the page cache entries we create (we
> +	 * can assume that any pre-existing ones we find have
> +	 * already had IO started on them).
> +	 */
> +	i = find_get_pages(mapping, index, pages, array);
> +

It looks page caches in this array is hold by pipe until data is consumed.
So..this page cannot be reclaimd or migrated and hot-removed :).
I don't know about sendfile() but this looks client can hold server's memory,
when server uses sendfile() 64k/conn.

Is there a way to force these pages to be freed ? or page reclaimer can
know this page is held by splice ? (we need additional PG_flags to do this ?)

I think these pages are necessary to be held only when data in them is used.

--Kame


