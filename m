Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268467AbUJFGl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268467AbUJFGl7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 02:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268648AbUJFGl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 02:41:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:57789 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268467AbUJFGlz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 02:41:55 -0400
Date: Tue, 5 Oct 2004 23:39:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: nickpiggin@yahoo.com.au, kenneth.w.chen@intel.com, mingo@redhat.com,
       linux-kernel@vger.kernel.org, judith@osdl.org
Subject: Re: new dev model (was Re: Default cache_hot_time value back to
 10ms)
Message-Id: <20041005233958.522972a9.akpm@osdl.org>
In-Reply-To: <41638E61.9000004@pobox.com>
References: <200410060042.i960gn631637@unix-os.sc.intel.com>
	<20041005205511.7746625f.akpm@osdl.org>
	<416374D5.50200@yahoo.com.au>
	<20041005215116.3b0bd028.akpm@osdl.org>
	<41637BD5.7090001@yahoo.com.au>
	<20041005220954.0602fba8.akpm@osdl.org>
	<416380D7.9020306@yahoo.com.au>
	<20041005223307.375597ee.akpm@osdl.org>
	<41638E61.9000004@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Andrew Morton wrote:
> > Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> > 
> >>Any thoughts about making -rc's into -pre's, and doing real -rc's?
> > 
> > 
> > I think what we have is OK.  The idea is that once 2.6.9 is released we
> > merge up all the well-tested code which is sitting in various trees and has
> > been under test for a few weeks.  As soon as all that well-tested code is
> > merged, we go into -rc.  So we're pipelining the development of 2.6.10 code
> > with the stabilisation of 2.6.9.
> > 
> > If someone goes and develops *new* code after the release of, say, 2.6.9
> > then tough tittie, it's too late for 2.6.9: we don't want new code - we
> > want old-n-tested code.  So your typed-in-after-2.6.9 code goes into
> > 2.6.11.
> > 
> > That's the theory anyway.  If it means that it takes a long time to get
> 
> This is damned frustrating :(  Reality is _far_ divorced from what you 
> just described.

s/far/a bit/

> Major developers such as David and Al don't have trees that see wide 
> testing, their code only sees wide testing once it hits mainline.  See 
> this message from David, 
> http://marc.theaimsgroup.com/?l=linux-netdev&m=109648930728731&w=2
> 

Yes, networking has been an exception.  I think this has been acceptable
thus far because historically networking has tended to work better than
other parts of the kernel.  Although the fib_hash stuff was a bit of a
fiasco.

> In particular, I think David's point about -mm being perceived as overly 
> experimental is fair.

I agree - -mm breaks too often.  You wouldn't believe the crap people throw
at me :(.   But a lot of problems get fixed this way too.

> Recent experience seems to directly counter the assertion that only 
> well-tested code is landing in mainline, and it's not hard to pick 
> through the -rc changelogs to find non-trivial, non-bugfix modifications 
> to existing code.

Once we hit -rc2 we shouldn't be doing that.

>  My own experience with netdev-2.6 bears this out as 
> well:  I have several personal examples of bugs sitting in netdev (and 
> thus -mm) for quite a while, only being noticed when the code hits mainline.

yes, I've had a couple of those.  Not too many, fortunately.  But having
bugs leak in mainline is OK - we expect that.  As long as it wasn't late in
the cycle.  If it was late in the cycle then, well,
bad-call-won't-do-that-again.

> Linus's assertion that "calling it -rc means developers should calm 
> down" (implying we should start concentrating on bug fixing rather than 
> more-fun stuff) is equally fanciful.
> 
> Why is it so hard to say "only bugfixes"?

(It's not "only bugfixes".  It's "only bugfixes, completely new stuff and
documentation/comment fixes).

But yes.  When you see this please name names and thwap people.

> The _reality_ is that there is _no_ point in time where you and Linus 
> allow for stabilization of the main tree prior to relesae.  The release 
> criteria has devolved to a point where we call it done when the stack of 
> pancakes gets too high.

That's simply wrong.

For instance, 2.6.8-rc1-mm1-series had 252 patches.  I'm now sitting on 726
patches.  That's 500 patches which are either non-bugfixes or minor
bugfixes which are held back.  The various bk tree maintainers do the same
thing.

