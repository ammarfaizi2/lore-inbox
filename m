Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbULAALX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbULAALX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 19:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbULAALW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 19:11:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:33243 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261161AbULAALE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 19:11:04 -0500
Date: Tue, 30 Nov 2004 16:10:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: Alexandre Oliva <aoliva@redhat.com>, dhowells <dhowells@redhat.com>,
       Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       Matthew Wilcox <matthew@wil.cx>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
In-Reply-To: <1101858657.4574.33.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0411301605500.22796@ppc970.osdl.org>
References: <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org> 
 <19865.1101395592@redhat.com>  <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
  <1101406661.8191.9390.camel@hades.cambridge.redhat.com> 
 <20041127032403.GB10536@kroah.com>  <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
  <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org> 
 <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br>  <8219.1101828816@redhat.com>
  <Pine.LNX.4.58.0411300744120.22796@ppc970.osdl.org> 
 <ormzwzrrmy.fsf@livre.redhat.lsd.ic.unicamp.br> 
 <Pine.LNX.4.58.0411301249590.22796@ppc970.osdl.org> 
 <orekibrpmn.fsf@livre.redhat.lsd.ic.unicamp.br> 
 <Pine.LNX.4.58.0411301423030.22796@ppc970.osdl.org> 
 <1101854061.4574.4.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0411301447570.22796@ppc970.osdl.org>
 <1101858657.4574.33.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Nov 2004, David Woodhouse wrote:
> 
> Linus, you're arguing that it's better to let users use something which
> is non-portable and silently does the wrong thing, as long as it
> actually compiles. That this is preferable to making sure it doesn't
> compile. 

I'm saying that if it worked before, it should work after. And my 
suggestion gives a nice warning.

> But atomic.h isn't an example of that.

Even atomic.h. I could well imagine that somebody includes atomic.h just 
to get the thread-safe updates for some architectures. For example, 
asm-alpha/atomic.h does it right, and I woul dnot be at all surprised if 
somebody had noticed.

And your suggestion has the problem that the people who get bitten by a 
non-compiling thing are not necessarily the same people who can fix it.

> software'? Of course not; you have to draw the line somewhere. And I
> would draw it somewhere between atomic.h and byteorder.h -- where would
> _you_ draw it?

I'll draw it at "somebody might validly use it", because the fact is, I 
can't test it. 

Which is why I want patches to this to be OBVIOUSLY CORRECT, dammit! How 
hard is that to understand?

The fact is, the less benefit there is from a change, the more obviously 
correct it has to be in all forms. Moving stuff around in header files 
basically fixes zero bugs in the kernel, so the benefit for the kernel is 
basically zero. Which means that the obviousness factor of the change had 
better be pretty close to infinite.

Comprende? 

		Linus
