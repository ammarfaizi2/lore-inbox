Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314040AbSDQDhY>; Tue, 16 Apr 2002 23:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314041AbSDQDhY>; Tue, 16 Apr 2002 23:37:24 -0400
Received: from bitmover.com ([192.132.92.2]:39616 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S314040AbSDQDhX>;
	Tue, 16 Apr 2002 23:37:23 -0400
Date: Tue, 16 Apr 2002 20:37:21 -0700
From: Larry McVoy <lm@bitmover.com>
To: "M. R. Brown" <mrbrown@0xd6.org>
Cc: James Simmons <jsimmons@transvirtual.com>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Fbdev Bitkeeper repository
Message-ID: <20020416203721.B27525@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"M. R. Brown" <mrbrown@0xd6.org>,
	James Simmons <jsimmons@transvirtual.com>,
	Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux console project <linuxconsole-dev@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.10.10204161542470.29030-100000@www.transvirtual.com> <20020416225752.GA5897@0xd6.org> <20020416160121.B24069@work.bitmover.com> <20020417000818.GB5897@0xd6.org> <20020416181034.C24069@work.bitmover.com> <20020417024149.GC5897@0xd6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 09:41:49PM -0500, M. R. Brown wrote:
> * Larry McVoy <lm@bitmover.com> on Tue, Apr 16, 2002:
> > Ahh, OK, we're already working on this.  We call 'em nested repositories
> 
> That's good to hear, and interesting as well.  Any particular reason why
> this wasn't implemented until now?  Did you not see a high demand for
> satellite projects, or was it just assumed that you'd only ever need the
> clone method of development?

BK supports gzipped repositories and hard linked repositories, so a
compressed tree takes about 87MB (when the checked out tree is 169MB),
and a hard linked tree takes effectively no space at all.  So making
subsets had very little benefit and removed a significant advantage:
with BK when you say "as of such and such a changeset", there is no
ambiguity as to what you mean, it implies the whole tree.  There is no
chance of doing that with a subset tree.  Small gain in disk space,
big loss in reproduceablilty.  Seems like a bad tradeoff.

> This requires consistency on the part of the drop-in tree maintainer, to
> sync to and from the mainline kernel.  Usually, only the maintainer sends
> patches upstream, but experienced project developers can easily merge
> changes coming from the mainline kernel.  I'm not aware of how BK may
> automate this or make it easier, but this is one of those "use rigid
> guidelines where CVS falls short" situations.  *Shrug*, a bit of extra
> work, but still easier than tracking an entire tree's worth of changes.

That's not a widely shared opinion.  Check with the people maintaining 
their own trees, tracking the mainline and/or some branch.  Saying
"CVS falls short" is quite the understatement.  Try doing the same 
thing with CVS (or whatever else) and you'll see what I mean.  CVS
is great for simple things; the kernel isn't simple.

There is a basic flaw in your reasoning.  You're assuming that you
can do all your work in isolation.  That's not true, the rest of the
tree is changing around you and you need to build/test against that.
Not doing so is just cutting corners and while I'm sure you are smart
enough not to get burned too often by this, I'm equally sure you have
and will get burned by it again.  Noone is immune.  And all of this is
to save some disk space?  Disk drives are about $1/GB on pricewatch.
A kernel tree, compressed, takes less than .1GB.  So you saved yourself
10 whole cents.  Wheeeeeee!

Suppose you are a paid developer.  Around here, a kernel hack gets about
$100K/year, and actually costs a company about $180K/year.  OK, let's say
you live someplace really cheap so it is 1/4th that.  So that's $22.5
an hour.  Or 37.5 cents a minute.  So if you waste 20 seconds because
you saved yourself 100MB of space, you blew it.  It doesn't make sense.

> I meant as far as styles of development.  Yes, CVS can cause some headaches
> if used improperly, and some shortcomings are either excused or hacked
> over.  However for small projects or projects with a group of close-knit
> developers BK is considerably more complex to setup and use.  A lot of the
> "problems" that BK solves are either not required for smaller projects or
> are second nature to those experienced in using CVS.
> 
> Yes, I see the immediate benefits of being able to clone a repository and
> do local development, pulling in updates or pushing changes mainstream
> where appropiate.  Fortunately, I have Arch to study for this, which I have
> to say I'm much more comfortable working with.  Yes, I've used BK in the
> past (for the PPC tree), but it's been about 2 years so maybe it's improved
> since then?

So you are looking at a 2 year old view of a a tool which has existed
for 4 years.  Yes, of course it has improved, it has improved a lot.
How about you go use it and then make your comments?  Come on, get a clue.
Judging anything which is moving that fast by a 2 year old snapshot is
obviously wrong.

A sane person might conclude you have some other agenda.

> Right, but CVS-like operations in BK currently won't allow me to do drop-in
> trees.  It's not so much a complexity of use issue as it's an issue of how
> things are implemented or done in CVS vs. BK.  Because of its simplistic
> view of repositories and how to work with them, CVS wins with small, finely
> cultivated (excuse the lack of a better term) trees, whereas BK's complex
> view of repositories does not.

Nonsense.  You can do drops right now.  Just split the tree apart and
clone the parts you need.  All the nested repos are going to do is 
give you some syntatic sugar which allows you to do just that.

Note that I'm not suggesting that you personally do that, it's becoming
apparent to me that you either have an ax to grind or you are just plain
lazy, and either way I'd love for you to keep using CVS, that would be
great.  

At the same time, it would also be great if you left off describing tools
you don't use.  I don't know what part of the kernel you work on, but
I can assure you that I won't go complaining about it unless I actually
use it and think about it first.

> One of the listed BK features is being able to collaborate with other folks
> who've cloned a repository - are the backend/subsystem maintainers even
> doing this?  Is there any collaboration going on between say, the Linux/ARM
> and USB BK repositories?  

There is certainly some of that, look at the histories to see the merges.
I think Linus does most of those but I see merges originated by others
in their private trees all the time, look at the openlogging tree.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
