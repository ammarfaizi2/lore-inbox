Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289803AbSBEUcT>; Tue, 5 Feb 2002 15:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289806AbSBEUcJ>; Tue, 5 Feb 2002 15:32:09 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:18700 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP
	id <S289803AbSBEUb7>; Tue, 5 Feb 2002 15:31:59 -0500
Message-ID: <00c301c1ae83$fc92ea40$760010ac@edumazet>
From: "Eric Dumazet" <eric.dumazet@cosmosbay.com>
To: "Rik van Riel" <riel@conectiva.com.br>, "Pavel Machek" <pavel@suse.cz>
Cc: "Jeff Garzik" <garzik@havoc.gtf.org>, <arjan@fenrus.demon.nl>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0202051644340.12225-100000@duckman.distro.conectiva>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
Date: Tue, 5 Feb 2002 21:30:05 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 5 Feb 2002, Pavel Machek wrote:
>
> > > > > the biggest reason for this is that we *suck* at readahead for
mmap....
> > > >
> > > > Is there not also fault overhead and similar issues related to
mmap(2)
> > > > in general, that are not present with read(2)/write(2)?
> > >
> > > If a fault is more expensive than a system call, we're doing
> > > something wrong in the page fault path ;)
> >
> > You can read 128K at a time, but you can't fault 128K...
>
> Why not ?
>
> If the pages are present (read-ahead) and the page table
> is present, I see no reason why we couldn't fill in 32
> page table entries at once.
>
> Rik

Well, filling 32 page tables entries at once is certainly a big readahead...
for the common cases.

Maybe this high number could be a result of a madavise(..., MADV_SEQUENTIAL
or MAP_WILLNEED)
Solaris does exactly this kind of trick.

Eric


