Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbTIRPB5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 11:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbTIRPB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 11:01:57 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:39045
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S261449AbTIRPBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 11:01:55 -0400
Date: Thu, 18 Sep 2003 17:01:53 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@parcelfarce.linux.theplanet.co.uk>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: 2.4.23pre4 VM breaks in LTP
Message-ID: <20030918150152.GG1301@velociraptor.random>
References: <p73llsmlgrx.fsf@oldwotan.suse.de> <Pine.LNX.4.44.0309180929260.2846-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309180929260.2846-100000@logos.cnet>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 18, 2003 at 09:42:26AM -0300, Marcelo Tosatti wrote:
> 
> 
> Andrea, do you have any idea of what could cause this? A missing merge may
> be the cause, as Andi pointed out. I wont have time to look further into 
> it during the weekend and next week (Europe conferences). 
> 
> Andi, about the ext3 BUG I'm waiting for Stephen. I remember he knew how
> to fix the issue but didnt had the patch ready yet sometime ago.

it maybe a partial merge, though in theory the different patches had to
be mostly orthogonal. but I think it would be interesting to reproduce
on x86 too first just to be sure it's a generic issue (especially the
numa kernels are unstable for me even with the needed numa fixes and
numa is totally broken in mainline, it misses lots of numa fixes, so
without further details it's not obvious it's a missing merge and not
the lack of additional orthogonal fixes, either numa that we know for
sure or ext3 that crashes with ltp)

> 
> On 18 Sep 2003, Andi Kleen wrote:
> 
> 
> > 
> > FYI
> > 
> > When I run LTP on 2.4.23pre4 the machine deadlocks in mem01.
> > It is still pingable, but login etc. do not manage to fork anything.
> > 
> > mem01 simply allocates all free memory and free swap (as seen
> > in /proc/meminfo) and touches a single page in this mapping, then
> > exits. 
> > 
> > I saw the problem on a 1GB RAM + 1GB swap x86-64 box
> > 
> > (note that on 32bit the limit is 1GB max, so in many cases it will
> > not trigger on 32bit)
> > 
> > When I change mem01 to allocate 10% less memory it does not hang the box.
> > And UL -aa kernel also doesn't hang it, so it's probably some half merge.
> > 
> > Also the ext3 BUG on x86-64 can be also triggered with multiple LTP
> > runs.
> 
> 


Andrea

/*
 * If you refuse to depend on closed software for a critical
 * part of your business, these links may be useful:
 *
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.5/
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.4/
 * http://www.cobite.com/cvsps/
 *
 * svn://svn.kernel.org/linux-2.6/trunk
 * svn://svn.kernel.org/linux-2.4/trunk
 */
