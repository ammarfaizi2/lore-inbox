Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319105AbSIDI5j>; Wed, 4 Sep 2002 04:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319106AbSIDI5j>; Wed, 4 Sep 2002 04:57:39 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:40708 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S319105AbSIDI5i>;
	Wed, 4 Sep 2002 04:57:38 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200209040902.g84927L29020@oboe.it.uc3m.es>
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
In-Reply-To: <Pine.GSO.4.21.0209040258480.7852-100000@weyl.math.psu.edu> from
 Alexander Viro at "Sep 4, 2002 03:06:53 am"
To: Alexander Viro <viro@math.psu.edu>
Date: Wed, 4 Sep 2002 11:02:07 +0200 (MET DST)
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>, Xavier Bestel <xavier.bestel@free.fr>,
       Anton Altaparmakov <aia21@cantab.net>, david.lang@digitalinsight.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Alexander Viro wrote:"
> On Wed, 4 Sep 2002, Peter T. Breuer wrote:
> > I'm proposing (elsewhere) that I be allowed to generate special block-layer
> > requests from VFS, which act as "tags" to impose order on other requests
> > at the shared disk resource. But ...
> 
> Get.  Real.

Ok.

> VFS has no sodding idea of notion of blocks, let alone ordering needed for
> a particular filesystem.

True, and so what? Do you have any other irrelevancies on your mind?
Speak now ... 

(it's US who can use VFS to implement atomicity wrt VFS operations,
 by allowing a special block request to be sent at the start of 
 each VFS operation and another at the end, and allowing those special
 requests to be interpreted on the resource as "give me the lock now" and
 "release the lock now" respectively - maintaining ordering will do the
 rest. We just want to avoid interleaving during this sequence)

> As soon as you are starting to talk about "superblocks" (on-disk ones, that
> is) - you can forget about generic layers.

Fine. Let's not speak then.

> As far as I'm concerned, the feature in question is fairly pointless for

Well, "as far as I'm concerned", would you mind producing technical
options instead of (opinionated nonrational emotional idiotic
nonsensical) _judgments_?  Options can be evaluated.  Judgments cannot.

Or are you just going to go on an insult binge and bring up your hamburger?

> the things it can be used for and hopeless for the things you want to
> get.  Ergo, it's vetoed.

Ergo WHAT'S vetoed? Your big toe?

> There is more to coherency and preserving fs structure than "don't cache

Sure. So what?  What's wrong with a O_DIRDIRECT flag that makes all
opens retrace the path from the root fs _on disk_ instead of from the 
directory cache? 

I suggest that changing FS structure is an operation that is so
relatively rare  in the projected environment (in which gigabytes of
/data/ are streaming through every second) that you can make them as
expensive as you like and nobody will notice. Your frothing at the
mouth about it isn't going to change that. Moreover, _opening_
a file is a rare operation too, relative to all that data thruput.

So go ahead, worry about it.

> <something>".  And issues involved here clearly belong to filesystem -
> generic code simply has not enough information _and_ the nature of the
> solution deeply depends on fs in question.  IOW, your grand idea is
> hopeless.  End of discussion.

Anyone ever tell you that you have an insight problem?  You are
evaluating the sistuation using the wrong objective functions as a
metric. Don't use your metric, use the one appropriate to the
situation. Nobody could care less how long it takes to open a file
or do a mkdir, and even if they did care it would take exactly as long
as it does on my 486 right now, which doesn't scare the pants off me.

What we/I want is a simple way to put whatever FS we want on a shared
remote resource. It doesn't matter if you think it's going to be slow
in some aspects, it'll be fast enough, because those aspects merely
have to be correct, not fast.


Peter
