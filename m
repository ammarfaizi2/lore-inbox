Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267358AbUH0TMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267358AbUH0TMq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 15:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267325AbUH0TJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 15:09:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:21915 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267358AbUH0TGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 15:06:37 -0400
Date: Fri, 27 Aug 2004 12:06:19 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Craig Milo Rogers <rogers@isi.edu>
cc: Xavier Bestel <xavier.bestel@free.fr>,
       Christoph Hellwig <hch@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       webcam@smcc.demon.nl
Subject: Re: Termination of the Philips Webcam Driver (pwc)
In-Reply-To: <20040827185541.GC24018@isi.edu>
Message-ID: <Pine.LNX.4.58.0408271157540.14196@ppc970.osdl.org>
References: <20040826233244.GA1284@isi.edu> <20040827004757.A26095@infradead.org>
 <Pine.LNX.4.58.0408261700320.2304@ppc970.osdl.org> <20040827094346.B29407@infradead.org>
 <Pine.LNX.4.58.0408271027060.14196@ppc970.osdl.org> <1093628254.15313.14.camel@gonzales>
 <Pine.LNX.4.58.0408271106330.14196@ppc970.osdl.org> <20040827185541.GC24018@isi.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Aug 2004, Craig Milo Rogers wrote:
> 
> 	If you read Nemosoft's final driver release (which has been
> reposted, and of which I now have a copy), you can see that he was
> rewriting his code to move the proprietary codecs out of the kernel
> entirely, and into user-mode libraries to be linked with consenting
> applications 

That sounds quite good, in my opinion. 

> Of course, this is still nowhere as good as a wholly open source
> solution, a position with which I think Nemosoft concurs, based on his
> messages.

Clearly open-source code that does it all would be nice, whether in user
space or kernel space. But lacking that, a kernel driver that does the
basics (ie you can still use it without any binary stuff), coupled with a
user library that can decode the compressed frames is pretty good already.

One thing to note that people may not understand: open source is about
more than "rabid zealotry" like some people seem to think. Open source is
_important_ from a technical angle. Not just looking for bugs and
supporting it, but for "small details" like "hey, it works on my ppc64
machine too".

The fact is, Linux has been a hell of a lot more successful at moving to 
things like x86-64 and ppc64 than Windows will _ever_ be. And the reason 
is open source drivers. 

So guys, this is not about zealotry. This is about hardnosed technical
decisions where closed-source binary drivers are actually _detrimental_ to
Linux because they have a tendency to lock people into setups that aren't 
good.

Whenever somebody says "accept the driver to help users", they are missing
the big picture. A binary driver SCREWS OVER users on other architectures.  
It pretty much guarantees that those other architectures will never be
supported. (And that's totally ignoring the maintenance issues even on
regular x86).

> 	Linus, would you adress a moot issue, please?  If Nemosoft (or
> someone else) were to release some of the codecs in question as one or
> more open-source loadable kernel modules (similar to sound card
> support modules in the ALSA system), while other codecs remain
> binary-only loadable kernel modules (distributed outside the kernel,
> but using the same hook as the open-source loadable modules), would
> the pwc driver and codec extension hook be allowable, in your opinion,
> please?

I'd be leery.

In ALSA, the module interface is about open source drivers, and whatever
binary modules exist are very much a small detail that almost nobody 
really needs to care about. It seriously sounds like the PWC case would be 
different, with the binary codecs being the most important ones. That 
makes any open-source ones pretty pointless.

So I'd personally much prefer the user mode approach. At that point it's 
still closed-source, but at least there is not even a whiff of a "hook" 
inside the kernel. 

		Linus
