Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262426AbUK3XzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbUK3XzH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 18:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbUK3XzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 18:55:06 -0500
Received: from canuck.infradead.org ([205.233.218.70]:1290 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262432AbUK3XvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 18:51:24 -0500
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alexandre Oliva <aoliva@redhat.com>, dhowells <dhowells@redhat.com>,
       Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       Matthew Wilcox <matthew@wil.cx>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
In-Reply-To: <Pine.LNX.4.58.0411301447570.22796@ppc970.osdl.org>
References: <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org>
	 <19865.1101395592@redhat.com>
	 <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
	 <1101406661.8191.9390.camel@hades.cambridge.redhat.com>
	 <20041127032403.GB10536@kroah.com>
	 <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
	 <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <8219.1101828816@redhat.com>
	 <Pine.LNX.4.58.0411300744120.22796@ppc970.osdl.org>
	 <ormzwzrrmy.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <Pine.LNX.4.58.0411301249590.22796@ppc970.osdl.org>
	 <orekibrpmn.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <Pine.LNX.4.58.0411301423030.22796@ppc970.osdl.org>
	 <1101854061.4574.4.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0411301447570.22796@ppc970.osdl.org>
Content-Type: text/plain
Date: Tue, 30 Nov 2004 23:50:56 +0000
Message-Id: <1101858657.4574.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-30 at 14:51 -0800, Linus Torvalds wrote:
> The way to prevent _future_ abuse is by adding something like
> 
> 	#ifndef __KERNEL__
> 	#warning "This really doesn't work"
> 	#endif
> 
> which does that, and has the advantage of not breaking anything at all.
> 
> In other words: if you want to move things around just to break things, 
> THEN THAT IS INCREDIBLY STUPID. We don't do things to screw our users 
> over. 

Linus, you're arguing that it's better to let users use something which
is non-portable and silently does the wrong thing, as long as it
actually compiles. That this is preferable to making sure it doesn't
compile. 

Now, there are cases (like _perhaps_ byteorder.h) where we should
probably allow this kind of 'abuse' to continue because it's fairly
harmless and it does actually _work_.

But atomic.h isn't an example of that.

If I wrote a userspace program which relies upon the md5sum of certain
kernel headers not changing, would you decree that the headers in
question should not change at _all_ because that would 'break existing
software'? Of course not; you have to draw the line somewhere. And I
would draw it somewhere between atomic.h and byteorder.h -- where would
_you_ draw it?

-- 
dwmw2

