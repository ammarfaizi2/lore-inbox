Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261416AbSKNDcA>; Wed, 13 Nov 2002 22:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261456AbSKNDcA>; Wed, 13 Nov 2002 22:32:00 -0500
Received: from dp.samba.org ([66.70.73.150]:2752 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261416AbSKNDb7>;
	Wed, 13 Nov 2002 22:31:59 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: module mess in -CURRENT 
In-reply-to: Your message of "14 Nov 2002 02:27:20 -0000."
             <1037240840.14393.4.camel@irongate.swansea.linux.org.uk> 
Date: Thu, 14 Nov 2002 15:36:51 +1100
Message-Id: <20021114033853.0E63C2C057@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1037240840.14393.4.camel@irongate.swansea.linux.org.uk> you write:
> On Thu, 2002-11-14 at 00:59, Linus Torvalds wrote:
> > People who find the current module situation difficult can just compile in 
> > the stuff they need for now.
> 
> That makes driver debugging almost impossible. It also makes building a
> test kernel set for a lot of boxes impractical.

Sorry, I know I've been feeding Linus too slowly, but I've just flown
into Spain and I have a tutorial to deliver.  I'm solving it my not
sleeping, but that doesn't scale.

> The completely broken unload stuff is going to be a real pig, PCMCIA
> only works modular and doesn't work now the unloads are all broken.

Agreed, that's what "rmmod --force" is for.  Patch in the queue, I
promise.  That gives more breathing room for fixing the "marked
unsafe" issue.

> OTOH the module rewrite has some nice features and a combo modutils
> is going to sort some of the problem out fairly easily.

Patches welcome, of course.  I didn't do any work on the modutils once
they passed "backwards compat exec works, basic features work".

Trying to test both the entire stack of patches, and just the first
three I was sending to Linus, as every tree came out: well, you can
tell my testing wasn't thorough enough for .47.

> The biggest need though is documentation so people can actually fix all
> the drivers for this stuff.

I posted a document previously (again) and it recieved (valid) harsh
criticism for being opaque.  I'll rework it.  Basically, its an
expansion of the old try_inc_modcount to be a first-class citizen
(hence called try_module_get()).  As previously, should be called
(successfully!)  before calling through a function ptr which might be
in a module (ie. most code which exposes a "register_xxx" should use
it).  Exceptions if that function cannot sleep (and can't be
preemped).

Why is PCMCIA broken?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
