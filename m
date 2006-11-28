Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756883AbWK1Xm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756883AbWK1Xm3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 18:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757958AbWK1Xm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 18:42:29 -0500
Received: from wr-out-0506.google.com ([64.233.184.238]:29333 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1756883AbWK1Xm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 18:42:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JAL/mcQxrb24lMPmLwPYeJtY+dJdnuK1RcbbmPe9hkbs4gBJxcuGZcEVOVOr6H3jwfNHWrm7/tCwSX2F5GIeCEe5oUuyflmas6PLOqvTwgW9hpxw/o3D2jrzhlkqkGmcNYk/lS837GagVE8QkKQu9qlanzjuq/bSDYJJBt4IjmE=
Message-ID: <9a8748490611281542l2b05ab78kef8247b04f8c5389@mail.gmail.com>
Date: Wed, 29 Nov 2006 00:42:28 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: [PATCH] Don't compare unsigned variable for <0 in sys_prctl()
Cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>,
       trivial@kernel.org
In-Reply-To: <Pine.LNX.4.64.0611281459331.4244@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200611282317.14020.jesper.juhl@gmail.com>
	 <Pine.LNX.4.64.0611281425220.4244@woody.osdl.org>
	 <9a8748490611281434g3741045v5e7f952f633e08d3@mail.gmail.com>
	 <Pine.LNX.4.64.0611281459331.4244@woody.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Tue, 28 Nov 2006, Jesper Juhl wrote:
> >
> > > Friends don't let friends use "-W".
> >
> > Hehe, ok, I'll stop cleaning this stuff up then.
> > Nice little hobby out the window there ;)
>
> You might want to look at some of the other warnings gcc spits out, but
> this class isn't one of them.
>
> Other warnings we have added over the years (and that really _are_ good
> warnings) have included the "-Wstrict-prototypes", and some other ones.
>
> If you can pinpoint _which_ gcc warning flag it is that causes gcc to emit
> the bogus ones, you _could_ try "-W -Wno-xyz-warning", which should cause
> gcc to enable all the "other" warnings, but then not the "xyz-warning"
> that causes problems.
>
> Of course, there is often a reason why a warning is in "-W" but not in
> "-Wall". Most of the time it's sign that the warning is bogus. Not always,
> though - we do tend to want to be fairly strict, and Wstrict-prototypes is
> an example of a _good_ warning that is not in -Wall.
>

I would venture that "-Wshadow" is another one of those.  I've, in the
past, submitted quite a few patches to clean up shadow warnings (some
accepted, some not) and I'll probably try going down that path again
in the near future.  It's a class of warnings that have the potential
to uncover real bugs (even if we don't currently have any) and it
would be a nice one to be able to enable by default in the Makefile.

I agree with you though that the "expression always false|true due to
unsigned" type of warnings are usually bogus - although there have
actually been real bugs hiding behind some of those warnings in the
past.  But, I'll make sure to only submit patches for that type of
warnings in the future if I can prove that the warning actually
uncovered a real bug.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
