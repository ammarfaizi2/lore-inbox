Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVAMQli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVAMQli (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 11:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVAMQkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 11:40:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:28308 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261178AbVAMQib (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 11:38:31 -0500
Date: Thu, 13 Jan 2005 08:38:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
In-Reply-To: <20050113082320.GB18685@infradead.org>
Message-ID: <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org>
References: <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org>
 <20050112185133.GA10687@kroah.com> <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org>
 <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
 <20050112205350.GM24518@redhat.com> <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org>
 <20050112182838.2aa7eec2.akpm@osdl.org> <20050113033542.GC1212@redhat.com>
 <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org> <20050113082320.GB18685@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Jan 2005, Christoph Hellwig wrote:
>2B
> On Wed, Jan 12, 2005 at 08:48:57PM -0800, Linus Torvalds wrote:
> > Without that capability set, you can only execute binaries that you cannot
> > write to, and that you cannot _get_ write permission to (ie you can't be
> > the owner of them either - possibly only binaries where the owner is
> > root).
> 
> I think this is called "mount user-writeable filesystems with -noexec" ;-)

You miss the point.

It wouldn't be a global flag. It's a per-process flag. For example, many 
people _do_ need to execute binaries in their home directory. I do it all 
the time. I know what a compiler is.

Others do not necessarily do that. Sure, you could mount each users home 
directory separately with a bind mount, but that's not only inconvenient, 
it also misses the point - it's not about _where_ the binary is, it's 
about _who_ runs it.

What is the real issue with MS security? Is it that NT is findamentally a 
weak kernel? Hey, maybe. Or maybe not. More likely it's the mindset that 
you trust everything, regardless of where they are. Most users are admins, 
and you run any code you see (or don't see) by default, whether it's in an 
email attachement or whatever.

Containment is what real security is about. Everybody knows bugs happen, 
and that people do stupid things. Developers, users, whatever. We all do.

For example, in many environments it could possibly be a good idea to make
even _root_ have the "can run non-root binaries flag" clear by default. 
Imagine a system that booted up that way, and used PAM to enable non-root 
binaries on a per-user basis (for developers who need it or otherwise 
people who are trusted to have their own binaries). Think about what that 
means...

Every single deamon in the system would have the flag clear by default.  
You take over the web-server, and the most you have to play with are the
binaries that are already installed on the system (and the code you can
inject directly into the web server process from outside - that's likely
to be the _real_ security hazard).

It's just another easy containment. It's not real security in itself, but
_no_ single thing is "real security". You just add containment, to the
point where it gets increasingly difficult to get to some state where you
can do lots of damage (in a perfect world, exponentially more so, but
these containments are seldom independent or each other).

NOTE! I'd personally hate some of the security things. For example, I
think the "randomize code addresses" is absolutely horrible, just because
of the startup overhead it implies (specifically no pre-linking). I also
immensely dislike exec-shield because of the segment games it plays - I
think it makes sense in the short run but not in the long run, so I much
prefer that one as a "vendor feature", not as a "core feature". 

So when I talk about security, I have this double-standard where I end up 
convinced that many features are things that _I_ should not do, but 
others likely should ;)

		Linus
