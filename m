Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315619AbSEIFb6>; Thu, 9 May 2002 01:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315620AbSEIFb5>; Thu, 9 May 2002 01:31:57 -0400
Received: from asooo.flowerfire.com ([63.254.226.247]:63204 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S315619AbSEIFb4>; Thu, 9 May 2002 01:31:56 -0400
Date: Thu, 9 May 2002 00:31:55 -0500
From: Ken Brownfield <ken@irridia.com>
To: Dan Kegel <dank@kegel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "khttpd-users@lists.alt.org" <khttpd-users@alt.org>
Subject: Re: khttpd newbie problem
Message-ID: <20020509003155.B12672@asooo.flowerfire.com>
In-Reply-To: <3CD402D2.E3A94CA2@kegel.com> <20020505005439.GA12430@krispykreme> <3CD4C93D.E543B188@kegel.com> <20020508222119.A12672@asooo.flowerfire.com> <3CDA0876.218285C7@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2002 at 10:26:14PM -0700, Dan Kegel wrote:
| Ken Brownfield wrote:
| > khttpd is very much production quality on IA32, and has been since
| > 2.4.0-test1. 
| 
| It oopses readily on start/stop -- see 
| http://marc.theaimsgroup.com/?l=linux-kernel&m=102068445316516&w=2
| in which DecodeHeader is called with no buffer allocated.
| Happened quite frequently during my tests.  Since my patch I
| can't get it to oops on x86, but it's still oopsing on ppc405.
| So perhaps now it's production quality... but it still needs
| a bit too much babying on stop.  (It'd be fairly easy to fix
| the unreliable way it senses the stop command.)

Hmm.  I've had it running *hard* for two years, never seen a single oops
or glitch of any sort, kernels 2.4.0-test1 through 2.4.18.  O(1),
preempt, low-latency all on at various times.  All static images though,
with no pass-through.

| > TUX2 is not, however, since under load it enters a 99% CPU
| > busy loop.
| 
| I checked the tux list and found the post you're taling about:
| http://marc.theaimsgroup.com/?l=tux-list&m=101420257421009&w=2
| Hmm.  Well, at least it doesn't oops :-)  Thanks for the warning.

Heh, no prob.  The most recent version might have fixed it, although the
last time I tried TUX2 I got a hard hang... prolly O(1) but I never had
time to narrow it down.

[...]
| where foo_load is a hacked version of http_load (I think)
| which is fetching a single 128KB file over and over.
| I tried reproducing this with acme.com's http_load, 
| without success so far.

Odd, seems identical to my standard traffic, though my images are in the
4-64k range.  What you're seeing seems to be an interaction problem --
something different in the non-mainstream, non-x86 kernel that's
allowing khttpd to hang itself.  No argument that khttpd is frightening.

[...]
| Yukky.  Makes me want to go work with user-mode web servers instead.

Yeah, good luck tracking down X15.  I've wanted to create a
heavily-modified apache MPM, but my time is unfortunately finite...

Apache2 on top of TUX2 would be ideal, but alas neither is quite
prime-time yet.
-- 
Ken.
ken@irridia.com

| 
| - Dan
