Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264163AbTKKAIz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 19:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264165AbTKKAIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 19:08:54 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:12962 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S264163AbTKKAIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 19:08:52 -0500
Subject: Re: [PATCH] cfq + io priorities
From: Albert Cahalan <albert@users.sf.net>
To: Jens Axboe <axboe@suse.de>
Cc: P@draigBrady.com, Albert Cahalan <albert@users.sourceforge.net>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20031110133746.GB32637@suse.de>
References: <E1AJ994-0002xM-00@gondolin.me.apana.org.au>
	 <1068469674.734.80.camel@cube> <3FAF9335.9010801@draigBrady.com>
	 <20031110133746.GB32637@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1068508372.734.116.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 10 Nov 2003 18:52:52 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-11-10 at 08:37, Jens Axboe wrote:
> On Mon, Nov 10 2003, P@draigBrady.com wrote:
> > Albert Cahalan wrote:
> > >Besides, the kernel load average was changed to
> > >include processes waiting for IO. It just plain
> > >makes sense to mix CPU usage with IO usage by
> > >default. Wanting different niceness for CPU
> > >and IO is a really unusual thing.
> > 
> > I strongly agree. Of course it would be
> > nice/necessary to have seperate nice values,
> > but setting the global one should set the
> > underlying ones (cpu, disk, ...) also.
> 
> Global one? nice is CPU in Linux, period.
> ionice is io priority. I'm not going to
> change this. So Albert and you can agree
> as much as you want, unless you have some
> heavier arguments it's not going to help
> one bit.

In other words, you're ignoring at least 3
people because you can. Coder's right, etc.

FWIW, here's a heavier argument.

I studied the UNIX spec today. I find nothing
that says the "nice" value is only for %CPU.

Your objection has been raised before, when
Linus changed the load average computation
to include processes waiting for IO. Linus
argued that users were really interested in
the feel of the system, no matter what the
source of load. That applies here as well.

In other words, it's a bug that some sources
of load aren't handled (viewed, limited, etc.)
by the normal mechanisms.

I have at least 27 binaries on my system that
use nice() in an attempt to reduce system load
(as in xlock) or increase their ability to
get things done. I can't think of a case in
which a matching IO priority wouldn't be desired.
It sure sounds painful to modify all those
binaries to do what is really wanted, especially
for the ones that aren't Linux-specific and
managed with autoconf.

I suppose the nice() wrapper in glibc could
be modified... but that's kind of silly when
the kernel is getting modified anyway.


