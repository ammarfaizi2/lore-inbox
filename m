Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbVACVtC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbVACVtC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 16:49:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbVACVtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 16:49:02 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:13325 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261503AbVACVrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 16:47:20 -0500
Date: Mon, 3 Jan 2005 22:38:45 +0100
From: Willy Tarreau <willy@w.ods.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Adrian Bunk <bunk@stusta.de>, William Lee Irwin III <wli@debian.org>,
       Bill Davidsen <davidsen@tmr.com>, Andries Brouwer <aebr@win.tue.nl>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050103213845.GA18010@alpha.home.local>
References: <20050102221534.GG4183@stusta.de> <41D87A64.1070207@tmr.com> <20050103003011.GP29332@holomorphy.com> <20050103004551.GK4183@stusta.de> <20050103011935.GQ29332@holomorphy.com> <20050103053304.GA7048@alpha.home.local> <20050103123325.GV29332@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103123325.GV29332@holomorphy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 04:33:25AM -0800, William Lee Irwin III wrote:
 
> This is bizarre. iptables was made the de facto standard in 2.4.x and
> the alternatives have issues with functionality. The 2.0/2.2 firewalling
> interfaces are probably ready to go regardless. You do realize this is
> what you're referring to?
> 
> 2 major releases is long enough.

if it's long enough, ipfwadm should not have entered 2.6 at all. It's not
because you don't see any use to that particular feature that you can guarantee
that it is not used at all. At least, a large public call to get in touch with
the potentially unique user of this feature would be a start, but generally we
should not remove a feature from a stable kernel. What will go next ? minix,
because someone will decide that there have been many better filesystems for a
long time, so that's long enough ? Revert modules to modutils because someone
will think it's simpler for everyone to use a single toolset ? I have no
problem removing numerous feature between major releases, even breaking APIs,
but I really hate it when something which is called "stable" constantly
changes.

> On Mon, Jan 03, 2005 at 06:33:04AM +0100, Willy Tarreau wrote:
> > If the motivation to break backwards compatibility is not enough
> > anymore to justify development kernels, I don't know what will
> > justify it anymore. I'm particularly fed up by some developer's
> > attitude who seem to never go outside and see how their creations are
> > used by people who really trust the "stable" term... until they
> > realize that this word is used only for marketting,
> 
> Who do you think is actually banging out the code on this mailing list?

Frankly, sometimes I'm really wondering. We see lots of very clever ideas,
and sometimes people come up with concepts which can break existing apps, and
simply justify by "this should not have been done in the first time." (eg:
unexport syscall_table). But I'm certain that all these mistakes are caused
by those too long development cycles. Some developpers get bored by things that
irritate them, and prefer to fix the stable tree to stop what they believe is
an error, instead of waiting for the next release to fix it there.

> Anyway, features aren't really allowed to break backward compatibility;
> we've effectively got 10-year lifetimes for userspace-visible interfaces.
> If this isn't good enough, well, tough.

All in all, I agree with you. The small differences lie in /proc files or
oops syntax, etc... But even old syscalls are still supported and that's fine.
I appreciate it when I read the packet(7) man page to find that even the
interface from linux 2.0 is still supported.

The problem is that nowadays, the userspace-visible code is not only in
userspace anymore, but also involves modules interfaces sometimes because
some commercial apps rely on modules (firewalls, virtual machines, etc...),
and their userspace is nuts without those modules, so in a certain way,
breaking some kernel internals within a stable release does break some apps.

 
> On Mon, Jan 03, 2005 at 06:33:04AM +0100, Willy Tarreau wrote:
> > Why do you think that so many people are still using 2.4 (and even
> > older versions) ? This is because they are the only ones who don't
> > constantly change under your feet and from which you can build
> > something reliable and guaranteed maintainable. At least, I've not
> > seen any commercial product based on 2.6 yet !
> > Please, stop constantly changing the contents of the "stable" kernel.
> 
> Either this is some kind of sick joke or you've never heard of SLES9.

the later :-)

> On Sun, Jan 02, 2005 at 05:19:35PM -0800, William Lee Irwin III wrote:
(...) 
> You have ignored my entire argument in favor of reiterating your own.
> 
> One more time, since this apparently needs to be repeated in a
> condensed and/or simplified form.
> 
> (1) the "stable" kernels are actually buggier because no one's looking
I don't agree with you. "known" bugs become features of this particular
release and people learn how to play with them. The MM beahaviour when one
single user can crash the whole machine just accidentely playing with malloc()
would be called a bug on any other decent OS. For us it's a feature we have
been used to live with.

It's possible that 2.6 has fewer of those known bugs, but it still has many
yet-to-discover bugs (the first ones being all those 'my machine does not
boot anymore' reported here and caused by those too long release cycles).

> (2) the creation of those feature patches for stable kernels has
> 	detracted from the efforts needed to get them actually into
> 	the kernel, and they're not going to exist for long

I agree with you on the first part, but not on the second one, because as a
stable kernel implies it, it will still be possible to apply current patches
to new releases with very few efforts. Indeed, I have already sent rediffed
patches to different maintainers because they were easy to do. For a while
now, on 2.4, you can easily apply jiffies64, epoll, netdev-random, preempt,
lowlat, bme, squashfs, tux, etc... The list is long and demonstrantes what
stable code looks like. "stable" does not mean it will not crash, but it means
"it will not change much", eventhough this tends to imply the former.

> On Mon, Jan 03, 2005 at 06:33:04AM +0100, Willy Tarreau wrote:
> > At the moment, the only "serious" use I've found for a 2.6 is a kexec-based
> > bootloader for known hardware. I've already seen that maintaining it up to
> > date is not simple, I wonder how distro people work with it... I wouldn't
> > have to do their work right now.
> 
> People are already using it to run the databases their paychecks rely on.

I feel they're brave. I know several other people who went back, either because
they didn't feel comfortable with upgrades these size, which sometimes did not
boot because of random patches, or simply because of the scheduler which didn't
let them type normally in an SSH session on a CPU-bound system, or even a
proxy which performance dropped by a factor of 5 between 2.4 and 2.6. I know
they don't report it, but they are not developpers. They see that 2.6 is not
ready yet, and turn back to stable 2.4.

> Whatever else you had in mind can't be anticipated.

agreed.

Willy

