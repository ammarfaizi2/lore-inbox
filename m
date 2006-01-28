Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932547AbWA1Swd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbWA1Swd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 13:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbWA1Swd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 13:52:33 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:27657 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932547AbWA1Swc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 13:52:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nJjeNXAHu7Njn6HR9wCa65N9Yp17nktYJnOTRFJ9/T3hQ9evbfxhuviNg77bSPqNlpuIQ+HfFdCuZFPhQGp9HaMf9/YLPXnh32bvCj+M1LQ9ubsXXvCPErajxvBWJ8sehvrtPW/v69gmbv+j3tVr3g9fEaNBmhDy5bpekJ0SiPA=
Message-ID: <9a8748490601281052h56fe8dc9r511b450c46e353d1@mail.gmail.com>
Date: Sat, 28 Jan 2006 19:52:31 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] ide-tape: attempt to handle copy_*_user() failures [take two]
Cc: linux-kernel@vger.kernel.org, axboe@suse.de
In-Reply-To: <20060123000401.144e2ca2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200601222251.56185.jesper.juhl@gmail.com>
	 <20060123000401.144e2ca2.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/06, Andrew Morton <akpm@osdl.org> wrote:
> Jesper Juhl <jesper.juhl@gmail.com> wrote:
> >
> > Second attempt at this patch.
> >
> > (
> >  noticed a small flaw in my first patch, this should be better.
> >  also noticed that Gadi Oxman seems unable to recieve mail at the address
> >  listed in MAINTAINERS, so put a few other (hopefully relevant) people on
> >  Cc instead
> > )
> >
> >
> > Attempt to handle copy_*_user() failures in
> > drivers/ide/ide-tape.c::idetape_copy_stage_*_user
> >
> > drivers/ide/ide-tape.c:2663: warning: ignoring return value of opy_from_user', declared with attribute warn_unused_result
> > drivers/ide/ide-tape.c:2690: warning: ignoring return value of opy_to_user', declared with attribute warn_unused_result
> >
> > Due to lack of hardware I'm unfortunately not able to test this patch
> > beyond making sure it compiles.
> >
>
> Too scary for me.
>
Fair enough.

> > @@ -2669,26 +2671,30 @@ static void idetape_copy_stage_from_user
> >                       if (bh)
> >                               atomic_set(&bh->b_count, 0);
> >               }
> > +             if (not_copied)
> > +                     return not_copied;
> >       }
> >       tape->bh = bh;
> > +     return 0;
> >  }
>
> What are the effects of not updating tape->bh?
>
Ouch, I guess the effects would be the next access to the tape hitting
the same area as the last one - not good.
I don't know this code very intimately and this certainly looks like a
mistake on my part, so ignore the patch for now please.

I made the patch fully aware that I was not on very solid ground,
which is also why I didn't ask for "merge this please" and used the
"Attempt to handle .." language in the patch description - I was just
offering the patch for "here you are, see if it looks good" review.
The review turned up flaws, so for now the patch is dead (thank you
for looking at it though).

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
