Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131984AbRAKOg1>; Thu, 11 Jan 2001 09:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132063AbRAKOgR>; Thu, 11 Jan 2001 09:36:17 -0500
Received: from mail2.digital.com ([204.123.2.56]:29961 "EHLO mail2.digital.com")
	by vger.kernel.org with ESMTP id <S131984AbRAKOgJ>;
	Thu, 11 Jan 2001 09:36:09 -0500
From: jg@pa.dec.com (Jim Gettys)
Date: Thu, 11 Jan 2001 06:36:01 -0800 (PST)
Message-Id: <200101111436.f0BEa1b26681@pachyderm.pa.dec.com>
X-Mailer: Pachyderm (client pachyderm.pa-x.dec.com, user jg)
To: Linus Torvalds <torvalds@transmeta.com>
cc: David Woodhouse <dwmw2@infradead.org>, Zlatko Calusic <zlatko@iskon.hr>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10101100858480.4283-100000@penguin.transmeta.com>
Subject: Re: Subtle MM bug
Mime-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Sender: linux-kernel-owner@vger.kernel.org
> From: Linus Torvalds <torvalds@transmeta.com>
> Date: 	Wed, 10 Jan 2001 09:03:03 -0800 (PST)
> To: David Woodhouse <dwmw2@infradead.org>
> Cc: Zlatko Calusic <zlatko@iskon.hr>,
>         "Eric W. Biederman" <ebiederm@xmission.com>,
>         Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
> Subject: Re: Subtle MM bug
> -----
> On Wed, 10 Jan 2001, David Woodhouse wrote:
> 
> >
> > torvalds@transmeta.com said:
> > >  The no-swap behaviour shoul dactually be pretty much identical,
> > > simply because both 2.2 and 2.4 will do the same thing: just skip
> > > dirty pages in the page tables because they cannot do anything about
> > > them.
> >
> > So the VM code spends a fair amount of time scanning lists of pages which
> > it really can't do anything about?
> 
> It can do _tons_ of stuff.
> 
> Remember, on platforms like this, one of the reasons for being low on
> memory is things like running X and netscape: maybe you have 64MB of RAM
> and you don't think you need a swap device, and you want to have a web
> browser.
> 
> The fact that we cannot touch _dirty_ pages doesn't mean that there's
> nothing to do: instead of running out of memory we can at least make the
> machine usable by dropping the text pages and the page cache..
> 

And pushing out old text pages is a very good idea on most embedded systems.
Getting the pages back is a (relatively) cheap operation: no disk seeks,
some joules spent on decompression (if on CRAMFS or other compressed file
system).

There is an interesting question on such devices as to whether you are
better off dropping text pages or pages out of the page cache first,
or to what degree... 
				- Jim

--
Jim Gettys
Technology and Corporate Development
Compaq Computer Corporation
jg@pa.dec.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
