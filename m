Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbVATS3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVATS3F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 13:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbVATSYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 13:24:05 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:23244 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261731AbVATSQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 13:16:31 -0500
Message-ID: <41EFF581.6050108@comcast.net>
Date: Thu, 20 Jan 2005 13:16:33 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
References: <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org> <20050113082320.GB18685@infradead.org> <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org> <1105635662.6031.35.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0501130909270.2310@ppc970.osdl.org> <41E6BE6B.6050400@comcast.net> <20050119103020.GA4417@elte.hu> <41EE96E7.3000004@comcast.net> <20050119174709.GA19520@elte.hu> <41EEA86D.7020108@comcast.net> <20050120104451.GE12665@elte.hu>
In-Reply-To: <20050120104451.GE12665@elte.hu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Ingo Molnar wrote:
> * John Richard Moser <nigelenki@comcast.net> wrote:
> 
> 
>>I respect you as a kernel developer as long as you're doing preemption
>>and schedulers; [...]
> 
> 
> actually, 'preemption and schedulers' ignores 80% of my contributions to
> Linux so i'm not sure what to make of your comment :-| Here's a list of
> bigger stuff i worked on in the past 3-4 years:
> 
>   http://redhat.com/~mingo/
> 
> as you can readily notice from the directory names alone, 'preemption
> and schedulers' is pretty much in the minority :-|
> 
> and that list i think sums up the main difference in mindset: to me,
> exec-shield is 'just' another kernel feature (amongst dozens), which
> solves a problem. I'm not attached to the concept/patch emotionally, i
> only want to see a solution for a problem in a pragmatic way. Playing
> with lowlevel segment details is not nice and not always fun and results
> in tradeoffs i dont like, but it's pretty much the only technique that
> works on older x86 CPUs (as PaX has proven it too). If something better
> comes along, then more power to it.
> 
> 

Granted, you're somewhat more diverse than I pointed out; but I don't
keep up on what you're doing.  The point was more that you're not a
major security figure and/or haven't donated your life to security and
forsaken all lovers before it like Joshua Brindle or Brad Spengler or
whoever the anonymous guy who developes PaX is.  I guess less focus on
the developer and more focus on the development.

>>[...] but I honestly think PaX is the better technology, and I think
>>it's important that the best security technology be in place. [...]
> 
> 
> i like PaX's completeness, and it has different tradeoffs. There is one
> major and two medium tradeoffs that PaX has, from a distributor's POV:
> 
> 1) the halving of the per-process VM space from 3GB to 1.5GB.
> 

Which has *never* caused a problem in anything I've ever used, and can
be disabled on a per-process basis.

> [ 2) the technique PaX uses (mirrored vmas) is pretty complex in terms
>      of MM code. ]
> 

*shrug*  The kernel's basic initialization code is in assembly.  On 40
different platforms.  That's pretty complex in terms of kernel code,
which is 99.998% C.

> [ 3) requires manual tagging of applications. ]
> 

Good.  Maybe distributors will actually know what they're talking about
when flapping their mouths, rather than say "Oh look PaX it's magic so
we just need to turn it on!"  Even I (at user level) examine everything
I'm using and try to understand it; I don't expect all users to do this,
but the distribution has to.

Once I was on the SELinux toy box (a honeypot-type thing) that Gentoo
set up, with root.  The first thing I did was run a 2-line shell command
to scan for and inform me of any areas I could write to.  I was only
supposed to be able to write to /tmp, but I found 2 or 3 more.  Holes in
the Gentoo SELinux policy, which PeBenito fixed in about 2 minutes.

He had to write that policy by hand.  How bad do you think it'd have
been--not just what I caught, but what I wouldn't have been able to
catch with just a cursory look, maybe serious flaws--if the policy was
automatically generated?  I could only imagine auto-generated policy,
drop-in, you think you're secure for a good long while. . . .

Even when the tagging is all automatic, to really deploy a competantly
formed system you have to review the results of the automated tagging.
It's a bit easier in most cases to automate-and-review, but it still has
to be done.  I think in the case of PaX markings, the maintenance
overhead of manually marking binaries is minimal enough that looking for
mistakes would be more work than working from an already known and
familiar base.

