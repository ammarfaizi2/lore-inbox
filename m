Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264111AbTEGRVK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 13:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264112AbTEGRVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 13:21:09 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:60127 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264111AbTEGRVI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 13:21:08 -0400
Date: Wed, 7 May 2003 19:33:41 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 ide 48-bit usage
Message-ID: <20030507173341.GP823@suse.de>
References: <20030507164613.GN823@suse.de> <Pine.LNX.4.44.0305071013001.2997-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305071013001.2997-100000@home.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07 2003, Linus Torvalds wrote:
> 
> On Wed, 7 May 2003, Jens Axboe wrote:
> > 
> > I dunno what the purpose of that would be exactly, I guess to cater to
> > some hardware odditites?
> 
> And testing. In particular, you might want to test whether a device 
> properly supports 48-bit addressing, either from the kernel or from user 
> programs.

For that, a forced 48-bit hwif->addressing inherited by drives will
suffice. And I agree, we should have that.

See, the logic in the kernel right now is just to check whether the
drive supports 48-bit commands. If it does, we use them like we would
28-bit commands. We eat the extra overhead, and do nothing to take
advantage of it (except using big drives, of course). What's the
logic in that?!

> Also, if you want to re-create some particular IO pattern for debugging, 
> you may want to explicitly use 48-bit addressing.

Then you just recreate those commands, there's absolutely no need for
anything special in this case. And the current patch neither explicitly
allows or disallows anything that the stock kernel doesn't.

If you are doing that from userspace by sending in taskfiles with the
appropriate commands, then you just create the commands like you want
them. rq_lba48() just checks whether file system requests should be
executed with 28 or 48-bit commands. If you send in taskfiles (your
SG_IO example), you have complete control over this already.

-- 
Jens Axboe

