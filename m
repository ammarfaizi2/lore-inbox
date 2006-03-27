Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751449AbWC0TtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWC0TtY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 14:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWC0TtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 14:49:24 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:22489
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751449AbWC0TtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 14:49:23 -0500
From: Rob Landley <rob@landley.net>
To: Avi Kivity <avi@argo.co.il>
Subject: Re: [RFC][PATCH 0/2] KABI example conversion and cleanup
Date: Mon, 27 Mar 2006 14:48:54 -0500
User-Agent: KMail/1.8.3
Cc: Arjan van de Ven <arjan@infradead.org>, Kyle Moffett <mrmacman_g4@mac.com>,
       nix@esperi.org.uk, mmazur@kernel.pl, linux-kernel@vger.kernel.org,
       llh-discuss@lists.pld-linux.org
References: <200603141619.36609.mmazur@kernel.pl> <200603261618.30090.rob@landley.net> <442783E3.3050808@argo.co.il>
In-Reply-To: <442783E3.3050808@argo.co.il>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603271448.56645.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 March 2006 1:19 am, Avi Kivity wrote:
> Rob Landley wrote:
> > On Sunday 26 March 2006 12:57 pm, Avi Kivity wrote:
> >> This is true for a small enough application. But things grow, libraries
> >> are added, and includes keep pulling other includes in. Sooner or later
> >> you'll have a collision.
> >
> > And you'll fix it when it happens.  Fact of life.
>
> Fixing it will mean breaking either the ABI of the kernel or of the
> large library you pulled in.
>
> An ABI bug causes pain far beyond its size. Look at the trouble caused
> when some interfaces uses unsigned instead of u64. In kernel APIs, you
> just replace the type, but in the ABI, you add a new syscall or do some
> other hack.

One of busybox's users has a libc built with improperly sanitized kernel 
headers that leak all the kernel's CONFIG_ symbols into the standard 
namespace, and we found out because one of them clashes with a busybox CONFIG 
symbol and it broke his build.

The easiest thing to do was rename our CONFIG symbol, which we did.  (And 
asked him to fix his system, which he didn't.)  This was a while ago now...

> Much better to get it right the first time, even if it's ugly. It's an
> ABI, not a beauty contest nominee.

I've been cc'd on all this because I cared about Mazur's kernel headers enough 
to email him several times.  But I can't say I really care about this new 
project that's taken over the discussion.

Either it doesn't break the existing interface, in which case it has no impact 
on me and I can ignore it, or it requires all existing userspace programs 
that care about the current state of things to change to care about your new 
thing instead, in which case it's probably doomed.  Unless the kernel picks 
it up and imposes a flag day, at which point I'll find out about it from LWN 
like everybody else.

Either way, it's not sounding like something I can grab and build uClibc 
systems with any time soon, the way I could use Mazur's headers to build 
uClibc.  I'll probably wind up using the gentoo headers when the 2.6.14 
version ships.

http://www.gentoo.org/cgi-bin/viewcvs.cgi/src/patchsets/gentoo-headers/?root=gentoo

*shrug*.  Good luck with whatever it is you're trying to accomplish.

Rob
-- 
Never bet against the cheap plastic solution.
