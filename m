Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262392AbUK3WyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262392AbUK3WyO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 17:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbUK3WyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 17:54:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:12697 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262392AbUK3WwC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 17:52:02 -0500
Date: Tue, 30 Nov 2004 14:51:20 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: Alexandre Oliva <aoliva@redhat.com>, dhowells <dhowells@redhat.com>,
       Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       Matthew Wilcox <matthew@wil.cx>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
In-Reply-To: <1101854061.4574.4.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0411301447570.22796@ppc970.osdl.org>
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
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Nov 2004, David Woodhouse wrote:
> 
> That depends on your definition of 'break'. It should prevent abuse.

Not really. 

It should prevent _future_ abuse.

The notion of "preventing existing xxx" is insane. You can't "prevent" 
something that already happened unless you've come up with some new 
interesting theory of causality.

> To pick a specific example, since you like them: where userland programs
> are including atomic.h, and hence writing programs which don't compile
> on some architectures, and which compile on others but silently give
> non-atomic results, it's perfectly acceptable and indeed advisable to
> prevent compilation across the board.
> 
> Some people might call that breakage; I don't.

I do. The thing is, the people who _notice_ the breakage are often the 
people who don't know what the hell to do about it.

The way to prevent _future_ abuse is by adding something like

	#ifndef __KERNEL__
	#warning "This really doesn't work"
	#endif

which does that, and has the advantage of not breaking anything at all.

In other words: if you want to move things around just to break things, 
THEN THAT IS INCREDIBLY STUPID. We don't do things to screw our users 
over. 

Feel free to send a patch.

		Linus
