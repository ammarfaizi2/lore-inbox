Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVA0UMC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVA0UMC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 15:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVA0UKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 15:10:42 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:65233 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261163AbVA0UIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 15:08:07 -0500
Message-ID: <41F94A3B.1080906@comcast.net>
Date: Thu, 27 Jan 2005 15:08:27 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: Patch 4/6  randomize the stack pointer
References: <20050127101117.GA9760@infradead.org>  <20050127101322.GE9760@infradead.org>  <41F92721.1030903@comcast.net> <1106848051.5624.110.camel@laptopd505.fenrus.org> <41F92D2B.4090302@comcast.net> <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org> <41F937C0.4050803@comcast.net> <Pine.LNX.4.58.0501271121020.2362@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501271121020.2362@ppc970.osdl.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Linus Torvalds wrote:
> 
> On Thu, 27 Jan 2005, John Richard Moser wrote:
> 
>>>Your suggestion of 256MB of randomization for the stack SIMPLY IS NOT 
>>>ACCEPTABLE for a lot of uses. People on 32-bit archtiectures have issues 
>>>with usable virtual memory areas etc.
>>
>>It never bothered me on my Barton core or Thoroughbred, or on the Duron,
>>or the Thoroughbred downstairs.
> 
> 
> Me, me, me, me! "I don't care about anybody else, if it works for me it 
> must work for everybody else too".
> 

"Me" happens to be "Me sitting at a desk top doing word processing, IRC,
some Quake3 and Doom, listening to music, playing with Gimp, watching
videos, and running firefox."  I'm assuming "me" == "99% of all desktop
users," and that we also can't predict what all specialized machines need.

> See a possible logical fallacy there somewhere?

I see you're trying to lead me into saying we should be more focused on
supplying exactly what works for 100% of everybody, which we can't do.

> 
> The fact is, different people have different needs. YOU only need to care
> about yourself. That's not true for a vendor. A single case that doesn't
> work ends up either (a) being ignored or (b) costing them money. See the 
> problem? They can't win. Except by taking small steps, where the breakage 
> is hopefully small too - and more importantly, because it's spread out 
> over time, you hopefully know what broke it.

Something I wrote once

http://en.wikipedia.org/wiki/PaX

- --CLIP--
A DoS attack (or its equivalent) is generally an annoyance, and may in
some situations cause loss of time or resources (e.g. lost sales for a
business whose website is affected): however, no data should be
compromised when PaX intervenes, as no information will be improperly
copied elsewhere. Nevertheless, the equivalent of a DoS attack is in
some environments unacceptable; some businesses have level of service
contracts or other conditions which make successful intruder entry a
less costly problem than loss of or reduction in service. The PaX
approach is thus not well suited to all circumstances; however, in many
cases, it is an acceptable method of protecting confidential information
by preventing successful security breaches.
- --CLIP--

This doesn't just apply to PaX or Gr or whatever you want to claim I'm
trying to get into the kernel right now; it applies to everything.  In
some cases anything can be bad.  The idea is to realize that these are
*specialized* cases, and make a design decision:  A) allow a quick way
to disable the stuff (finegrained runtime with executable flags, or
disable in kernel); B) let the 1/100000000000000 people who this bothers
write a patch to change it themselves (RTLinux for example).

> 
> And when I say RH, I mean "me". That's the reason I personally hate
> merging "D-day" things where a lot of things change. I much prefer merging
> individual changes in small pieces. When things go wrong - and they will -
> you can look at the individual pieces and say "ok, it's definitely not
> that one" or "Hmm.. unlikely, but let's ask the reporter to check that
> thing anyway" or "ok, that looks suspicious, let's start from there".
> 
> So for example, 3GB of virtual space is enough for most things. In fact, 
> just 1GB is plenty for 99% of all things. But some programs will break, 
> and they can break in surprising ways. Like "my email indexing stopped 
> working" - because my combined mailboxes are currently 2.8GB, and it 
> slurps them all in in one go to speed things up.
> 

This is true.  I however have something like 300M of e-mail and I'm
subscribed to something like 15 or 20 mailing lists for about a year
now.  You of course have a work-around:  Don't try to load 800 gigs of
e-mail into memory all at once.  If you need to *quickly* parse this,
this may not be an acceptable work-around (though reading ahead and
dumping after processing, i.e. buffering, may be a good middle-ground).

Like I said, it's not something you'll hit every day on every machine,
and it's something that can be quickly worked around.  In the worst
case, disable all enhancements on the binary (using chpax or execstack
or whatever for whatever ASLR/NX system and God knows what else you're
using) for that binary or the system, depending on how fine-grained you
can control it.

I sympathise, really, but you're that one in ten-jillion.  :)

> (That wasn't a made-up-example, btw. I had to write this stupid email
> searcher for the SCO subpoena, and the fastest way was literally to index
> everything in memory. Thank gods for 64-bit address spaces, because I
> ended up avoiding having to be incredibly careful by just doing it on
> another machine instead).
> 

The fastest way is ALWAYS in memory :)  (unless you have $12000 SATA
drives with 2G of on-board cache and 500 track read-ahead)

> 			Linus
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB+Uo5hDd4aOud5P8RAr06AJsHU/vklnUxii8o7QZA78EFXy5lyACeJYIE
0M9rggfLgNHZMJGej8oLrbE=
=HN6I
-----END PGP SIGNATURE-----
