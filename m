Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRAYWyj>; Thu, 25 Jan 2001 17:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129143AbRAYWy3>; Thu, 25 Jan 2001 17:54:29 -0500
Received: from hermes.mixx.net ([212.84.196.2]:263 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129051AbRAYWyO>;
	Thu, 25 Jan 2001 17:54:14 -0500
Message-ID: <3A70AE0A.2A1C60E4@innominate.de>
Date: Thu, 25 Jan 2001 23:51:54 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
In-Reply-To: <3A5B61F7.FB0E79C1@innominate.de> <Pine.LNX.4.31.0101171942550.31432-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Tue, 9 Jan 2001, Daniel Phillips wrote:
> > Linus Torvalds wrote:
> > > (This is why I worked so hard at getting the PageDirty semantics right in
> > > the last two months or so - and why I released 2.4.0 when I did. Getting
> > > PageDirty right was the big step to make all of the VM stuff possible in
> > > the first place. Even if it probably looked a bit foolhardy to change the
> > > semantics of "writepage()" quite radically just before 2.4 was released).
> >
> > On the topic of writepage, it's not symmetric with readpage at
> > the moment - it still takes (struct file *).  Is this in the
> > cleanup pipeline?  It looks like nfs_readpage already ignores
> > the struct file *, but maybe some other net filesystems are
> > still depending on it.
> 
> writepage() and readpage() will never be symmetric...
> 
> readpage()
>         program can't continue until data is there
>         reading in larger clusters eats (wastes?) more memory
>         done when we think a process needs data
> 
> writepage()
>         called after the process has written data and moved on
>         writing larger clusters has no influence on memory use
>         often done to free up memory
> 
> Since readpage() needs to tune readahead behaviour, we will
> always want to give it some information (eg. in the file *)
> so it can do the extra things it needs to do.

Which extra information did you have in mind?

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
