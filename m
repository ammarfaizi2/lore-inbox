Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263118AbREWPCP>; Wed, 23 May 2001 11:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263119AbREWPCG>; Wed, 23 May 2001 11:02:06 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:13319 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S263118AbREWPCC>; Wed, 23 May 2001 11:02:02 -0400
Date: Wed, 23 May 2001 10:25:06 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Rik van Riel <riel@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: write drop behind effect on active scanning
In-Reply-To: <0105231633440L.06233@starship>
Message-ID: <Pine.LNX.4.21.0105231022060.1874-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 23 May 2001, Daniel Phillips wrote:

> On Wednesday 23 May 2001 09:33, Marcelo Tosatti wrote:
> > Hi,
> >
> > I just noticed a "bad" effect of write drop behind yesterday during
> > some tests.
> >
> > The problem is that we deactivate written pages, thus making the
> > inactive list become pretty big (full of unfreeable pages) under
> > write intensive IO workloads.
> >
> > So what happens is that we don't do _any_ aging on the active list,
> > and in the meantime the inactive list (which should have "easily"
> > freeable pages) is full of locked pages.
> >
> > I'm going to fix this one by replacing "deactivate_page(page)" to
> > "ClearPageReferenced(page)" in generic_file_write(). This way the
> > written pages are aged faster but we avoid the bad effect just
> > described.
> >
> > Any comments on the fix ?
> 
>   page->age = 0 ?

That would make any full scan through the active list move all dropped
pages from generic_file_write() to the inactive list.

