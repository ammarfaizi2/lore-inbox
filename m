Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264092AbTEGRiB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 13:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264102AbTEGRiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 13:38:01 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:23781 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264092AbTEGRh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 13:37:59 -0400
Date: Wed, 7 May 2003 19:50:33 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 ide 48-bit usage
Message-ID: <20030507175033.GR823@suse.de>
References: <20030507173341.GP823@suse.de> <Pine.LNX.4.44.0305071039490.2997-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305071039490.2997-100000@home.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07 2003, Linus Torvalds wrote:
> 
> On Wed, 7 May 2003, Jens Axboe wrote:
> > > 
> > > And testing. In particular, you might want to test whether a device 
> > > properly supports 48-bit addressing, either from the kernel or from user 
> > > programs.
> > 
> > For that, a forced 48-bit hwif->addressing inherited by drives will
> > suffice. And I agree, we should have that.
> 
> No no no.
> 
> You definitely do NOT want to set "hwif->addressing" to 1 before you've 
> tested whether it even _works_.

Well duh, of course not. Whether a given request is executed in 48-bit
or not is a check that _includes_ drive capabilities too of course.

> Imagine something like "hdparm" - other things are already in progress,
> the system is up, and IDE commands are potentially executing concurrently.  
> What something like that wants to do is to send one request out to check
> whether 48-bit addressing works, but it absolutely does NOT want to set 
> some interface-global flag that affects other commands.

Then it just puts a taskfile request on the request queue and lets it
reach the drive, nicely syncronized with the other requests. There's no
need to toggle any special bits for that.

> Only after it has verified that 48-bit addressing does work should it set 
> the global flag.

Sounds fine.

-- 
Jens Axboe

