Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265872AbTL3XJX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 18:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265803AbTL3XHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 18:07:47 -0500
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:44763 "EHLO
	asmodeus.mcnaught.org") by vger.kernel.org with ESMTP
	id S265808AbTL3XE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 18:04:57 -0500
To: bluefoxicy@linux.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Slab allocator . . . cache?  WTF is it?
References: <20031230221859.15F503956@sitemail.everyone.net>
From: Doug McNaught <doug@mcnaught.org>
Date: Tue, 30 Dec 2003 18:04:54 -0500
In-Reply-To: <20031230221859.15F503956@sitemail.everyone.net> (john moser's
 message of "Tue, 30 Dec 2003 14:18:58 -0800 (PST)")
Message-ID: <87znd9lxex.fsf@asmodeus.mcnaught.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/20.7 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john moser <bluefoxicy@linux.net> writes:

> I'm wondering, what IS cache?  It seems to increase even when swap
> is not used, and sometimes when there's no swap partition enabled.
> It also seems to cause me to run into swap when I have ample ram
> available, assuming that cache is just some sort of cache that is
> copied from and mirrors another portion of ram for some sort of
> speed increase.  It's wasteful to me, and I want to more understand
> its implimentation and its purpose, and in all honesty limit its
> impact if possible.

Short answer: cache is the use of memory to store what would otherwise
have to be read from disk, like parts of frequently used files etc.
Linux will trade off cache against other RAM needs like program memory
on an ongoing basis, and (almost always) does a really good job of it.

Don't be alarmed about going into swap somewhat in normal
operation--Linux is storing less important data on the disk to make
more room in RAM for "hot" data.  Obviously, if you have hundreds of
megs in swap or it grows quickly, you may need to look at it.

> I got this RAM upgrade because I was using about 676M of RAM total,
> including swap, at peak; and now I find myself using 820M RAM at
> peak and about 750-800 continually.

That means the kernel is doing exactly what it's supposed to do.  If
memory isn't needed by programs and isn't used for cache, it just goes
to waste, so Linux tries to use it for one or the other.  :)

-Doug
