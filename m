Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265638AbSKAGVy>; Fri, 1 Nov 2002 01:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265640AbSKAGVy>; Fri, 1 Nov 2002 01:21:54 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:48913 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265638AbSKAGVw>; Fri, 1 Nov 2002 01:21:52 -0500
Date: Fri, 1 Nov 2002 01:27:20 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: What's left over.
In-Reply-To: <Pine.LNX.4.44.0210310918260.1410-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.3.96.1021101000448.23822B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Linus Torvalds wrote:

> 
> On Wed, 30 Oct 2002, Matt D. Robinson wrote:
> 
> > Linus Torvalds wrote:
> > > > Crash Dumping (LKCD)
> > > 
> > > This is definitely a vendor-driven thing. I don't believe it has any
> > > relevance unless vendors actively support it.
> > 
> > There are people within IBM in Germany, India and England, as well as
> > a number of companies (Intel, NEC, Hitachi, Fujitsu), as well as SGI
> > that are PAID to support this.
> 
> That's fine. And since they are paid to support it, they can apply the 
> patches.  
> 
> What I'm saying by "vendor driven" is that it has no relevance for the 
> standard kernel, and since it has no relevance to that, then I have no 
> incentives to merge it. The crash dump is only useful with people who 
> actively look at the dumps, and I don't know _anybody_ outside of the 
> specialized vendors you mention who actually do that.

  You're not listening! Screw the vendors! The users want this enough to
be patching it into their kernels now.

> 
> I will merge it when there are real users who want it - usually as a
> result of having gotten used to it through a vendor who supports it. (And
> by "support" I do not mean "maintain the patches", but "actively uses it"
> to work out the users problems or whatever).

  Did you not read the input from the developers? From the people who have
headless clusters?

  I have Linux systems in fifteen locations, six states, for timezones.
They oops from time to time, and I can't get any clue why, because (a)
they have no console, (b) most are in secure locations like locked wiring
closets with no one to read a console, and (c) the systems are thousands
of miles away. I don't need a debugger, I'd love to just have ksysoops
output! And given the reality of using the network, I don't make kcore
world readable, I'm not about to send that information over a few
thousand miles of open net to save writing it to disk.

  I also have Solaris and AIX servers, and if they go down I send a crash
dump to the vendor who can then provide support. Big difference. Visible
even to management, who see a real support issue.

> 
> Horse before the cart and all that thing.
> 
> People have to realize that my kernel is not for random new features.

  Supportablility is not a "random new feature," it's something which was
developed because users had a need (not by a vendor looking for a feature
to advertize), and if you would read the mail it's mostly coming from
people who want to use the feature. This is a whole new kernel series, it
will be stable a hell of a lot sooner if people can find problems!

  Notice that developers want it, vendors want to provide it, and end
users want to be able to get support. In fact, other than one person who
had doubts about the implementation being optimal, your voice is the only
one I hear against it. That should tell you something.

  Sometimes the best way to lead is to look at where everyone is going on
their own, jump in front, and yell "Follow me!" a few times. If you put
half the energy into improving the implementation that you put into
telling us we're all wrong it would be a better kernel.



On Thu, 31 Oct 2002, Linus Torvalds wrote:

> 
> [ Ok, this is a really serious email. If you don't get it, don't bother 
>   emailing me. Instead, think about it for an hour, and if you still don't 
>   get it, ask somebody you know to explain it to you. ]
> 
> On Thu, 31 Oct 2002, Matt D. Robinson wrote:
> > 
> > Sure, but why should they have to?  What technical reason is there
> > for not including it, Linus?
> 
> There are many:
> 
>  - bloat kills:
> 
> 	My job is saying "NO!"
> 
> 	In other words: the question is never EVER "Why shouldn't it be
> 	accepted?", but it is always "Why do we really not want to live 
> 	without this?"

  I suspect that you have not had to make any significant part of your
living administering systems, certainly not recently. Lack of this tool is
a one-to-one mapping to "no clue" if you can't get information from the
console.
 
>  - included features kill off (potentially better) projects.
> 
> 	There's a big "inertia" to features. It's often better to keep 
> 	features _off_ the standard kernel if they may end up being
> 	further developed in totally new directions.

  Yes, you can clearly see how that worked with ext2 stifling development
of... wait a minute, rethink that argument. This feature is years old, and
seems to be ready to add new destinations for the data, disk, net, high
memory, what elese is there? Once the data is saved people will be able to
develop any additional tools they want to read the raw data.
 
> 	In particular when it comes to this project, I'm told about
> 	"netdump", which doesn't try to dump to a disk, but over the net.
> 	And quite frankly, my immediate reaction is to say "Hell, I
> 	_never_ want the dump touching my disk, but over the network
> 	sounds like a great idea".

  You have this idea that the dump will go over a high reliability path,
and that's an option, but not in all cases true.

> To me this says "LKCD is stupid". Which means that I'm not going to apply 
> it, and I'm going to need some real reason to do so - ie being proven 
> wrong in the field.

  You've been proven wrong, you just don't want to look at the proof! You
can't say it doesn't work, it does. You can't say the (users, vendors,
developers} don't want it, because they do. You can't say it's untested,
it's been in use for several years, and you seem willing to take reiser4,
which isn't even finsished yet!

> (And don't get me wrong - I don't mind getting proven wrong. I change my 
> opinions the way some people change underwear. And I think that's ok).

  If you really believed the stuff you say you'd put it in and promise to
take it out if people didn't find it useful or there were inherent
limitations. It would probably take 10-30% off the time to a stable
release.
 
> > I completely don't understand your reasoning here.
> 
> Tough. That's YOUR problem.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

