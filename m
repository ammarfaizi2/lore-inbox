Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbUK2Jxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbUK2Jxa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 04:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbUK2Jxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 04:53:30 -0500
Received: from ozlabs.org ([203.10.76.45]:52936 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261644AbUK2Jx0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 04:53:26 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16810.61839.658951.369223@cargo.ozlabs.ibm.com>
Date: Mon, 29 Nov 2004 20:53:19 +1100
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <greg@kroah.com>, David Woodhouse <dwmw2@infradead.org>,
       Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       hch@infradead.org, aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
In-Reply-To: <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
References: <19865.1101395592@redhat.com>
	<20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
	<1101406661.8191.9390.camel@hades.cambridge.redhat.com>
	<20041127032403.GB10536@kroah.com>
	<16810.24893.747522.656073@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> In particular, any re-organization that breaks _existing_ uses is totally
> pointless. If you break existing uses, you might as well _not_ re-
> organize, since if you consider kernel headers to be purely kernel-
> internal (like they should be, but hey, reality trumps any wishes we might 
> have), then the current organization is perfectly fine.

Recently I had some users complaining because their userspace program
that includes <asm/atomic.h> compiles OK as a ppc64 program but not as
a ppc32 program.  The reason for that is that asm-ppc/atomic.h has
#ifdef __KERNEL__ around the inline definitions of atomic_inc et al.,
but asm-ppc64/atomic.h doesn't.

My response was that they shouldn't be using <asm/atomic.h> because
(a) it's an internal kernel header, not part of the kernel ABI, (b)
it's not portable (it happens to work on some popular architectures,
but won't work on all) and (c) they're really only entitled to use
those particular inline function definitions in GPL'd programs anyway.

To which the obvious reply is "well then why is it in /usr/include?"
It's because the glibc build process copies all the kernel headers to
/usr/include, but that's not an answer from a user's point of view.

I'd be interested to hear your take on this.  Should we try to make
our atomics easy and safe for userspace to use (including putting them
under the LGPL)?  Or can you see a better solution?

Paul.
