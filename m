Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbVLPNWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbVLPNWD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 08:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbVLPNWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 08:22:03 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56593 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932168AbVLPNWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 08:22:01 -0500
Date: Fri, 16 Dec 2005 13:21:23 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: David Howells <dhowells@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, cfriesen@nortel.com,
       torvalds@osdl.org, hch@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051216132123.GB1222@flint.arm.linux.org.uk>
Mail-Followup-To: Nick Piggin <nickpiggin@yahoo.com.au>,
	David Howells <dhowells@redhat.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	cfriesen@nortel.com, torvalds@osdl.org, hch@infradead.org,
	matthew@wil.cx, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
References: <15167.1134488373@warthog.cambridge.redhat.com> <1134490205.11732.97.camel@localhost.localdomain> <1134556187.2894.7.camel@laptopd505.fenrus.org> <1134558188.25663.5.camel@localhost.localdomain> <1134558507.2894.22.camel@laptopd505.fenrus.org> <1134559470.25663.22.camel@localhost.localdomain> <20051214033536.05183668.akpm@osdl.org> <15412.1134561432@warthog.cambridge.redhat.com> <11202.1134730942@warthog.cambridge.redhat.com> <43A2BAA7.5000807@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A2BAA7.5000807@yahoo.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2005 at 12:01:27AM +1100, Nick Piggin wrote:
> You were proposing a worse default, which is the reason I suggested it.

I'd like to qualify that.  "for architectures with native cmpxchg".

For general consumption (not specifically related to mutex stuff)...

For architectures with llsc, sequences stuch as:

	load
	modify
	cmpxchg

are inefficient because they have to be implemented as:

	load
	modify
	load
	compare
	store conditional

Now, if we consider using llsc as the basis of atomic operations:

	load
	modify
	store conditional

and for cmpxchg-based architectures:

	load
	modify
	cmpxchg

Notice that the cmpxchg-based case does _not_ get any worse - in fact
it's exactly identical.  Note, however, that the llsc case becomes
more efficient.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
