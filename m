Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbVBRRY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbVBRRY1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 12:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVBRRY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 12:24:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45526 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261420AbVBRRYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 12:24:24 -0500
Date: Fri, 18 Feb 2005 17:24:19 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Robert Love <rml@novell.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       John McCutchan <ttb@tentacle.dhs.org>
Subject: Re: [patch] inotify for 2.6.11-rc3-mm2
Message-ID: <20050218172419.GP8859@parcelfarce.linux.theplanet.co.uk>
References: <20050210023508.3583cf87.akpm@osdl.org> <1108061239.18124.18.camel@betsy.boston.ximian.com> <1108744859.4667.7.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108744859.4667.7.camel@betsy.boston.ximian.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2005 at 11:40:59AM -0500, Robert Love wrote:
> inotify, bitches

/me does "pick a random function, find a race" again.
 
> +/*
> + * inode_add_watch - add a watch to the given inode
> + *
> + * Callers must hold dev->lock, because we call inode_find_dev().
> + */
> +static int inode_add_watch(struct inode *inode, struct inotify_watch *watch)
[snip]
> +	list_add(&watch->i_list, &inode->inotify_data->watches);
                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
... and that is protected by what?
> +
> +	return 0;

Fix the damn locking, already.
