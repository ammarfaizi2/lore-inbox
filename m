Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263760AbTDXPls (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 11:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263764AbTDXPls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 11:41:48 -0400
Received: from mail.eskimo.com ([204.122.16.4]:16649 "EHLO mail.eskimo.com")
	by vger.kernel.org with ESMTP id S263760AbTDXPln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 11:41:43 -0400
Date: Thu, 24 Apr 2003 08:53:34 -0700
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flame Linus to a crisp!
Message-ID: <20030424155334.GA32603@eskimo.com>
References: <Pine.LNX.4.44.0304232012400.19176-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304232012400.19176-100000@home.transmeta.com>
User-Agent: Mutt/1.5.4i
From: Elladan <elladan@eskimo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So, there are two basic camps in the whole DRM arena:

1. People who want to somehow make files that only computers they trust
   can play.

2. People who want to make computers that can refuse to run programs
   that aren't approved (eg. by the administrator).

The DRM scheme you've mentioned (embedding public keys in the kernel,
plus hardware support etc.) seem compatible with the second group.
However, it fundamentally has some problems with the first group.

The way people doing the first group operate is to try to hide secret
keys in their software using some trivial obfuscation method.  Their
software then tries to authenticate that the rest of the system is
somehow friendly, and the user has permission to play the file.  If the
software decides everything is good, it then assents to decrypt the file
using the secret keys it has hidden inside it.

This is, of course, technically a joke since breaking the DRM is always
simply a matter of disassembling their code to find where they hid the
key.  It's not like a system where everyone in the world has a copy of
the secret key on their desk can actually be secure.  But anyway...

In practice, what these sorts of DRM people are going to want to do with
a Linux kernel is build some sort of secret, obfuscated binary-only
kernel module which somehow tries to make sure the system is happy and
friendly, and then signal to the application that all is well.


So, here's a question for you:

This clearly looks like it would be legal for the end-user to do, since
the end user can use GPL code for any purpose.

What about a device manufacturer, though?  To keep the key secret, any
DRM scheme of this sort of pretty-much guaranteed to involve some sort
of binary-only kernel module, possibly shipped in ROM next to the
kernel.  Can a company actually ship a device of this sort which uses
such a binary-only module, and be compatible with the GPL?

It seems it could be argued both ways - since the binary module is
clearly meant to be linked into the kernel, it could be considered a
derivative work if they're packaged together.  This isn't quite the same
as an end-user deciding to load some module that happens to be sitting
around.

Alternatively, since the kernel includes a facility to load arbitrary
code into its core image at run-time, it could be argued that the binary
module is still not a derivative work, just some unrelated code which a
proprietary application chooses to insert into the kernel while it's
running, using standard kernel system calls. 

Which interpretation is correct?  I'd suspect the latter, otherwise
linux distributions may already be in trouble...

-J


On Wed, Apr 23, 2003 at 08:59:45PM -0700, Linus Torvalds wrote:
> 
> Ok, 
>  there's no way to do this gracefully, so I won't even try. I'm going to 
> just hunker down for some really impressive extended flaming, and my 
> asbestos underwear is firmly in place, and extremely uncomfortable.
> 
>   I want to make it clear that DRM is perfectly ok with Linux!
> 
> There, I've said it. I'm out of the closet. So bring it on...
> 
> I've had some private discussions with various people about this already,
> and I do realize that a lot of people want to use the kernel in some way
> to just make DRM go away, at least as far as Linux is concerned. Either by
> some policy decision or by extending the GPL to just not allow it.
> 
> In some ways the discussion was very similar to some of the software
> patent related GPL-NG discussions from a year or so ago: "we don't like
> it, and we should change the license to make it not work somehow". 
> 
> And like the software patent issue, I also don't necessarily like DRM
> myself, but I still ended up feeling the same: I'm an "Oppenheimer", and I
> refuse to play politics with Linux, and I think you can use Linux for
> whatever you want to - which very much includes things I don't necessarily
> personally approve of.
> 
> The GPL requires you to give out sources to the kernel, but it doesn't
> limit what you can _do_ with the kernel. On the whole, this is just
> another example of why rms calls me "just an engineer" and thinks I have
> no ideals.
> 
> [ Personally, I see it as a virtue - trying to make the world a slightly
>   better place _without_ trying to impose your moral values on other 
>   people. You do whatever the h*ll rings your bell, I'm just an engineer 
>   who wants to make the best OS possible. ]
> 
> In short, it's perfectly ok to sign a kernel image - I do it myself
> indirectly every day through the kernel.org, as kernel.org will sign the
> tar-balls I upload to make sure people can at least verify that they came
> that way. Doing the same thing on the binary is no different: signing a
> binary is a perfectly fine way to show the world that you're the one
> behind it, and that _you_ trust it.
> 
> And since I can imaging signing binaries myself, I don't feel that I can
> disallow anybody else doing so.
> 
> Another part of the DRM discussion is the fact that signing is only the 
> first step: _acting_ on the fact whether a binary is signed or not (by 
> refusing to load it, for example, or by refusing to give it a secret key) 
> is required too.
> 
> But since the signature is pointless unless you _use_ it for something,
> and since the decision how to use the signature is clearly outside of the
> scope of the kernel itself (and thus not a "derived work" or anything like
> that), I have to convince myself that not only is it clearly ok to act on
> the knowledge of whather the kernel is signed or not, it's also outside of
> the scope of what the GPL talks about, and thus irrelevant to the license.
> 
> That's the short and sweet of it. I wanted to bring this out in the open, 
> because I know there are people who think that signed binaries are an act 
> of "subversion" (or "perversion") of the GPL, and I wanted to make sure 
> that people don't live under mis-apprehension that it can't be done.
> 
> I think there are many quite valid reasons to sign (and verify) your
> kernel images, and while some of the uses of signing are odious, I don't
> see any sane way to distinguish between "good" signers and "bad" signers.
> 
> Comments? I'd love to get some real discussion about this, but in the end 
> I'm personally convinced that we have to allow it.
> 
> Btw, one thing that is clearly _not_ allowed by the GPL is hiding private
> keys in the binary. You can sign the binary that is a result of the build
> process, but you can _not_ make a binary that is aware of certain keys
> without making those keys public - because those keys will obviously have
> been part of the kernel build itself.
> 
> So don't get these two things confused - one is an external key that is
> applied _to_ the kernel (ok, and outside the license), and the other one
> is embedding a key _into_ the kernel (still ok, but the GPL requires that
> such a key has to be made available as "source" to the kernel).
> 
> 			Linus
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
