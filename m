Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbTEFRvi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 13:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263964AbTEFRvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 13:51:38 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:15061 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263962AbTEFRvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 13:51:36 -0400
Date: Tue, 6 May 2003 20:04:08 +0200
From: Jens Axboe <axboe@suse.de>
To: Pascal Schmidt <der.eremit@email.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [IDE] trying to make MO drive work with ide-floppy/ide-cd
Message-ID: <20030506180408.GH905@suse.de>
References: <20030506152543.GX905@suse.de> <Pine.LNX.4.44.0305061949150.1040-100000@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305061949150.1040-100000@neptune.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06 2003, Pascal Schmidt wrote:
> On Tue, 6 May 2003, Jens Axboe wrote:
> 
> > You can play with the c code, you've demonstrated that much so far. So
> > play some more, find out which commands are aborted and why. The log
> > messages even tell you which ones. Now find out if these are necessary
> > for proper MO functionality or not. Or maybe some vital commands are
> > even missing, lots of fun there :). But it really should not be very
> > hard.
> 
> Ok, I got a little bit further with the patch below. I can mount to disk
> read-write and do a few things:
> 
> $ mount -t ext2 /dev/hde /mnt/mo
> $ echo "foo" > /mnt/mo/bar
> $ cat /mnt/mo/bar
> foo
> $ sync
> 
> No problem so far. But then
> 
> $ umount /mnt/mo
> 
> gets me:
> 
> ------------[ cut here ]------------
> kernel BUG at fs/buffer.c:2607!

Not good. Does it work correctly with 2kb block size? I would not be
surprised if ide-cd had multi page bio bugs...

> My patch:

Not bad, see that wasn't so hard. Does it load ide-cd without errors
with this one?

-- 
Jens Axboe

