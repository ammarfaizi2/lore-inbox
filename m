Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282499AbRKZUtC>; Mon, 26 Nov 2001 15:49:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282503AbRKZUrv>; Mon, 26 Nov 2001 15:47:51 -0500
Received: from femail21.sdc1.sfba.home.com ([24.0.95.146]:60895 "EHLO
	femail21.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S282490AbRKZUq0>; Mon, 26 Nov 2001 15:46:26 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
Organization: Boundaries Unlimited
To: Linus Torvalds <torvalds@transmeta.com>, Mike Fedyk <mfedyk@matchmail.com>
Subject: Re: [RFC] 2.5/2.6/2.7 transition [was Re: Linux 2.4.16-pre1]
Date: Mon, 26 Nov 2001 12:44:58 -0500
X-Mailer: KMail [version 1.2]
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
        Dominik Kubla <kubla@sciobyte.de>, <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0111251946400.9764-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0111251946400.9764-100000@penguin.transmeta.com>
MIME-Version: 1.0
Message-Id: <0111261244580G.02001@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 25 November 2001 22:58, Linus Torvalds wrote:

> > 1) Develop 2.5 until it is ready to be 2.6 and immediately give it over
> > to a maintainer, and start 2.7.
>
> I'd love to do that, but it doesn't really work very well. Simply because
> whenever the "stable" fork happens, there are going to be issues that the
> bleeding-edge guard didn't notice, or didn't realize how they bite people
> in the real world.
>
> So I could throw a 2.6 directly over the fence, and start a 2.7 series,
> but that would have two really killer problems
>
>  (a) I really don't like giving something bad to whoever gets to be
>      maintainer of the stable kernel. It just doesn't work that way:
>      whoever would be willing to maintain such a stable kernel would be a
>      real sucker and a glutton for punishment.
>
>  (b) Even if I found a glutton for punishment that was intelligent enough
>      in other ways to be a good maintainer, the _development_ tree too
>      needs to start off from a "known reasonably good" point. It doesn't
>      have to be perfect, but it needs to be _known_.

Think in terms of the concept of "patch pressure".  Lots of patches out 
there, trying to get into the tree.  They WILL have an effect on development.

Way back when, Linux got off the ground so fast in large part because it 
grounded out Minix's patch pressure.  Andrew Tanenbaum wouldn't integrate 
patches into his codebase, so the pressure built up and up until it found 
some place to leak out: your term program.  (The GNU project had a similar 
problem because RMS insists copyrights be signed over to him on paper, and 
that creates a lot of friction which makes integration hardware and increases 
patch pressure.  Linux was an outlet for the frustrations of the developers 
of TWO unix clone development projects.  And even a couple of people fed up 
with Bill Jolitz' inertia on BSD...)

A "stable" series with no development branch seems to work well for about 
three months.  All the developers are focused on bug fixing and stabilization 
due to lack of options.  But beyond that, the "herding cats" aspect of 
development builds up, developers get bored, they've implemented new ideas 
anyway which aren't being integrated and are taking up more and more of their 
attention, private trees diverge...

Patch pressure.

I submit that if the stable tree hasn't calmed down after three or four 
months, opening a development branch may in fact HELP the situation, and 
stabilize things faster.  You need to vent the patch pressure.

If you don't, you'll get megabytes of diffs in Alan Cox's tree that aren't in 
yours, you'll get the Functionally Overloaded Linux Kernel (a clear symptom: 
a kernel aimed at solely at doing the cleanup work integrating outside 
patches into a single tree, whether they work or not...), you'll get more 
trees like Andrea Arcangelli's becoming widely used...  The end result is not 
focusing development effort, it's scattering it more.  Refusing to integrate 
patches won't prevent them from being created, maintained, applied by system 
vendors...  It just means developers have to maintain more version state in 
their heads.

Trying to confine people's attention to a single tree only works until the 
patch pressure builds up to a certain point.  Beyond that, it can't be 
contained and if you don't give it an outlet it'll find one.  The end result 
will be MORE scattered, MORE chaotic, and less useful.  On the other hand, 
the presense of a development tree doesn't stop the "stable" tree from being 
interesting.  Bugs found in 2.2 are still fixed.  2.4 is still compared with 
2.2 when things go strange.  And code from the development fork is backported 
to the last stable version all the time.

Point for consideration: for a while (just before the ric->andrea VM switch, 
say 2.4.9), alan's tree was closer to stabilizing the VM than yours.  Alan 
had also integrated WAY more stuff than you had.  People were ALREADY dealing 
with two trees (Alan's and yours) which had fairly widely diverged.  How 
would having an active development branch with different development and 
stable maintainers have been worse than what DID happen?

> For good of for bad, we actually have that now with 2.4.x - the system
> does look fairly stable, with just some silly problems that have known
> solutions and aren't a major pain to handle. So the 2.5.x release is off
> to a good start, which it simply wouldn't have had if I had just cut over
> from 2.4.0.

How is backporting stable code from 2.5->2.4 much different than forward 
porting bug fixes and stabilizations from 2.4->2.5?  As long as everybody 
understands what got fixed and why...

> The _real_ solution is to make fewer fundamental changes between stable
> kernels, and that's a real solution that I expect to become more and more
> realistic as the kernel stabilizes. I already expect 2.5 to have a _lot_
> less fundamental changes than the 2.3.x tree ever had - the SMP
> scaliability efforts and page-cachification between 2.2.x and 2.4.x is
> really quite a big change.

That's the old argument for a faster release cycle again.  It's still easier 
said than done.  In theory, if 2.5 had opened with the new andrea VM (instead 
of 2.4.10), had proven itself superior in 3 months, it could have been closed 
stabilizied and called 2.6 after 6 months.  In the real world, that won't 
happen, but the forces making that NOT happen still apply to the current 
situation.

This is another chicken and egg problem.  A temporary pause in development 
(for stabilization) can indeed drop patch pressure by getting developers to 
cross their legs and hold it.  But only if developers believe it really is 
temporary.  Your development process has kind of FUDded itself on that front, 
historically speaking...

If you don't let development and stabilization overlap, then pressure to 
integrate new patches will never stop (something Alan is historically better 
at saying no to than you are).  The longer they're blocked, the greater they 
get.  At some point, giving them a known outlet makes more sense to me than 
trying to put one more finger in the dike.  Your mileage probably does vary...

> But you also have to realize that "fewer fundamental changes" is a mark of
> a system that isn't evolving as quickly, and that is reaching middle age.
> We are probably not quite there yet ;)

Slower development is not necessarily better development.  If we wanted slow 
and careful changes that were fully documented we'd be using the IBM software 
development procedure manual from the 1980's.  That simply doesn't work.

Getting developers to hold back with no development branch outlet (other than 
FOLK, Alan's tree, or private CVS) didn't stop this stabilization cycle from 
taking almost a full year.  I'm not sure tightening the restrictions in this 
area will actually improve matters...

> 		Linus

Rob
