Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbWFUIXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbWFUIXM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 04:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbWFUIXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 04:23:12 -0400
Received: from canuck.infradead.org ([205.233.218.70]:18837 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S932485AbWFUIXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 04:23:10 -0400
Subject: Re: Sanitise ethtool.h and mii.h for userspace.
From: David Woodhouse <dwmw2@infradead.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netdev List <netdev@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <44989E63.9010300@garzik.org>
References: <200606202308.k5KN83bT013398@hera.kernel.org>
	 <44989E63.9010300@garzik.org>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 09:23:03 +0100
Message-Id: <1150878183.3176.551.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.1.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-20 at 21:18 -0400, Jeff Garzik wrote:
> How can reviewers make an informed decision, when you completely failed 
> to note:
> 
> * This breaks the primary userspace user of this header, ethtool(8)

I cannot reproduce with either an ethtool-3 tarball or a fresh checkout
from your git tree. Can you show me the error?

It's a somewhat surprising allegation, because ethtool doesn't even
_use_ the header directly from the kernel. It has its own copy, and
currently includes it like this...

typedef unsigned long long u64;         /* hack, so we may include kernel's ethtool.h */
typedef __uint32_t u32;         /* ditto */
typedef __uint16_t u16;         /* ditto */
typedef __uint8_t u8;           /* ditto */
#include "ethtool-copy.h"

> * The patch was NAK'd (and I don't even get a "Naked-by:" header :))

Sorry, my recollection was that you backed down after everyone turned on
you and declared that "but I _want_ to use 'u32' for userspace stuff
because underscores hurt my eyes" was too silly for words. You didn't
get a mention in the commit comment because I'd already committed it by
the time we had the discussion. But I did mention it to Andrew at the
time I asked him to put the hdrcleanup tree into -mm, and he seemed
perfectly happy with the change.

> * Despite knowing all this for quite some time, no associated userspace 
> fix patch has ever appeared.

That's because to the best of my knowledge, userspace doesn't _need_ any
fix at the moment. We've built the whole of the Fedora Core 6 test 1
release against (a subset of) these headers, and that includes ethtool.

> If you are going to break stuff, AT LEAST TELL PEOPLE IN ALL CAPS ABOUT 
> IT, rather than providing the highly deceptive description as above. 
> And be courteous enough to help fix the breakage, if you please. 

If I break stuff, I promise I'll bear that in mind.

-- 
dwmw2

