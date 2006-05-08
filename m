Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbWEHIeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWEHIeb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 04:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWEHIe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 04:34:29 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:15960 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932366AbWEHIe0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 04:34:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=KaZINzdCeMGboxITa4XTouhOeGwyd/tk8BSaCrjxaA1kKXYgKdevNH+gyc7YwctcB4mSbkCri3cXogaqLAGEGCd6OFdC2rGO019K4IBjgzznYbCvFtz2KPH1JNafLStjMmtFQGPQzSP5+XYdteT7lCWYQ5HAbIu29swbq/YFw9E=
Message-ID: <84144f020605080134q7e16f37fl385359c634ece8ca@mail.gmail.com>
Date: Mon, 8 May 2006 11:34:25 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: [PATCH] fs: fcntl_setlease defies lease_init assumptions
Cc: "Daniel Hokka Zakrisson" <daniel@hozac.com>, linux-kernel@vger.kernel.org,
       "=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>,
       greg@kroah.com, matthew@wil.cx
In-Reply-To: <84144f020605080131r58ce2a93w6c7ba784a266bbeb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <445E80DD.9090507@hozac.com>
	 <Pine.LNX.4.64.0605072030280.3718@g5.osdl.org>
	 <84144f020605080131r58ce2a93w6c7ba784a266bbeb@mail.gmail.com>
X-Google-Sender-Auth: a250f837e636db98
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/06, Linus Torvalds <torvalds@osdl.org> wrote:
> > Ok, I was actually really surprised that we'd ever allow a non-slab page
> > to be free'd as a slab or kmalloc allocation, without screaming very
> > loudly indeed. That implies a lack of some pretty fundamental sanity
> > checking by default in the slab layer (I suspect slab debugging turns it
> > on, but even without it, that's just nasty).
> >
> > Can you see if this trivial patch at least causes a honking huge
> > "kernel BUG" message to be triggered quickly?

On 5/8/06, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> page_get_cache and page_get_slab are too late. You would need to do
> the check in __cache_free; otherwise the stack pointer goes to per-CPU
> caches and can be given back by kmalloc(). Adding PageSlab debugging
> to __cache_free is probably too much of a performance hit, though.

Btw, CONFIG_DEBUG_SLAB should catch this case, see kfree_debugcheck()
for details.

                                                  Pekka
