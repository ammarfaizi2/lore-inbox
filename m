Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265535AbUBAVOS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 16:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265546AbUBAVOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 16:14:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:1476 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265535AbUBAVOJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 16:14:09 -0500
Date: Sun, 1 Feb 2004 13:14:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: morgan@transmeta.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: permission() bug?
Message-Id: <20040201131457.2cf44e4c.akpm@osdl.org>
In-Reply-To: <1075638996.2424.13.camel@nb.suse.de>
References: <1075638996.2424.13.camel@nb.suse.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Gruenbacher <agruen@suse.de> wrote:
>
>  the fix for permission() that makes it compliant with POSIX.1-2001
>  apparently was lost. Here is the patch I sent before. (The relevant
>  lines from the standard text are cited in
>  http://www.ussg.iu.edu/hypermail/linux/kernel/0310.2/0286.html. The fix
>  proposed in that posting did not handle directories without execute
>  permissions correctly.)

Question is: should we fix it?  I'm not aware of any bug reports against
this behaviour, and there is the possibility that changing it now will
break some applications.

Yes, those applications are presumably broken on other OS's but that's
different.

Given that this has been a longstanding misbehaviour in Linux (yes?) maybe
the most prudent path is to remain bug-compatible?

I'll add the patch to -mm so we can pick up any obvious userspace breakage,
but it is likely that such problems will take a long time to emerge.

> The access(2) function does not conform to POSIX.1-2001: For root
> and a file with no permissions, access(file, MAY_READ|MAY_EXEC)
> returns 0 (it should return -1).

So are you saying that in this case access() is, in effect, returning

	access(file, MAY_READ) || access(file, MAY_EXEC)

whereas it should be returning

	access(file, MAY_READ) && access(file, MAY_EXEC)

?
