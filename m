Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262319AbUK3U7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbUK3U7E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 15:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbUK3U5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 15:57:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:30368 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262315AbUK3U4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 15:56:47 -0500
Date: Tue, 30 Nov 2004 12:56:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alexandre Oliva <aoliva@redhat.com>
cc: David Howells <dhowells@redhat.com>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, David Woodhouse <dwmw2@infradead.org>,
       Matthew Wilcox <matthew@wil.cx>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
In-Reply-To: <ormzwzrrmy.fsf@livre.redhat.lsd.ic.unicamp.br>
Message-ID: <Pine.LNX.4.58.0411301249590.22796@ppc970.osdl.org>
References: <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org>
 <19865.1101395592@redhat.com> <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
 <1101406661.8191.9390.camel@hades.cambridge.redhat.com> <20041127032403.GB10536@kroah.com>
 <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
 <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br> <8219.1101828816@redhat.com>
 <Pine.LNX.4.58.0411300744120.22796@ppc970.osdl.org>
 <ormzwzrrmy.fsf@livre.redhat.lsd.ic.unicamp.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Nov 2004, Alexandre Oliva wrote:
> 
> - move anything that is not protected by #ifdef __KERNEL__ to the
> ukabi header tree, adding an include in the beginning of the original
> header that includes the ukabi header.

No. I want stuff that goes into the ABI tree to be clearly _defined_ to be 
user-visible. Not a "let's move it all there and then prune it". 

Leave anything questionable in the current location. And never EVER move 
anything that is kernel-internal to a new "clean" tree, because that would 
be totally pointless. At that point, people would have to edit the "clean" 
tree even for kernel internal stuff. No go.

Also, "ukabi" just isn't going to fly as a name. It's also not as simple 
as you seem to think, since a lot of these ABI things are architecture- 
dependent, which apparently all you guys have totally ignored. 

I've suggested "include/user/" and "include/asm-xxx/user", which handles 
architecture-specific parts too. I'm ok with doing it the other way 
around, ie "include/user/" and "include/user/arch-xxxx".

And "user" might be "user-abi" or something like that, but it sure isn't 
going to be some unreadable contraction.

And I _still_ want to see these patches only for things where somebody can 
validly argue that 
 (a) it can't break anything (ie the old location still includes the new 
     one, exactly the same way)
 (b) there are people who will actually take _advantage_ of that 
     particular file (ie "just because I think so" doesn't fly).

Moving files around is just too disruptive to be done without damn good 
reason.

		Linus
