Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288677AbSA2ErE>; Mon, 28 Jan 2002 23:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288736AbSA2Eqz>; Mon, 28 Jan 2002 23:46:55 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:38538
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288677AbSA2Eqf>; Mon, 28 Jan 2002 23:46:35 -0500
Message-Id: <200201290446.g0T4kZU31923@snark.thyrsus.com>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
Date: Mon, 28 Jan 2002 23:47:31 -0500
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <200201282213.g0SMDcU25653@snark.thyrsus.com> <200201290137.g0T1bwB24120@karis.localdomain> <a354iv$ai9$1@penguin.transmeta.com>
In-Reply-To: <a354iv$ai9$1@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 January 2002 10:23 pm, Linus Torvalds wrote:
> In article <200201290137.g0T1bwB24120@karis.localdomain>,
>
> Francesco Munda  <syylk@libero.it> wrote:
> >I deeply agree with you, especially in keeping "many eyes" to look at the
> >same kernel tree, and not chosing one of the many subtrees; as added
> > bonus, this stuff is buzzword compliant! What we can ask more? :)
>
> Some thinking, for one thing.
>
> One "patch penguin" scales no better than I do. In fact, I will claim
> that most of them scale a whole lot worse.

Sure.  But Alan doesn't, and Dave Jones (with enough experience) shouldn't.

You have architecture duties.  You're worried about the future of the code.  
You have to understand just about everybody's subsystem, so you can veto a 
patch from somebody like Jens Axboe or Andre Hedrick if you have an objection 
to it.

An integration maintainer would NOT be making any major architectural 
decisions, they would be integrating the code from the maintainers, 
collecting the patches for the unmaintained areas of code, and resolving 
issues between maintainers that are purely implementation details.

Then you code review what they do anyway as the architect, saying whether or 
not it's a good idea.  But you don't have to deal with the obvious grunt work 
that's largely a matter of figuring out which bits don't compile because 
person A was not talking to person B.

> The fact is, we've had "patch penguins" pretty much forever, and they
> are called subsystem maintainers.  They maintain their own subsystem, ie
> people like David Miller (networking), Kai Germaschewski (ISDN), Greg KH
> (USB), Ben Collins (firewire), Al Viro (VFS), Andrew Morton (ext3), Ingo
> Molnar (scheduler), Jeff Garzik (network drivers) etc etc.

I'm suggesting an integration maintainer, whose explicit job is to put 
together patches from the various subsystem maintainers, and only directly 
accept patches for areas of code that do not HAVE any other subsystem 
maintainer.

Alan Cox used to do this (and is starting to do it again for Marcelo in 2.4). 
 Dave Jones is currently the guy doing this for you, taking patches, sorting 
through them, and then feeding them on to you.

> If there are problems with certain patches, it tends to be due to one or
> more of:
>
>  - the subsystem is badly modularized (quite common, originally. I don't
>    think many people realize how _far_ Linux has come in the last five
>    years wrt issues like architectures, driver independence, filesystem
>    infrastructure etc). And it still happens.

Yup.  Architecture issue.  Still your problem, I'm fraid.

>  - lack of maintainer interest. Many "maintainers" are less interested
>    in true merging than in trying to just push whatever code they have,
>    and only ever grow their patches instead of keeping them in pieces.

Patch penguin's job.  Foist this grunt work off on him.

>    This is usually a matter of getting used to it, and the best people
>    get used to it really quickly (Andrea, for example, used to not do
>    this well at all, but look at how he does it now! From a merge
>    standpoint, his patches have gone from "horrible" to "very good")

And needed patches from people who aren't very good have to wait years for 
the developer to learn how to feed you the right kind of patches?

If the patch is for a specific subsystem, then obviously your first line of 
defense fighting off sturgeon's law is the subsystem maintainer.  But you 
don't seem to have been taking patches even from subsystem maintainers in a 
timely manner, and how can people tell the difference between you dropping a 
patch because you have an objection to it and you dropping a patch because 
your mailbox overfloweth?  (You keep complaining people never send you 
patches.  People are suggesting automated patch remailers to spam your 
mailbox even harder.  There has GOT to be a better way...)

>  - personality/communication issues. Yes, they happen. I've tried to
>    have other people be "filters" for the people I cannot work with, but
>    I have to say that most of the time when I can't work with somebody,
>    others have real problems with those people too.
>
>    (An example of a very successful situation: David Miller and Alexey
>    Kuznetsov: Alexey used to have these rather uncontrolled patches that
>    I couldn't judge or work with but that obviously had a lot of
>    potential, and David acting as a filter made them a very successful
>    team.)
>
> In short, if you have areas or patches that you feel have had problems,
> ask yourself _why_ those areas have problems.

Query: Do you not believe you have been dropping a significant number of good 
patches on the floor?

> A word of warning: good maintainers are hard to find.  Getting more of
> them helps, but at some point it can actually be more useful to help the
> _existing_ ones.  I've got about ten-twenty people I really trust, and
> quite frankly, the way people work is hardcoded in our DNA.  Nobody
> "really trusts" hundreds of people.  The way to make these things scale
> out more is to increase the network of trust not by trying to push it on
> me, but by making it more of a _network_, not a star-topology around me.

You don't see an integration maintainer as a step in the right direction?  
(It's not a star topology, it's a tree.)

Having lots of dispirate overlapping trees fragments development, fragments 
the testers, and makes an awful lot more WORK for everybody involved.

> In short: don't try to come up with a "patch penguin".  Instead try to
> help existing maintainers, or maybe help grow new ones. THAT is the way
> to scalability.

Are you saying that Alan Cox's didn't serve a purpose during the 2.2 kernel 
time frame, and that Dave Jones is currently wasting his time? 

I'm confused here: "don't try to come up with a patch penguin", "help 
existing maintainers" (that's the patch penguin's job) "help grow new 
[maintainers]"...  The patch penguin IS an integration maintainer.  That's 
what I'm talking about.  (Patch penguin, patch pumpkin.  Patch pumkin, patch 
penguin.  I can say "integration maintainer" if it would help...)

I missed a curve somewhere.  Maybe the original message wasn't clear?  I am 
suggesting making Dave Jones the integration maintainer (a position he 
currently unofficially holds, and which Alan Cox did before him), and simply 
telling everybody who's complaining that their patches are getting silently 
dropped or ignored to try getting them into HIS tree first before bothering 
you about it.

I'm not asking for a major change here, I'm talking about clarifying the 
current ad-hoc development process.  Formalizing an existing de facto 
position so people farther out in the development process know what to do and 
where to go.

> 		Linus

Rob
