Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262814AbTJJP1d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 11:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbTJJP1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 11:27:33 -0400
Received: from agminet02.oracle.com ([141.146.126.229]:47265 "EHLO
	agminet02.oracle.com") by vger.kernel.org with ESMTP
	id S262814AbTJJP13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 11:27:29 -0400
Date: Fri, 10 Oct 2003 08:27:10 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
Message-ID: <20031010152710.GA28773@ca-server1.us.oracle.com>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Ulrich Drepper <drepper@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20031010122755.GC22908@ca-server1.us.oracle.com> <Pine.LNX.4.44.0310100756510.20420-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310100756510.20420-100000@home.osdl.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 07:59:34AM -0700, Linus Torvalds wrote:
> The interface is fundamentally flawed, it has nasty security issues, it 
> lacks any kind of sane synchronization, and it exposes stuff that 
> shouldn't be exposed to user space.

	Um, sure, the interface as implemented has a few "don't do
that"s.  Yes, we've found security issues.  Those can be fixed.  That
doesn't make the concept bad.

> I hope disk-based databases die off quickly.

	As opposed to what?  Not a challenge, just interested in what
you think they should be.

> Yeah, I see where you are
> working, but where I'm coming from, I see all the _crap_ that Oracle tries
> to push down to the kernel, and most of the time I go "huh - that's a
> f**king bad design".

	I'm hoping that you've seen a marked improvement in the stuff
Oracle requests over the past couple years.  We've worked hard to filter
out the junk that really, really is bad.
	Where I work doesn't change the need for O_DIRECT.  If your Big
App has it's own cache, why copy the cache in the kernel?  That just
wastes RAM.  If your app is sharing data, whether physical disk, logical
disk, or via some network filesystem or storage device, you must
absolutely guarantee that reads and writes hit the storage, not the
kernel cache which has no idea whether another node wrote an update or
needs a cache flush.
	Putting my employer's hat back on, Oracle uses O_DIRECT because
it was the existing API for this.  If Linux came up with a better,
cleaner method, Oracle might change.  I can't guarantee that, but I know
I push like hell for obvious improvements.

Joel

-- 

"I don't want to achieve immortality through my work; I want to
 achieve immortality through not dying."
        - Woody Allen

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
