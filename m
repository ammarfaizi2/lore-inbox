Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbUCITWE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 14:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbUCITQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 14:16:58 -0500
Received: from zadnik.org ([194.12.244.90]:6292 "EHLO lugburz.zadnik.org")
	by vger.kernel.org with ESMTP id S262119AbUCITMm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 14:12:42 -0500
Date: Tue, 9 Mar 2004 21:12:07 +0200 (EET)
From: Grigor Gatchev <grigor@serdica.org>
X-X-Sender: grigor@lugburz.zadnik.org
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Mike Fedyk <mfedyk@matchmail.com>,
       Christer Weinigel <christer@weinigel.se>,
       <linux-kernel@vger.kernel.org>
Subject: Re: A Layered Kernel: Proposal
In-Reply-To: <20040308173940.GD5263@thunk.org>
Message-ID: <Pine.LNX.4.44.0403091953001.32687-100000@lugburz.zadnik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Mar 2004, Theodore Ts'o wrote:

> On Mon, Mar 08, 2004 at 02:23:43PM +0200, Grigor Gatchev wrote:
> >
> > Also, does "think API changes, nothing generalised *at all*" mean anything
> > different from "think code, no design *at all*"? If this is some practical
> > joke, it is not funny. (I can't believe that a kernel programmer will not
> > know why design is needed, where is its place in the production of a
> > software, and how it should and how it should not be done.)
>
> So give us a design.  Make a concrete proposal.  Tell us what the
> API's --- with C function prototypes --- should look like, and how we
> should migrate what we have to your new beautiful nirvana.

Aside from the beautiful nirvana irony, that is what I am trying not to
do. For the following reason:

When you have to produce a large software, you first design it at a global
level. Then you design the subsystems. After that, their subsystems. And
so on, level after level. At last, you design the code itself. Only then
you write the code actually.

This is opposed to the model where you start with the code. You write a
piece, then you see it's not quite mathing the whole. You design the
group, then rewrite your code, and a dozen of other pieces to match the
design. That's nice, but on the upper level it's still not quite matching.
And so on, to the top. (Actually, a coder with some sense of design would
start as up the chain as he can - but with this design model that is never
very high. And the higher the level, the fewer go to it.)

The Linux kernel is the best example I have ever seen for the second
approach, as a result. It has good code implementation, often excellent.
On lowest level, its design is good. But the higher you go, the more mucky
the design becomes. On the topmost levels, there is only as much design as
absolutely needed by the whole not to fall apart.

This has a reason - the origin and appearance of Linux. This is the way
most fan-initiated and supported systems go. And this cannot be really
changed completely - neither it needs to be. However, a little more design
on the more global levels would be of good use, I think.

The problem is, that the current culture of kernel writing favors the
"code proof". This is also understandable and natural, given the way Linux
has developed. If you can't supply a real code to beat in performance the
current one, you will get enough only of doubters.

However, the more global a conception, the larger is the amount of coding
needed to prove it in code. For example, designing a drivers group would
need only a driver or two written, or even ported, to show its actual
assets. A complete kernel driver model would need at least a dozen of
drivers (re)written, and a lot of other code changes made. A complete
layered model of the kernel, what I dared to offer initially, would
require rewriting of at least 10% of the kernel code - that is over 200
000 lines, AFAIK, to supply a working system to prove anything. This is
very clearly over the abilities of a single programmer (or, at least,
well over mine.)

Well, kernel coders are not idiots. Don't write all the code, you say,
just show me the function prototypes, that's enough. For designing a
group of drivers, that's not that hard. For an entire driver model it may
also be well over a single programmer's abilities. (BTW, what if this
programmer doesn't know C? He is by definition a bad software designer?)

In short: that is why people sometimes talk design without talking code.
Human emotions are essentially brain chemistry, which is essentially
nuclear physics - but no sane person would try to evaluate the emotions
level by asking for examples in nuclear physics level. And any
mathematician that tries to explain Kantorian numbers in apples and pears
would be ridiculed (and must be a genius to succeed at all).

I understand well that, given the kernel history, this may look like a
hand waving for you. I have seen a building worker who sincerely believed
that architects are empty talkers who have never laid a brick over brick,
and dumping all of them would be the best thing to do. However, if you
continue being convinced in that, the kernel will remain underdesigned in
more global levels. I may be a brainless twit, troll, useless C.S.
professor, anything like - but the problem is real. I may go, but unless
properly addressed, the problem will stay.

> Engineering is the task of trading off various different principals;
> in general it is impossible to satisfy all of them 100%.  For example,
> Mach tried to be highly layered, with strict memory protections to
> protect one part of the kernel from another --- all good things, in a
> generic sense.  Streams tried to be extremely layered as well, and had
> a design that a computer science professor would love.  Both turned
> out to be spectacular failures because their performance sucked like
> you wouldn't believe.

I would believe it very well - have tested on my own PC some code from the
STREAMS project. :-) It really was overlayered, and I remember vaguely
something like that they were doing almost the same (resource-expensive)
check in _every_ possible layer to some request I tracked, maybe nearly a
dozen of times. In a sense, STREAMS was exactly the opposite of Linux -
well-designed on global level, but the more concrete the level, the worse
the design. No wonder at all its performance sucked... However, I do
believe that Linux could also have a design that a computer science
professor would love, not at the price of performance.

> Saying "layered programming good" is useless.  Sure, we agree.

Really? I see a lot of disagreement around on this.

> But it's not the only consideration we have to take into account.
> Furthermore, the Linux kernel has a decent amount of layering already,
> although it is a pragmatist's sort of layering, where we use it when
> it is useful and ignore when it gets in the way.  Given your
> high-level descriptions, perhaps the best description of what we
> currently have in Linux is that it uses a C-based (because no one has
> ever bothered to create a C++ obfuscated contest --- it's too easy),
> multiple-inheritance model, where each device driver can use
> common-denominator code as necessary (from the PCI sublayer, the tty
> layer, the SCSI layer, the network layer, etc.), but it is always
> possible for each driver to provide specific overrides as necessary
> for the hardware.
>
> Is my description of Linux's device model accurate?  Sure.  Is it
> useful in terms of telling us what we ought to do in order to improve
> our architecture?  Not really.  It's just a buzzword-compliant,
> high-level description which is great for getting great grades from
> clueless C.S. professors that are more in love with theory than
> practice.  But that's about all it's good for.

You mean that, for example, drawing house elements on paper, and tossing
some numbers here and back is useless in deciding how to build a house,
and only getting hands to the real bricks gives you whether this wall
should be here, and whether that column is thick enough to survive through
a quake?

Thanks, Ted. I think I am getting it, finally.

Unhappily, what I am getting is the clear idea that you are a team of
geniuses. Or that I am a hopeless idiot, or maybe both. In any way, I
am nowhere near you, and only waste your time now.

Sorry.

> In order for it to be at all useful, it has to go to the next level.
> So if you would like to tell us how we can do a better job, please
> submit a proposal.  But it will have to be a detailed one, not one
> that is filled with high-level buzzwords and hand-waving.
>
> 					- Ted


