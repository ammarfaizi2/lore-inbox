Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265490AbUHTFow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265490AbUHTFow (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 01:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266306AbUHTFow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 01:44:52 -0400
Received: from av9-2-sn4.m-sp.skanova.net ([81.228.10.107]:45985 "EHLO
	av9-2-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S265490AbUHTFou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 01:44:50 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm1
References: <20040816143710.1cd0bd2c.akpm@osdl.org>
	<20040816224749.A15510@infradead.org> <m3r7q4huei.fsf@telia.com>
	<20040819104534.B7641@infradead.org>
From: Peter Osterlund <petero2@telia.com>
Date: 20 Aug 2004 07:44:47 +0200
In-Reply-To: <20040819104534.B7641@infradead.org>
Message-ID: <m3n00qics0.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Thu, Aug 19, 2004 at 01:57:09AM +0200, Peter Osterlund wrote:
> > That can actually be avoided by letting the packet driver itself keep
> > track of how many unfinished bios there are in the CD request queue.
> > This is straightforward to implement.  The only small complication is
> > that incoming read requests need to be cloned so that the packet
> > driver can use a private bi_end_io function.
> 
> Neat, this looks pretty good.  Other comments on the pkt driver (not related
> to this patch):
> 
> in the blockdev ->open/->release->ioctl you can get your private data
> from inode->i_bdev->bd_disk->private_data instead of doing the lookup.

The release/ioctl functions should be no problems to convert, but how
do I prevent pkt_open() and pkt_remove_dev() from racing against each
other with your suggestion? Currently this is handled by the ctl_mutex
and the fact that pkt_find_dev_from_minor() returns NULL if the packet
device has gone away.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
