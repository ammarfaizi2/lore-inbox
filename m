Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbVHaE5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbVHaE5M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 00:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbVHaE5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 00:57:12 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:55480 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932360AbVHaE5L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 00:57:11 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17173.14417.324497.140819@tut.ibm.com>
Date: Tue, 30 Aug 2005 23:55:45 -0500
To: Nathan Scott <nathans@sgi.com>
Cc: Tom Zanussi <zanussi@us.ibm.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blk queue io tracing support
In-Reply-To: <20050831143309.A4434621@wobbly.melbourne.sgi.com>
References: <20050823123235.GG16461@suse.de>
	<20050824010346.GA1021@frodo>
	<20050824070809.GA27956@suse.de>
	<20050824171931.H4209301@wobbly.melbourne.sgi.com>
	<20050824072501.GA27992@suse.de>
	<20050824092838.GB28272@suse.de>
	<20050830234823.GF780@frodo>
	<20050830235824.GG780@frodo>
	<17173.12216.263860.76176@tut.ibm.com>
	<20050831143309.A4434621@wobbly.melbourne.sgi.com>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott writes:
 > Hi Tom,
 > 
 > On Tue, Aug 30, 2005 at 11:19:04PM -0500, Tom Zanussi wrote:
 > > You're right, it should be using simple_rmdir rather than
 > > simple_unlink for removing directories.  Thanks for sending the patch,
 > 
 > No problem.
 > 
 > > which I've modified a bit to avoid splitting the rmdir/unlink cases
 > > into separate functions, since they're almost the same except for what
 > > they end up calling.  relayfs_remove_dir now doesn't do anything but
 > > call relayfs_remove (it didn't do much more than that before anyway),
 > > but it makes sense to me to keep it, as the counterpart to
 > > relayfs_create_dir.  Let me know if you see any problems with it.
 > 
 > Looks OK, I'll give it a spin.
 > 
 > On an unrelated note, are there any known issues with using epoll
 > on relayfs file descriptors?  I'm having a few troubles, and just
 > wondering if its me doing something silly, or if its known to not
 > work...?  Symptoms of the problem are epoll continually reaching
 > its timeout with no modified fds found (when I know the inode has
 > modified trace buffers attached) ... and the epoll code is a bit
 > too hairy for me to go find a quick fix - seems like it should be
 > able to work though since relayfs has a ->poll implementation.

Well, the relayfs poll implementation is based on completed
sub-buffers, so you can be writing events into a buffer, but until a
buffer switch happens, you won't be notified that anything's changed.
The reason for the sub-buffer granularity is that relayfs was
originally meant for use only with mmap(), but now that there's a
read(), I'll probably have to make some changes to the poll
implementation as well.

Tom


