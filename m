Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268340AbUI2Mev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268340AbUI2Mev (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 08:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268345AbUI2Mev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 08:34:51 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:10631 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268340AbUI2Meq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 08:34:46 -0400
Message-ID: <35fb2e590409290534397ab462@mail.gmail.com>
Date: Wed, 29 Sep 2004 13:34:45 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Robert White <rwhite@casabyte.com>
Subject: Re: mlock(1)
Cc: Andrea Arcangeli <andrea@novell.com>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAB5m5SdJOJE2qQqawmmv7+gEAAAAA@casabyte.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <35fb2e59040928181676b15c1b@mail.gmail.com>
	 <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAB5m5SdJOJE2qQqawmmv7+gEAAAAA@casabyte.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2004 20:46:20 -0700, Robert White <rwhite@casabyte.com> wrote:

> (Sorry I am using outlook here at work by corporate mandate so my responses are
> tediously at the top... 8-)

Ouch. I thought even Outlook had the option to change posting form.

> I guess the first question to ask is who or what are you actually protecting the
> laptop against, what is their level of commitment, and what on the laptop are you
> trying to protect.

If I choose to use encryption on my laptop then I want to be sure it
has a foundation rather than relying on attacker ability - otherwise
there's always a risk those government agents Alan mentioned will come
to rely upon something like this some day believing it to be safe
(because they're more than capable enough to leave these things in
London taxis :P).

> 1) You have set your laptop not to boot from CD etc, and protected that option with a
> "bios settings password".

That's useless though because someone can trivially get around that -
it's why I don't use BIOS passwords by default.

> 2) You are making intelligent decisions about "how secure" your computer needs to be.

Sure. In my case I don't currently do anything as the risk assessment
goes something like ``it hardly ever leaves my sight and I'm happy to
kick the guy trying to nick it if necessary''.

> 4) The system doesn't have to be "perfect" (because none are) it just has to be
> "better" than the amount of effort the attacker is willing to expend.

I just don't like the idea of designing something that's known to be
flawed - someone would publish a set of instructions for getting
around it. Just like you don't need to know how to create complex bus
analyzers to do funky stuff with the xbox now that's all been
published and made publically available.

My sole point here really is that it's worth asking for a password
that the user actually has to type in themself. It's trivial to do and
most users are more than happy to do it - you can tie the password in
to some function of their user password if necessary and set this all
up for suspend when they first login to their desktop. I don't see the
difficulty here.

> 10) A smart guy with a good soldering iron and an eprom burner and a bunch of time
> will be able to defeat any of this because he can simply read the memory of the live
> system by adding in any piece of hardware that can do a bus-fetch.  (e.g. PCI
> bus-mastering etc).

But it'll be harder for him to defeat a system in which I've given a
password to login to my desktop which has been hashed and used to
encrypt the saved system state. I think Microsoft use the user
password as part of their EFS implementation - but in any case there's
no need for overkill when users are happy to type in a password on
login.

> In a system that never does a "resume" the meta-boot-block key generation tidbit
> never reaches the disk.

I care only about the part of the discussion relating to the save/restore cycle.

> During a system suspend, the "last thing" that happens is that the applet block is
> saved to the swap system in a known place.

> It is instantly and admittedly obvious that a person could take apart the computer
> and harvest this block and all the other regions of memory

So it's completely useless to me at least - I'd rather continue to use
nothing :-).

> CPU ID fetch: static means.

Luckily I don't have one of these in my laptop, but I do have a serial
number - so you'd need a generic mechanism for getting whatever unique
ID is available.

> On the other hand, for anything short of a really smart guy with a soldering iron, we
> now "know", as part of our restore, that we are using our CPU, our clock chip, our
> bios configuration (so, if set, our setup and our boot passwords) and our root file
> system and boot arguments (so no lilo-time override or installer disk).

So it's great for verifying a restore, but it's not secure :-).

> So with "just" a configuration change, the user may "switch" to the template that
> demands a password from the keyboard (and then reboot).  Now you have moved up "one
> notch" in the world, but you haven't had to change your kernel out or anything.

Yes ok. That would be ok perhaps but it still sounds like massive overkill.

> The fact of the matter is that this is "broken glass" security and detection.

So it's not worth using anything more than Alan's suggestion of a
warning message - this is massive overkill when a simple password
prompt is fine for those wishing to encrypt or otherwise just give a
warning. I don't even bother with this because my laptop has a
hardware sleep that doesn't need to save memory state to disk, and the
average attacker will take one look at my laptop and they won't
possibly understand how to use it ;-).

My worry is that when you create ellaborate security systems that are
fundamentally flawed, then you get people believing they are more
secure than they really are. Yes that's a people problem but it's also
a good reason not to try to push this kind of idea too hard. Feel free
to implement it of course - I might even use the passphrase
configuration.

Cheers,

Jon.
