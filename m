Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbUKOVfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbUKOVfm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 16:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbUKOVdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 16:33:23 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:16275 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261398AbUKOVbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 16:31:50 -0500
Date: Mon, 15 Nov 2004 15:31:39 -0600
From: Robin Holt <holt@sgi.com>
To: linux-os@analogic.com
Cc: Norbert van Nobelen <Norbert@edusupport.nl>, Robin Holt <holt@sgi.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 21 million inodes is causing severe pauses.
Message-ID: <20041115213139.GA14258@lnx-holt.americas.sgi.com>
References: <20041115195551.GA15380@lnx-holt.americas.sgi.com> <200411152135.35121.Norbert@edusupport.nl> <Pine.LNX.4.61.0411151549060.22810@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411151549060.22810@chaos.analogic.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2004 at 03:57:44PM -0500, linux-os wrote:
> 
> Another temporary fix is to do:
> 
> while true ; do sleep 5 ; sync ; done

I don't think we are looking at a flushing buffers to disk problem.
Even after doing a sync, I see 1.3M entries.  Before the sync, I
was at 1.2M, so the count went up during the sync.

I am specifically noticing problems with the inode_list and not
buffers.

> 
> ... or some 'C' code equivalent to force most of the stuff to
> disk before it takes so much time that it's obvious to the
> users.
> 
> If you have soooo much data buffered, it is going to take a
> verrrry long time to write it to disk so. Just write it before
> you have so much buffered!

This is already being done.  Nearly all of the inodes have
buffers that are expired and have been pushed to disk.

> 
> NULL pointer problems shouldn't happen. However, you don't say
> if its a kernel crash problem or a user-mode problem. If it's
> a user-mode problem, the possibility exists that somebody isn't
> properly checking the return value of read/write, etc. If EIO
> (from attempting to modify an inode) was return in errno, you
> get -1 in the return value, it that's used as an index into the
> next bunch of data, you are dorked.

Kernel null pointer dereference in remove_inode_buffers().

Thanks,
Robin
