Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269198AbUIBVoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269198AbUIBVoJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 17:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269201AbUIBVmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 17:42:25 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:17413 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S269180AbUIBVkE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 17:40:04 -0400
Date: Thu, 2 Sep 2004 14:37:55 -0700
To: Diego Calleja <diegocg@teleline.es>
Cc: Bill Huey <bhuey@lnxw.com>, jgarzik@pobox.com, torvalds@osdl.org,
       tmv@comcast.net, linux-kernel@vger.kernel.org
Subject: Re: Userspace file systems & MKs (Re: silent semantic changes with reiser4)
Message-ID: <20040902213755.GA15605@nietzsche.lynx.com>
References: <20040826163234.GA9047@delft.aura.cs.cmu.edu> <Pine.LNX.4.58.0408260936550.2304@ppc970.osdl.org> <20040831033950.GA32404@zero> <Pine.LNX.4.58.0408302055270.2295@ppc970.osdl.org> <413400B6.6040807@pobox.com> <20040831053055.GA8654@nietzsche.lynx.com> <4134131D.6050001@pobox.com> <20040831155613.2b25df1e.diegocg@teleline.es> <20040831205211.GA23395@nietzsche.lynx.com> <20040902192058.64f3ee03.diegocg@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040902192058.64f3ee03.diegocg@teleline.es>
User-Agent: Mutt/1.5.6+20040818i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 07:20:58PM +0200, Diego Calleja wrote:
> El Tue, 31 Aug 2004 13:52:11 -0700 Bill Huey (hui) <bhuey@lnxw.com> escribi?:
> 
> > As you can see the numbers are very fast for a general purpose system
> > like that. Add that with their XIO framework for data propagation and
> 
> For the syscall case, I remember that they would be able to "batch" syscalls,
> so this framework could have even better performance in some cases.
> The good thing is that they didn't do it just for the sake of doing it
> (like microkernel people) but to achieve their goals (SSI, etc)

For what they're doing, they have minimize the overhead cross boundaries
as much as possible for usage in both user and kernel spaces. If dfBSD
achieves what they intend to do, they'll have on of the best SSI systems
on the planet and it'll be able to use the VFS layer in ways that other
systems can't even touch with iSCSI drivers, etc...

They've got process suspend and restore already in order to support
serialization across machines. Having it VFS driven, VM objects, etc...
makes the concept of migration a function of the VFS layer. It's quite
clever and I'm sure that it's driven by Matt's experience with distributed
databases, specifically Backplane.

All locking in his system is CPU local, no mutexes of any sort, so
migration as a function of messaging, scheduling and other things are
done in per-CPU chunks. It's quite clever make handling in per-process
resources chunks.

	http://twiki.im.ufba.br/pub/MAT154/WebHome/duality78.pdf

Talks about part of this and how "procedural" is isomorphic to "message-passing"
concurrency system. One can be transformed to another.

It's a project that's move much faster in the area of SMP than FreeBSD 5.x
(Solaris style SMP) and really the only BSD project on this planet that has
the talent and social chemistry to make it happen.

bill

