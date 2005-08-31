Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbVHaEdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbVHaEdk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 00:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbVHaEdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 00:33:40 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:27835 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932353AbVHaEdk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 00:33:40 -0400
Date: Wed, 31 Aug 2005 14:33:10 +1000
From: Nathan Scott <nathans@sgi.com>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blk queue io tracing support
Message-ID: <20050831143309.A4434621@wobbly.melbourne.sgi.com>
References: <20050823123235.GG16461@suse.de> <20050824010346.GA1021@frodo> <20050824070809.GA27956@suse.de> <20050824171931.H4209301@wobbly.melbourne.sgi.com> <20050824072501.GA27992@suse.de> <20050824092838.GB28272@suse.de> <20050830234823.GF780@frodo> <20050830235824.GG780@frodo> <17173.12216.263860.76176@tut.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <17173.12216.263860.76176@tut.ibm.com>; from zanussi@us.ibm.com on Tue, Aug 30, 2005 at 11:19:04PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Tue, Aug 30, 2005 at 11:19:04PM -0500, Tom Zanussi wrote:
> You're right, it should be using simple_rmdir rather than
> simple_unlink for removing directories.  Thanks for sending the patch,

No problem.

> which I've modified a bit to avoid splitting the rmdir/unlink cases
> into separate functions, since they're almost the same except for what
> they end up calling.  relayfs_remove_dir now doesn't do anything but
> call relayfs_remove (it didn't do much more than that before anyway),
> but it makes sense to me to keep it, as the counterpart to
> relayfs_create_dir.  Let me know if you see any problems with it.

Looks OK, I'll give it a spin.

On an unrelated note, are there any known issues with using epoll
on relayfs file descriptors?  I'm having a few troubles, and just
wondering if its me doing something silly, or if its known to not
work...?  Symptoms of the problem are epoll continually reaching
its timeout with no modified fds found (when I know the inode has
modified trace buffers attached) ... and the epoll code is a bit
too hairy for me to go find a quick fix - seems like it should be
able to work though since relayfs has a ->poll implementation.

cheers.

-- 
Nathan
