Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263341AbTIAWtn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 18:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263354AbTIAWtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 18:49:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:64402 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263341AbTIAWt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 18:49:29 -0400
Date: Mon, 1 Sep 2003 15:55:39 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@suse.cz>
cc: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fix up power managment in 2.6
In-Reply-To: <20030901211220.GD342@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0309011509450.5614-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > Patrick fucked up power managment in 2.6.0-test4 [...]
> > 
> > Ok, guys, how about just talking to each other without the personal 
> > attacks. Pavel in particular - this is more personal friction than 
> > anything else, since others do not seem to have the same visceral dislike 
> > of the patches, and there _has_ been discussion about them. 
> 
> Unfortunately, that was not personal attack, that was a fact. Even
> Patrick had to agree that his -test4 changes were bad idea, and I even
> have "official apology" from him (on irc).

No, I didn't say it was a bad idea. I said that I understood your
concerns, that I was sorry I broke it for you, and that I would fix it
ASAP. Several times in fact. 

> He just thinks he can fix his code, and I want that code to be
> reverted, reviewed, tested, and than merged back. There's no way
> current mess can be fixed in reasonable time.

I realize that posting it before merging it would have resulted in a
better outcome, as least thus far. However, it's been 11 days since I've
merged the orgininal code, and 2 since I posted the last patch. While
you've been ranting and raving, you've squandered a lot of valuable time
that could have been spent reviewing the code. 

> I've seen no discussion about that code, and certainly have not seen
> that code before it was merged, which is strange since I'm listed as
> software suspend maintainer.

BFD. swsusp is one piece of the puzzle, and I've not touched any of the 
core functionality. What I have done is: 

Secondly, look at what I've done to it: 

- Compartmentalized portions that are useful to more general 
  suspend/resume sequences. 

- Removed duplicate code between different PM mechanisms.

- Made it possible to use it with ACPI, instead of in lieu of it. 

- Cleaned up several functions, streamlined a few, added comments, and 
  made the names easier to swallow than the 'magic' variety. 

- Removed 5 calls to panic() and 8 instances of BUG(). 

It's resulted in a net reduction of lines of code, and I've made it much
easier to read. I'm sorry if this has caused some temporary instability,
especially if the last round of patches still hasn't fixed it. I will get
those resolved ASAP. (Again) 

In all actuality, I don't need swsusp. I have a better suspend-to-disk
implementation that is faster, smaller, and cleaner. I've hesitated
merging it because I thought swsusp improvements would be more welcome.
Obviously they're not; or you haven't actually taken the time to read the
code.

Regardless, you can have your toy back. I'm tired of reading it, trying to 
fix it, and more than anything, dealing with you. I'll document the API 
that a suspend-to-disk mechanism must follow to be used by the PM core, so 
that you may optionally hook into it and let users still leverage the 
generic suspend improvements.

I will also restore swsusp to whatever state you like - either -test1,
-test3 or -test4 state, or keep it the way it currently is in my patches.  
But note that doing so will result in a large amount of duplicated code
which you will be responsible for either merging or removing.

If you don't want to work with me, I will work around you. I'm not trying
to compete with you, rather, as I've said before, make it better for
everyone. Power management has not worked for a majority of users for a
long time. It's in dire need of someone with motivation, direction, and
the time to make it work properly, and get it on par with some of our
contemporary OSes. I'm trying to be that person, and actually fix things
in the long run, rather than encouraging people to "fix it themselves".


Also, continuing to flame me without a rebuttal is not very polite, and
indicates that you don't want to have an actual conversation. Please
remove me and any public mailing lists from the cc list if you're going to
continue to do this. I'll eventually filter you out, but please save
everyone else from the drivel..



	Pat


