Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbWGPIGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWGPIGO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 04:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWGPIGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 04:06:14 -0400
Received: from canuck.infradead.org ([205.233.218.70]:16347 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S964833AbWGPIGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 04:06:13 -0400
Subject: Re: 2.6.18 Headers - Long
From: David Woodhouse <dwmw2@infradead.org>
To: Albert Cahalan <acahalan@gmail.com>
Cc: arjan@infradead.org, maillist@jg555.com, ralf@linux-mips.org,
       linux-kernel@vger.kernel.org, davem@davemloft.net
In-Reply-To: <787b0d920607152318o72634affhbb51b3826f8daee5@mail.gmail.com>
References: <787b0d920607151409q4d0dfcc1wc787d9dfe7b0a897@mail.gmail.com>
	 <1153000020.8427.16.camel@pmac.infradead.org>
	 <787b0d920607152318o72634affhbb51b3826f8daee5@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 16 Jul 2006 09:05:45 +0100
Message-Id: <1153037145.8427.42.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-16 at 02:18 -0400, Albert Cahalan wrote:
> On 7/15/06, David Woodhouse <dwmw2@infradead.org> wrote:
> > On Sat, 2006-07-15 at 17:09 -0400, Albert Cahalan wrote:
> 
> > > Don't blame app developers if they go for what is good.
> > > To stop them, provide the goodness in a sane way.
> > > (alternately, make the Linux code suck ass more than POSIX)
> >
> > Kernel headers are _not_ a library of random crap for userspace to use.
> 
> Says you, and a number of other people around here.
> App developers seem to feel differently. Accept reality.

I accept that app developers feel differently. I feel sympathy for them.
There, reality accepted -- can we get back to kernel business now?

Kernel headers are _not_ a library of random crap for userspace to use.

> > There is no justification for asm/atomic.h being installed
> > in /usr/include. Especially since, as Arjan points out, it doesn't
> > actually provide atomic operations in many cases anyway.
> 
> It's fixable via #ifdef __KERNEL__ of course.

No, it's fixed by commit e035cc35e54230eb704ee7feccf476ed2fb2ae29
already. Running 'make headers_install' in the kernel tree no longer
exports a copy of asm/atomic.h

The existence of #ifdef __KERNEL__ in a file not listed for export to
userspace should probably now be considered a bug, and eradicated.

> > If you want to provide a 'libkernelstuff', the GPL permits you to do
> > that. The kernel's ABI headers (and lkml) are not the appropriate 
> > place for such a project
> 
> Perhaps. This is duplication of effort though.

Not really. The kernel developers make no effort to ensure that this
stuff works in userspace -- as evidenced by the fact that it _doesn't_
actually work in userspace. If someone wants to take this kernel code
and make it work in userspace, that's effort which is entirely unique.

If someone wants to just whine that they _want_ it to be available (and
reliable) in userspace, then we don't care. It isn't viable in
userspace, it's _never_ been viable in userspace, and it's _your_ turn
to accept reality.

> You're the person trying to change the app developers.
> If you want to change them, provide an alternative that
> doesn't totally suck ass.

We're only talking about that subset of app developers who are still
abusing kernel headers despite the fact that they've repeatedly been
told not to and despite that fact that it's often actually broken to do
so (in the case of atomic.h, which is one of the more common abuses).

We've been trying to educate those morons for years, and they seem
particularly resilient to it. A consistent (and minimal) set of kernel
headers across distributions, selected and sanitised by Makefiles within
the kernel itself, may well do the trick though.

I don't see that we need to provide an alternative. These people will
find some other way to shoot themselves in the foot whatever we do.

> > Btw, your mail client omitted the References: and In-Reply-To: headers
> > which RFC2822 says it SHOULD have included. On a list with as much
> > traffic as linux-kernel, that's _very_ suboptimal, because you've
> > detached your message from the thread to which you replied. Please try
> > to fix or work around that.
> 
> Most clients won't allow adding such headers manually.
> I don't actually subscribe to the list. Most clients won't
> expire old list traffic, and I certainly can't have lkml pour
> unhindered into my inbox. It really doesn't work for me,
> so I cut and paste from a list archive. Sorry. Ideas are
> welcome of course, but I'm not expecting any reasonable
> solution to exist.

Mailing list archives ought to have mailto: links with &In-Reply-To= set
up properly so that you get a correct In-Reply-To: header when you click
on the link.

Personally, I just have lists pour 'unhindered' into their own folder,
so that I can behave considerately and keep threads together even when I
don't actually read the list in question very often. It's easy enough to
expire old mail. Actually I just archive it with a simple script
(http://david.woodhou.se/archivemail.sh) but it's trivial to just delete
it instead, if that's what you want.

-- 
dwmw2

