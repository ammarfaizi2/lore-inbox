Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288867AbSA2GuN>; Tue, 29 Jan 2002 01:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288862AbSA2GuE>; Tue, 29 Jan 2002 01:50:04 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11788 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288859AbSA2Gtw>; Tue, 29 Jan 2002 01:49:52 -0500
Date: Mon, 28 Jan 2002 22:49:04 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Larry McVoy <lm@bitmover.com>
cc: Rob Landley <landley@trommello.org>, <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <20020128221249.A5583@work.bitmover.com>
Message-ID: <Pine.LNX.4.33.0201282217220.10929-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 28 Jan 2002, Larry McVoy wrote:
>
> What you didn't do, Linus, is paint a picture which allows development
> to scale up.

Actually, I thought I did.

Basic premise: development is done by humans.

Now, look at how humans work. I don't know _anybody_ who works with
hundreds of people. You work with 5-10 people, out of a pool of maybe
30-50 people. Agreed?

Now, look at the suggested "patch penguin", and realize that the
suggestion doesn't add any scaling at all: it only adds a simple layer
that has all the same scaling problems.

What I'm saying is

 - I'm never going to work with hundreds of people directly, because it is
   fundamentally against my nature, by virtue of being human.

 - adding a "patch penguin" doesn't help, because _he_ (or she, although I
   didn't see any women nominated) is also going to be human. So either
   the patch penguin is going to do a bad job (and I won't start trusting
   him/her), or the patch penguin is going to have all the same issues
   people complain about.

Those are obvious truths. If you don't see them as being obvious truths,
you just haven't been thinking things through.

Did Alan do a good job? Yes. He did a _great_ job. But let's face it: (a)
he got really tired of doing it and (b) it really works only with one or
two Alan's, not with more - because with more you get people complaining
about the -aa tree vs the -dj tree vs the -marcelo tree vs the -linus
tree.

So Alan doesn't scale up either - I doubt you'll find a "better Alan", and
I _seriously_ doubt you'll be able to have multiple Alan's.

Does anybody really doubt this?

Now, if you've read this far, and you agree with these issues, I suspect
you know the solution as well as I do. It's the setup I already mentioned:
a network of maintainers, each of whom knows other maintainers.

And there's overlap. I'm not talking about a hierarchy here: it's not the
"general at the top" kind of tree-like setup. The network driver people
are in the same general vicinity as the people doing network protocols,
and there is obviously a lot of overlap.

Are there problems with maintainership? Yes. The main one being that it's
too damn easy to step on any toes. Which is why you want the modularity,
ie you do NOT want to have files issues that slash across different
maintenance boundaries (unless they have clearly defined interfaces:
that's where the importance of a clear VFS interface design comes in etc)

For an example of this, look at init/main.c in 2.2.x, in 2.4.x, and in
2.5.x. BIG changes. And most of the changes have very little to do with
what that file actually does (relatively little), and _everything_ to do
with the fact that it is the file that "instantiates" almost everything
and thus crosses all boundaries.

And notice how the "initcall" etc setup has changed, and cut a lot of
those dependencies. That's very much by design: look at what a device
driver had to do (and know) to be either a compiled-in driver or a modular
driver a few years ago. And look at a driver today.

In short, I'm saying that the true path to scalability is:

 - lack of dependencies on a source level

   This implies good interfaces that do NOT have common source files for
   different projects. In particular, it implies dynamic add/remove
   without the rest of the system having to know at all.

 - lack of people (whether patch-penguins or me) who have to follow
   everything.

   This, in turn, implies two things:

   (a) it is not the maintainers who pull things into their trees (because
       they aren't always there, and they don't know everything). It is
       the developers who _push_ onto maintainers.

   (b) if you as a developer cannot find a maintainer who you know, it is
       YOUR problem, and you cannot blame some super-penguin in the blue
       yonder for not caring about you. You may have to maintain your
       patch-set yourself. Or you should find a maintainer who cares about
       the work you do, and who helps feed it forward.

I know, I know. It's easier to whine about other people than it is to take
responsibility for your own actions. It's so easy to complain about "Linus
doesn't apply my patches", and so hard to just face the fact that Linus
never _will_ care about all patches, and that if you cannot find anybody
else to care about them either, then maybe they should die or you should
take care and feed them yourself.

I'm a bastard. I'm spending a lot of time applying patches, but it's not
my whole life. Never has been, never will be. I'll always be better at
applying patches from those ten people that I know and I trust than I'll
be at applying patches from people I don't trust.

If you're a developer, and you can't get through to me, ask yourself if
you can get through to somebody else.

And if you can't get through to anybody else either, ask yourself whether
maybe the problem is at _your_ end.

			Linus

