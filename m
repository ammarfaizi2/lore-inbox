Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265477AbUH0XFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265477AbUH0XFb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 19:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266666AbUH0XFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 19:05:31 -0400
Received: from jib.isi.edu ([128.9.128.193]:65415 "EHLO jib.isi.edu")
	by vger.kernel.org with ESMTP id S265477AbUH0XFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 19:05:06 -0400
Date: Fri, 27 Aug 2004 16:04:55 -0700
From: Craig Milo Rogers <rogers@isi.edu>
To: "Nemosoft Unv." <webcam@smcc.demon.nl>
Cc: Linus Torvalds <torvalds@osdl.org>, Xavier Bestel <xavier.bestel@free.fr>,
       Christoph Hellwig <hch@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Termination of the Philips Webcam Driver (pwc)
Message-ID: <20040827230455.GG24018@isi.edu>
References: <20040826233244.GA1284@isi.edu> <20040827185541.GC24018@isi.edu> <Pine.LNX.4.58.0408271157540.14196@ppc970.osdl.org> <200408272342.30619@smcc.demon.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408272342.30619@smcc.demon.nl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.08.27, Nemosoft Unv. wrote:
> > So I'd personally much prefer the user mode approach. At that point it's
> > still closed-source, but at least there is not even a whiff of a "hook"
> > inside the kernel.
> 
> My problem with that is that it makes using such cams a lot harder for both 
> users and developers of webcam tools. Basicly, every tool that wanted to 
> use webcam X that has some binary-only library would need to specifically 
> support it, use probing routines, check which formats are supported, set up 
> the decompressor, push the data through it, etc. Conversely, every user 
> that wanted to use webcams X, Y and Z would need to check first if they are 
> all supported by the program(s) he would like to use.

	Pardon me for arguing, but my experience says that it need not
be as difficult for the application program as you describe, although
a tad complex for the driver & library writer(s).  Applications see a
user-mode API, and whether the codecs (in this case) reside in the
kernel or in their own process need not be of interest to them: it is
quite possible to make an API that isolates the application from this
detail.  Probing routines, interrupt support, etc. would be handled by
kernel drivers, which for the purposes of the present discussion we've
been assuming are open source kernel modules.  The decompression
libraries, which may or may not be closed-source, would be loaded from
a standard library location using an agreed-upon naming convention.

	The mechanics to make this work are well known, although
tedious.  The kernel driver(s) will supply an identifier for the
type(s) of card(s) that are presently available.  The identifier(s)
will be use to load a library(s) based on a mapping scheme; here are
three common schemes: 1) use the identifier as part of the library
name , 2) provide a module map file (ala kernel modules), and 3) scan
the available libraries on application startup and have them
self-register (ala mozilla).

	Distribution of the drivers and libraries is also a well-known
problem.  Linux distributions will typically come with certain drivers
and/or codes preinstalled (depending upon the purpose of the
distribution, the intellectual property issues involved, etc.)
Vendors (enlightened ones!) will provide drivers and libraries on the
CDROMs (or other media) that accompany their products.  Web sites
(vendor supported or not) will offer online upgrades for drivers
and/or libraries.

> The point is, the current API for video devices is the Video4Linux of 
> Video4Linux2 interface. It's relative simple one, but it _works_ the same 
> on all hardware, either TV card or webcam. What you're proposing is 
> fragmenting that support into programs that support X, Y or Z, or only a 
> subset, or none, based on whether or not the developer of said tool had the 
> time, skill and desire to incorporate these libraries into their program.

	Not at all.  The application writers might not see any difference
at all from the present V4L2 interface, depending upon the details of
the API for encasulating the decompression libraries.  There may very well
be card-specific features that the applications have to know about, but
that issue is independent of the location of the decompression routines.

> So instead of putting the support burden on one person (me), you want to 
> distribute it among a few dozen software developers. I don't think that's 
> really smart. It also takes the fun out of hacking a small webcam tool 
> together for whatever purpose, if you need a ton of extra tools, libraries 
> and program just to get one image.

	I'm struggling to compile GnomeMeeting from CVS.  I certainly
suffer at times from having to deal with dozens of libraries, each
loaded from their own little niche on Sourceforge or Apache.org, etc.,
for various projects.  However, and again please permit me to disagree
with you, I don't think that Web camera support will be quite that
complex.  All you need is a common framework, and the driver(s) and
library(s) for the card(s) installed on your machine.

> A solution could be something like JACK for the ALSA sound cards, but then 
> for video. But you need a compelling reason, and somebody (somebodies) to 
> design, write and maintain it.

	So long as someone is available to maintain the closed-source
codecs (while, we all hope, working in parallel with the manufacturers
involved to secure open-source licensing for any currently
closed-source components), I am confident that we can put together
a team to implement the rest.  I would be pleased to be on the team.

> Anyway... wether or not PWC was illegal under the GPL, technically 
> undesirable or just not good enough, is irrelevant now. The damage has been 
> done, and that's just sad.

	Please... don't tell me that you've deleted the source files
for pwcx!!!  That would be sad.  Also, I hope that you are willing to
consider continuing to maintain the closed-source codecs in pwcx for a
while longer, under some circumstances.  Your expertise and
willingness to help others is really the most valuable resource here,
and it would indeed be truly sad if it has been exhausted.

					Craig Milo Rogers

