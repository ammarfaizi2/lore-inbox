Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132053AbRCYQB3>; Sun, 25 Mar 2001 11:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132051AbRCYQBT>; Sun, 25 Mar 2001 11:01:19 -0500
Received: from [195.63.194.11] ([195.63.194.11]:35076 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S132053AbRCYQBD>; Sun, 25 Mar 2001 11:01:03 -0500
Message-ID: <3ABE132F.E919F908@evision-ventures.com>
Date: Sun, 25 Mar 2001 17:47:59 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Jonathan Morton <chromi@cyberspace.org>
CC: Rik van Riel <riel@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "James A. Sutherland" <jas88@cam.ac.uk>,
        Guest section DW <dwguest@win.tue.nl>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] OOM handling
In-Reply-To: <3ABDF8A6.7580BD7D@evision-ventures.com> <l03130321b6e3c0533688@[192.168.239.101]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Morton wrote:
> 
> >- the AGE_FACTOR calculation will overflow after the system has
> >  an uptime of just _3_ days
> 
> Tsk tsk tsk...
> 
> >Now if you can make something which preserves the heuristics which
> >serve us so well on desktop boxes and add something that makes it
> >also work on your Oracle servers, then I'd be interested.
> 
> What do people think of my "adjustments" to the existing algorithm?  Mostly
> it gives extra longevity to low-UID and long-running processes, which to my
> mind makes sense for both server and desktop boxen.
> 
> Taking for example an 80Mb process under my adjustments, it is reduced to
> under the badness of a new shell process after less than a week's uptime
> (compared to several months), especially if it is run as low-UID.  Small,
> short-lived interactive processes still don't get *too* adversely affected,
> but a memory hog with only a few hours' uptime will still get killed with
> high probability (pretty much what we want).
> 
> I didn't quite understand Martin's comments about "not normalised" -
> presumably this is some mathematical argument, but what does this actually
> mean?

Not mathematics. It's from physics. Very trivial physics, basic scool
indeed.
If you try to calculate some weightning
factors which involve different units (in this case mostly seconds and
bits)
then you will have to make sure tha those units get factorized out.
Rik is just throwing the absolute values together...

Trivial example:
"How long does it take to travel from A to B?"
"It takes about 1000sec."
"How long does it take to travel from C to D?"
"It takes about  100sec."
"Ah, so it's 10 times longer from A to B then from C to D".

Write it down - you just divide the seconds out.

In case of varying intervalls you have to normalize
measures by max/min values. Since for example the
amount of RAM in a box can vary as well. Otherwise
your algorithms will behave very differently on boxes
with low RAM in comparision to boxes with huge amounts of
it. That's what one says if he talks about an
algorithm "scalling well".
