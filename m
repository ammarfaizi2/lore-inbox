Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290344AbSBFJCx>; Wed, 6 Feb 2002 04:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290356AbSBFJCo>; Wed, 6 Feb 2002 04:02:44 -0500
Received: from dsl-213-023-043-188.arcor-ip.net ([213.23.43.188]:15793 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S290344AbSBFJCd>;
	Wed, 6 Feb 2002 04:02:33 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>, Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
Date: Wed, 6 Feb 2002 10:07:02 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Jeff Garzik <garzik@havoc.gtf.org>, <arjan@fenrus.demon.nl>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0202051644340.12225-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0202051644340.12225-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16YO2g-0002Mq-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 5, 2002 07:45 pm, Rik van Riel wrote:
> On Tue, 5 Feb 2002, Pavel Machek wrote:
> > > > > the biggest reason for this is that we *suck* at readahead for
> > > > > mmap....
> > > >
> > > > Is there not also fault overhead and similar issues related to mmap(2)
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

Yes, essentially what you want is to schedule a generic_file_readahead, which 
we'd need to cook up a mechanism for doing.  The other part - much harder - 
is deciding when to readahead, and how much.

I'd amend your original statement to just 'we *suck* at readahead'.

-- 
Daniel
