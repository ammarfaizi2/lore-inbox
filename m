Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932516AbVKWVWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516AbVKWVWH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 16:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbVKWVWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 16:22:06 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:26709 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932516AbVKWVV6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 16:21:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PgD3xp1vO9kqWJ4cDa6u4qGydhCbkgEOT8nYZ4WGEK1fM37JExI9FHZWpluliHaw3L2jXNkwBaN4cwgWDBr96WHsihdPYXOxPh9SIWWF8JVok61YsM5KAOh35IcZud8dE/2L6b0YETAW03fF9V7mimFzWsf/ylPVqnPgZVnLnik=
Message-ID: <9a8748490511231321s914a97r1e3ccab946e59748@mail.gmail.com>
Date: Wed, 23 Nov 2005 22:21:54 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: gcoady@gmail.com
Subject: Re: Over-riding symbols in the Kernel causes Kernel Panic
Cc: Bill Davidsen <davidsen@tmr.com>, Ashutosh Naik <ashutosh.lkml@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <9em9o1d5fao3b1dc6dql7idgkrhsbaru77@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <c216304e0511230610x2b983e59h42c10517acd59e63@mail.gmail.com>
	 <4384AAED.3070804@tmr.com>
	 <9a8748490511231004l36edcf57mf0fb63c4a9e17f49@mail.gmail.com>
	 <9em9o1d5fao3b1dc6dql7idgkrhsbaru77@4ax.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/05, Grant Coady <grant_lkml@dodo.com.au> wrote:
> On Wed, 23 Nov 2005 19:04:41 +0100, Jesper Juhl <jesper.juhl@gmail.com> wrote:
>
> >On 11/23/05, Bill Davidsen <davidsen@tmr.com> wrote:
> >> Ashutosh Naik wrote:
> >> > Hi,
> >> >
> >> > I made e1000 ( or for that matter anything) a part of the 2.6.15-rc1
> >> > kernel and booted the kernel. Next I compiled e1000 as a module (
> >> > e1000.ko ), and tried to insmod it into the kernel( which already had
> >> > e1000 a compiled as a part of the kernel). I observed that
> >> > /proc/kallsyms contained two copies of all the symbols exported by
> >> > e1000, and I also got a Kernel Panic on the way.
> >> >
> >> > Is this behaviour natural and desirable ?
> >>
> >> No, trying to insert a module into a kernel built with the functionality
> >> compiled in is a vile perverted act, and probably illegal in Republican
> >> states! ;-)
> >>
> >> The other day I mentioned that reiser4 will find bugs because people
> >> will do bizarre things with it when it is more widely used. I think you
> >> have hit a "no one would ever do that" bug in the module loader, and
> >> demonstrated my point in the process.
> >>
> >> The panic isn't desirable, but I'm not sure what "correct behaviour"
> >> would be, I can't imagine that this is intended to work. The issues of
> >> removing such a module gracefully are significant.
> >
> >Wouldn't the desired behaviour be that when the kernel attempts to
> >load a module it checks if it is already present build-in and if so
> >simply refuse to load it at all?
>
> But that sounds just too easy to implement, what's the catch?  :o)

I've not looked at what it would take to do that, nor what measures
are currently in place, *at all*, but as I see it, all it would take
would be some "tag" present for each message stating if it was "build
in", or "currently loaded as a module", then on each module load check
the "tag" of the to-be-loaded module against the list of current
in-kernel tags, then reject if already on the list.
I can't see why there would be a catch...

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
