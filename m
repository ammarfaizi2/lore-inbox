Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129780AbRAVDKj>; Sun, 21 Jan 2001 22:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130405AbRAVDKa>; Sun, 21 Jan 2001 22:10:30 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:3086 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129780AbRAVDKO>; Sun, 21 Jan 2001 22:10:14 -0500
Date: Sun, 21 Jan 2001 23:20:13 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Rik van Riel <riel@conectiva.com.br>
cc: Vlad Bolkhovitine <vladb@sw.com.sg>, linux-kernel@vger.kernel.org
Subject: Re: mmap()/VM problem in 2.4.0
In-Reply-To: <Pine.LNX.4.31.0101191117460.3368-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0101212224001.7440-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 19 Jan 2001, Rik van Riel wrote:

> On Thu, 18 Jan 2001, Marcelo Tosatti wrote:
> > On Thu, 18 Jan 2001, Rik van Riel wrote:
> > > On Fri, 12 Jan 2001, Vlad Bolkhovitine wrote:
> > >
> > > > You can see, mmap() read performance dropped significantly as
> > > > well as read() one raised. Plus, "interactivity" of 2.4.0 system
> > > > was much worse during mmap'ed test, than using read()
> > > > (everything was quite smooth here). 2.4.0-test7 was badly
> > > > interactive in both cases.
> > >
> > > Could have to do with page_launder() ... I'm working on
> > > streaming mmap() performance here and have been working
> > > on this for a week now (amongst other things).
> >
> > Also remember that drop_behind() is not working for mmap(), yet...
> 
> filemap_sync(..., MS_INVALIDATE) needs a 2-line change to have
> drop-behind. I have this running (more or less) on my laptop here.

The filemap_sync() modifications on your patch makes msync
(MS_SYNC|MS_INVALIDATE) not work correctly anymore. filemap_sync() must
set the page dirty for all valid pte's in the requested area if MS_SYNC is
set.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
