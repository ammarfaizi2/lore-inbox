Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbUK0RAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbUK0RAK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 12:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbUK0Q6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 11:58:39 -0500
Received: from inx.pm.waw.pl ([195.116.170.20]:21377 "EHLO inx.pm.waw.pl")
	by vger.kernel.org with ESMTP id S261264AbUK0Q6c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 11:58:32 -0500
To: Alexandre Oliva <aoliva@redhat.com>
Cc: Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       torvalds@osdl.org, hch@infradead.org, dwmw2@infradead.org,
       linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
References: <19865.1101395592@redhat.com>
	<orvfbtzt7t.fsf@livre.redhat.lsd.ic.unicamp.br>
	<20041125210137.GD2849@parcelfarce.linux.theplanet.co.uk>
	<ory8goygpr.fsf@livre.redhat.lsd.ic.unicamp.br>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 27 Nov 2004 17:12:38 +0100
In-Reply-To: <ory8goygpr.fsf@livre.redhat.lsd.ic.unicamp.br> (Alexandre
 Oliva's message of "26 Nov 2004 09:47:44 -0200")
Message-ID: <m31xef5kzt.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Oliva <aoliva@redhat.com> writes:

> How about moving the internals (i.e., what's not to be exported to
> userland) from linux and asm elsewhere, then?

That's what I proposed several {months,weeks} ago. From a technical
point of view it seems like a superior solution:

- /usr/include/{linux,asm} -> /usr/src/linux/include/{linux,asm} = no
  problems with kernel and userspace includes.
- while Linux is quite a big program, it is _one_ program = no need to
  patch the whole universe, only the kernel would need changing
  (of course broken userspace code would need fixing, but that's
  due to their brokeness and not due to the change).

> Sure, it means significantly more churn in the kernel, but there's
> going to be a lot of moving stuff around one way or the other.

No doubt. Still, quite simple automatic operation, we've seen much larger
patches.

API backward-compatibility (including C libs) is IMHO much more
important than just some kernel patch size (I realize ABI compatibility
would be preserved in all cases).

And we can do it anytime - no need for waiting for some libc change,
no need for waiting for "2.7/2.8".

> While at that, we could also split what's kernel internal for real and
> what's to be visible to external kernel modules as well.

Can't see benefits.
-- 
Krzysztof Halasa
