Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262666AbTJPHK6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 03:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262723AbTJPHK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 03:10:58 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:60636 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262666AbTJPHK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 03:10:56 -0400
Date: Thu, 16 Oct 2003 09:10:55 +0200
From: Jens Axboe <axboe@suse.de>
To: Greg Stark <gsstark@mit.edu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ide write barrier support
Message-ID: <20031016071055.GI1128@suse.de>
References: <20031013140858.GU1107@suse.de> <871xtfjhhh.fsf@stark.dyndns.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871xtfjhhh.fsf@stark.dyndns.tv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 14 2003, Greg Stark wrote:
> 
> Jens Axboe <axboe@suse.de> writes:
> 
> > Hi,
> > 
> > Forward ported and tested today (with the dummy ext3 patch included),
> > works for me. Some todo's left, but I thought I'd send it out to gauge
> > interest. TODO:
> 
> 
> Is there a user-space interface planned for this? 

I don't have one planned.

> One possibility may be just to hang it off fsync(2) so fsync doesn't
> return until until all the buffers it flushed are actually synced to
> disk. That's its documented semantics anyways.

Makes sense, indeed.

> There's also the case of files opened with O_SYNC. Would inserting a
> write barrier after every write to such a file destroy performance?

If it's mainly sequential io, then no it won't destroy performance. It
will be lower than without the cache flush of course.

-- 
Jens Axboe

