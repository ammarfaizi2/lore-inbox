Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265596AbUBBDv7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 22:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265602AbUBBDv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 22:51:59 -0500
Received: from ns.suse.de ([195.135.220.2]:44491 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265596AbUBBDv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 22:51:57 -0500
Subject: Re: permission() bug?
From: Andreas Gruenbacher <agruen@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: morgan@transmeta.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <20040201131457.2cf44e4c.akpm@osdl.org>
References: <1075638996.2424.13.camel@nb.suse.de>
	 <20040201131457.2cf44e4c.akpm@osdl.org>
Content-Type: text/plain
Organization: SUSE Labs, SUSE LINUX AG
Message-Id: <1075693924.7651.17.camel@nb.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 02 Feb 2004 04:52:04 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-02-01 at 22:14, Andrew Morton wrote:
> Andreas Gruenbacher <agruen@suse.de> wrote:
> >
> >  the fix for permission() that makes it compliant with POSIX.1-2001
> >  apparently was lost. Here is the patch I sent before. (The relevant
> >  lines from the standard text are cited in
> >  http://www.ussg.iu.edu/hypermail/linux/kernel/0310.2/0286.html. The fix
> >  proposed in that posting did not handle directories without execute
> >  permissions correctly.)
> 
> Question is: should we fix it?  I'm not aware of any bug reports against
> this behaviour, and there is the possibility that changing it now will
> break some applications.

We certainly should fix this bug. Michael Kerrisk has compared other
UNIXes in
http://linux.derkeiler.com/Mailing-Lists/Kernel/2003-10/6030.html; this
shows slightly better what is wrong. That message does not cover the
directory case though; for directories, execute access is always granted
to privileged users.

I don't expect any applications to break. We have had the patch I
attached to the previous message (not the one in the old messages!) in
the SUSE 2.6 kernel since roughtly two months now; it has undergone a
lot of testing.

> Yes, those applications are presumably broken on other OS's but that's
> different.
> 
> Given that this has been a longstanding misbehaviour in Linux (yes?) maybe
> the most prudent path is to remain bug-compatible?

Andries has already answered this. (Thank you!)

> I'll add the patch to -mm so we can pick up any obvious userspace breakage,
> but it is likely that such problems will take a long time to emerge.
> file, MAY_EXEC)

I'm fine with that as well, but I think the patch should go straight to
mainline.


Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG

