Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262704AbVA0TbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262704AbVA0TbX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 14:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbVA0TbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 14:31:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:60828 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262704AbVA0Ta7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 14:30:59 -0500
Date: Thu, 27 Jan 2005 11:30:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: John Richard Moser <nigelenki@comcast.net>
cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: Patch 4/6  randomize the stack pointer
In-Reply-To: <41F937C0.4050803@comcast.net>
Message-ID: <Pine.LNX.4.58.0501271121020.2362@ppc970.osdl.org>
References: <20050127101117.GA9760@infradead.org>  <20050127101322.GE9760@infradead.org>
  <41F92721.1030903@comcast.net> <1106848051.5624.110.camel@laptopd505.fenrus.org>
 <41F92D2B.4090302@comcast.net> <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org>
 <41F937C0.4050803@comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 27 Jan 2005, John Richard Moser wrote:
> 
> > Your suggestion of 256MB of randomization for the stack SIMPLY IS NOT 
> > ACCEPTABLE for a lot of uses. People on 32-bit archtiectures have issues 
> > with usable virtual memory areas etc.
> 
> It never bothered me on my Barton core or Thoroughbred, or on the Duron,
> or the Thoroughbred downstairs.

Me, me, me, me! "I don't care about anybody else, if it works for me it 
must work for everybody else too".

See a possible logical fallacy there somewhere?

The fact is, different people have different needs. YOU only need to care
about yourself. That's not true for a vendor. A single case that doesn't
work ends up either (a) being ignored or (b) costing them money. See the 
problem? They can't win. Except by taking small steps, where the breakage 
is hopefully small too - and more importantly, because it's spread out 
over time, you hopefully know what broke it.

And when I say RH, I mean "me". That's the reason I personally hate
merging "D-day" things where a lot of things change. I much prefer merging
individual changes in small pieces. When things go wrong - and they will -
you can look at the individual pieces and say "ok, it's definitely not
that one" or "Hmm.. unlikely, but let's ask the reporter to check that
thing anyway" or "ok, that looks suspicious, let's start from there".

So for example, 3GB of virtual space is enough for most things. In fact, 
just 1GB is plenty for 99% of all things. But some programs will break, 
and they can break in surprising ways. Like "my email indexing stopped 
working" - because my combined mailboxes are currently 2.8GB, and it 
slurps them all in in one go to speed things up.

(That wasn't a made-up-example, btw. I had to write this stupid email
searcher for the SCO subpoena, and the fastest way was literally to index
everything in memory. Thank gods for 64-bit address spaces, because I
ended up avoiding having to be incredibly careful by just doing it on
another machine instead).

			Linus
