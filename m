Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbUK2Jni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbUK2Jni (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 04:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbUK2Jnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 04:43:37 -0500
Received: from baythorne.infradead.org ([81.187.226.107]:64906 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261647AbUK2JnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 04:43:18 -0500
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       hch@infradead.org, aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
In-Reply-To: <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
References: <19865.1101395592@redhat.com>
	 <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
	 <1101406661.8191.9390.camel@hades.cambridge.redhat.com>
	 <20041127032403.GB10536@kroah.com>
	 <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1101721336.21273.6138.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Mon, 29 Nov 2004 09:42:16 +0000
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-11-28 at 17:28 -0800, Linus Torvalds wrote:
> In particular, any re-organization that breaks _existing_ uses is totally
> pointless. If you break existing uses, you might as well _not_ re-
> organize, since if you consider kernel headers to be purely kernel-
> internal (like they should be, but hey, reality trumps any wishes we might 
> have), then the current organization is perfectly fine.

Agreed, with the proviso that the inclusion of bitops.h, spinlock.h, and
other kernel-private stuff like that should not be considered 'existing
uses'. It's _already_ broken. It won't compile on some architectures,
and will silently do the wrong thing on others. Causing the compile to
fail consistently would be a _feature_.

> So I think this whole discussion has been largely pointless. We undeniably
> have existing users of kernel headers. That's just a fact.  If we break
> them, it doesn't _matter_ how the kernel headers look, and then "existing
> practice" is about as good an organization as anything, and breaking
> things just to break things is not something I'm in the least interested
> in. "Beauty"  comes secondary to "usefulness".

Usefulness is what we're after. Preventing the naïve user from including
spinlock.h and thinking that it'll give useful spinlocks would be
useful.

I've lost track of the number of times things have broken because of
incorrect use of kernel headers from userspace. That's what we're trying
to fix -- by putting only the bits which are _supposed_ to be visible
into files which userspace sees, where we know they define part of the
userspace API and hence we can be extremely careful when editing them. 

I don't think it makes sense at this point for us to bury our collective
heads in the sand and pretend there isn't a problem here that's worth
fixing.

I agree that it should be obviously correct though -- and that's why
we're trying to end up with a structure that in the first pass would
give us in userspace essentially what we already have in the various
glibc-kernheaders packages, but without the constant and unnecessary
need for some poor sod to keep those up to date by hand.

-- 
dwmw2