Also, a modified toolchain spits out ELF binaries with -E when you need
emutramp (I've seen this but I don't know if it's SOME or ALL cases),
which is normally what causes you to need an executable stack.  An
automated tool could read the ELF header (ldd, readelf) and trace down
all libraries for each program, looking for any with -E.  If it finds
one, it marks the program -E too.  That only leaves a few points of
breakage, particularly things like zsnes which need to mprotect() a huge
hunk of assembly code to make it writable.

> The technique exec-shield uses (to track the per-process 'highest
> executable address') is pretty simple and non-intrusive on the
> implementational level, but it also results in exec-shield's main
> tradeoff:
> 
>    certain VM allocation patterns (e.g. doing mprotect() on an area that
>    was allocated not via PROT_EXEC and was thus mapped high) can reduce
>    exec-shield to 'only protects the stack against execution', or if
>    the application needs an executable stack then reduces exec-shield to
>    'no protection'.
> 

Which brings us to a point on (1) and (2).  You and others continue to
pretend that SEGMEXEC is the only NX emulation in PaX.  I should remind
you (again) that PAGEEXEC uses the same method that Exec Shield uses
since I believe kernel 2.6.6.  In the cases where this method fails, it
falls back to kernel-assisted MMU walking, which can produce potentially
high overhead.

This combination is more suitable for enterprise production environments
which chose the system for the security.  The program will still "work"
with the fallback method.  It will probably be a little slower, and may
be a lot slower.  But, per your own arguments, this situation is
"extremely rare" and it should normally use the highest executable
address method.  Even when this rare case occurs and it falls back to
KAMMUW, it's at least not sacrificing security to do it.

> it turns out these cases where exec-shield gets reduced are quite rare
> and dont happen in critical applications. (partly because we fixed
> affected critical applications - such fixes made sense even when not
> considering the exec-shield impact.)
> 

Applause to you for fixing things.  That's what we need.

> If a 'generic' distribution (i.e. one that has a significant userbase,
> has thousands of packages that do get used) deviates from mainline it
> wants to do it as simply as possible.

"Things may suck and we may have awesome ideas and may be able to add X,
Y, and Z that combined mitigate 60-80% of security problems, but we
don't want to deviate from mainline that much."

I'm one of the type that aims for progress.  My idea of progress is
outlined below.

If it breaks a handfull of things, you set up a temporary work-around
while you fix those.

If it breaks a LOT, you examine why things break.  If it's that they're
coded badly (i.e. every program on initialization mprotect()s everything
PROT_EXEC for no reason whatsoever), you fix it, you smack people for
it, then you go ahead.  If it's that your implementation is retarded,
you find a better way.

If it breaks EVERYTHING, you find another way.  If your implementation
breaks EVERYTHING, yet can be easily adjusted for, and solves a HUGE
chunk of problems without creating more (i.e. solving security while
imposing 99% overhead is wrong), then you may need to take it up with
the community.  If it's examined, there's no other way, and people
realize that this is actually an important step forward, then maybe
they'll bite the bullet and do it.

If you're just an idiot and you broke things for no reason when other
solutions are perfectly fine and work just as well, then screw you.
Somebody else will do it better, and then we'll use it.

THAT is my idea of progress.  We all spend too much time sitting around
whining about how much work it is to do this and that.  Then somebody
does the work, and we all sit around whining that we don't want to spend
the 5 minutes to actually put it in place.  This is not progress, this
is ass.

> (otherwise it would have the
> overhead of porting/testing those deviations all the time.) In fact,
> most of the extra patches that distribution kernels apply are patches
> that they think will go mainline soon. If they apply any patch they know
> wont be merged anytime soon they only do it if it is really needed, and
> even then they try chose the variant that is smaller and easier to
> maintain. Another important aspect is that extra patches should
> obviously _widen_ the utility of the system, not narrow it.

This is contrary and yet not contrary to security.  Remember, all
security implements a policy to allow the targetted restriction of the
system, yet to give the administrator power over that restriction.  For
example, SELinux doesn't make the system capable of doing more stuff; it
makes the administrator capable of making it so you can't run an IRC
server from your home directory.

> 
> On x86, VM space is scarce so PaX's halving of the VM space is a
> 'reduced utility' problem. (yes, you can turn it off per application and
> get processes that have 3GB of address space, but that removes security
> for those processes. Also, you cannot know in advance whether an
> application will use more than 1.5GB of VM - different systems have
> different usage patterns.)

PAGEEXEC

And I've yet to see this 1.5GB split problem.  If you have a specialized
application, you need to mark it.  Generic apps don't do this.

> 
> [ PaX's #2 tradeoff is a maintainance overhead issue. Not an
>   insurmountable issue because it is well-written kernel code, but
>   combined with #1 it can tip the scale. PaX's #3 tradeoff is fixable -
>   it could very well use the PT_GNU_STACK code now upstream. ]
> 

PT_GNU_STACK is actually explicitly disabled -- apparently this is hard
work, as my distribution can't seem to always keep up with it or get it
quite right.

> you seem to be arguing for a 'no prisoners taken' approach to security,
> and that is a perfectly fine approach if you maintain your own variant
> of a distribution.
> 
> the other approach to security (which Fedora follows) is to 'make it as
> seemless and automatic as possible, so that people actually end up using
> our stuff.'
> 

I'd like to point out that I split "users" and "upstream developers,"
although you may have a combined view of the two as "users."  I don't
mind hurting a few peoples' feelings (SUN, BLACKDOWN, IBM -->
http://www.kaffe.org/pipermail/kaffe/2004-October/099938.html) and
causing a *slight* maintenance increase if it means castrating 80% of
anything an atacker can hope to do
(https://www.ubuntulinux.org/wiki/USNAnalysis).

> so while exec-shield is not "complete" in the sense of PaX, in practice
> it is like 99% complete. E.g. on my Fedora desktop box:
> 
>   $ lsexec --all | grep 'execshield enabled' | wc -l
>   86
>   $ lsexec --all | grep 'execshield disabled' | wc -l
>   0
> 
> and that's what really matters at the end of the day. (Anyway, you dont
> have to believe and/or follow any of this, you are free to run your own
> distribution, and if it's good then people will inevitably end up using
> it.)
> 

I intend to, if I can ever figure out how to store BLOB data in an
SQLite database.  I'd like very much to get my own package manager up
and running and start up my own distribution, because I realize that if
I have that, I have a large amount of control over what goes into it.

Although I'm the type that likes to try radical changes and
enhancements, I'm also the type that tries to design robust enough that
these enhancements won't be forced down your throat if they break
things.  I think I'll do pretty good IF I ever get it off the ground :)
 This remains to be seen of course; my ego's not THAT big.

> 	Ingo
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB7/WAhDd4aOud5P8RAlQoAJwIpRd5EW/Uydq+/xlQIHPvbYdipgCfYQ/U
XpBDKmHbUQOP7OTd8Xtl4Tk=
=RXcp
-----END PGP SIGNATURE-----
