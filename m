Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbWEHIbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWEHIbc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 04:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWEHIbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 04:31:32 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:22614 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932303AbWEHIbb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 04:31:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=g1z9FUTLF/cgB2egV3x5CRtN2jvT0pemJBAmRU/i7D20X1x3JMIn9Qao4k3oREn8rh/s9EqtVv0N1+/IiPY3oAx1TzyEL4LdOIa13roZ9A4pQik6J7qLwa0ZZAHuD7ME9qskm4kF5M5Y1VboQhKQZwNN3hXU9usCH5CUQ6j05QY=
Message-ID: <84144f020605080131r58ce2a93w6c7ba784a266bbeb@mail.gmail.com>
Date: Mon, 8 May 2006 11:31:30 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: [PATCH] fs: fcntl_setlease defies lease_init assumptions
Cc: "Daniel Hokka Zakrisson" <daniel@hozac.com>, linux-kernel@vger.kernel.org,
       "=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>,
       greg@kroah.com, matthew@wil.cx
In-Reply-To: <Pine.LNX.4.64.0605072030280.3718@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <445E80DD.9090507@hozac.com>
	 <Pine.LNX.4.64.0605072030280.3718@g5.osdl.org>
X-Google-Sender-Auth: d1b5a0829b2320e9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 5/8/06, Linus Torvalds <torvalds@osdl.org> wrote:
> Ok, I was actually really surprised that we'd ever allow a non-slab page
> to be free'd as a slab or kmalloc allocation, without screaming very
> loudly indeed. That implies a lack of some pretty fundamental sanity
> checking by default in the slab layer (I suspect slab debugging turns it
> on, but even without it, that's just nasty).
>
> Can you see if this trivial patch at least causes a honking huge
> "kernel BUG" message to be triggered quickly?

page_get_cache and page_get_slab are too late. You would need to do
the check in __cache_free; otherwise the stack pointer goes to per-CPU
caches and can be given back by kmalloc(). Adding PageSlab debugging
to __cache_free is probably too much of a performance hit, though.

                                         Pekka
