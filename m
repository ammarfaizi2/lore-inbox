Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264168AbTEGRah (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 13:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264169AbTEGRah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 13:30:37 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53516 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264168AbTEGRad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 13:30:33 -0400
Date: Wed, 7 May 2003 10:42:49 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jens Axboe <axboe@suse.de>
cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 ide 48-bit usage
In-Reply-To: <20030507173341.GP823@suse.de>
Message-ID: <Pine.LNX.4.44.0305071039490.2997-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 7 May 2003, Jens Axboe wrote:
> > 
> > And testing. In particular, you might want to test whether a device 
> > properly supports 48-bit addressing, either from the kernel or from user 
> > programs.
> 
> For that, a forced 48-bit hwif->addressing inherited by drives will
> suffice. And I agree, we should have that.

No no no.

You definitely do NOT want to set "hwif->addressing" to 1 before you've 
tested whether it even _works_.

Imagine something like "hdparm" - other things are already in progress,
the system is up, and IDE commands are potentially executing concurrently.  
What something like that wants to do is to send one request out to check
whether 48-bit addressing works, but it absolutely does NOT want to set 
some interface-global flag that affects other commands.

Only after it has verified that 48-bit addressing does work should it set 
the global flag.

> If you are doing that from userspace by sending in taskfiles with the
> appropriate commands, then you just create the commands like you want
> them. rq_lba48() just checks whether file system requests should be
> executed with 28 or 48-bit commands. If you send in taskfiles (your
> SG_IO example), you have complete control over this already.

That may well be sufficient. 

		Linus

