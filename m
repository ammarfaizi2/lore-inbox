Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262126AbUK3P62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbUK3P62 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 10:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbUK3P62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 10:58:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:49796 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262126AbUK3P6Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 10:58:25 -0500
Date: Tue, 30 Nov 2004 07:58:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: Alexandre Oliva <aoliva@redhat.com>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
In-Reply-To: <1101828924.26071.172.camel@hades.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.58.0411300751570.22796@ppc970.osdl.org>
References: <19865.1101395592@redhat.com>  <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
  <1101406661.8191.9390.camel@hades.cambridge.redhat.com> 
 <20041127032403.GB10536@kroah.com>  <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
  <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org> 
 <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br> 
 <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org>
 <1101828924.26071.172.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Nov 2004, David Woodhouse wrote:
>
> On Mon, 2004-11-29 at 09:41 -0800, Linus Torvalds wrote:
> > In fact, in many ways I'd prefer to have source-level annotations like 
> > "this is exported to user space" over trying to gather things in one 
> > place.
> 
> I don't think you would; not once you really tried it. 
> 
> That's what the littering of ifdef __KERNEL__ attempts to do, and
> there's not really any better way of doing it than that.

The fact is, despite this stupid and way-too-long thread, #ifdef 
__KERNEL__ has worked for over a decade, and works damn well, everything 
considered. 

Remember the second-system-syndrome? It comes from people wanting to fix 
problems in the current implementation, without thinking about all the 
things that it does _well_ (because the things that work are not on their 
radar - they just work). And no, __KERNEL__ may not be pretty, but it's 
damn simple to fix up, and one thing it does really well is allow 
flexibility in a way that forcing structure does not.

I know people like "structure". But it's _waayyy_ overrated. The reason we 
use C instead of some other programming environment is not that C is the 
most highly structured language around, but it's the most _flexible_ one, 
largely because it says "let's give people rope". It allows structure, but 
if you want to cast things around and use gotos, it says "sure, master, 
you're the boss".

Same thing here. The __KERNEL__ approach says "whatever you want, boss".  
It doesn't get in the way. Maybe it doesn't actively _help_ you either,
but you never have to fight any structure it imposes on you.

Also, there _are_ better ways of annotating it than __KERNEL__. In 
particular, if we had a "user annotation", I could make sparse sit up and 
take notice, and _complain_ when you use a non-specific-sized type. That's 
not just theory - Al Viro was talking about that at some point.

			Linus
