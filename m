Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265848AbTGLOvl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 10:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265853AbTGLOvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 10:51:41 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:29640 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S265848AbTGLOvh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 10:51:37 -0400
Date: Sun, 13 Jul 2003 02:55:23 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: Thoughts wanted on merging Software Suspend enhancements
In-reply-to: <20030712140057.GC284@elf.ucw.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1058021722.1687.16.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1057963547.3207.22.camel@laptop-linux>
 <20030712140057.GC284@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't ask me why I'm awake at 3am. I don't know.

On Sun, 2003-07-13 at 02:00, Pavel Machek wrote:
> Hi!
> 
> > Hi Linus.
> >
> 
> Well, you probably did want Linus to answer, but I see some new stuff
> here.

Yeah, I did. But it wasn't going to happen :>

> > - save a full image rather than freeing just about all the memory first
> > - highmem support
> > - image compression support
> > - swapfile support in progress
> 
> This seems extremely hard to do right. If you can do it right and not
> rewrite half of kernel, that's okay, but I don't think you can do that.

I assume you mean swapfile only. The first two have been working for a
while now. For swapfile support, my approach is simple. I'll store the
info rw_swap_page_base calculates and save it in the pagedir, using it
to read back the data at resume without requiring any knowledge of the
filesystem. (Of course I'm assuming the data isn't compressed etc but
since swapfiles work, this seems to be a reasonable assumption; I can
always mirror changes in the swapfile code). I'll also take advantage of
the fact that much of the pagedir data we're storing is very easily
compressable itself to ensure that this doesn't result in severe bloat
of the pagedirs. I've already got a little patch to test it the theory,
and results look very encouraging but I won't try to explain it here.
I'll just confuse the issue.

> > - nice display
> > - user can abort at any time during suspend (oh, I forgot, I wanted
> > to...) by just pressing Escape
> 
> That seems like missfeature. We don't want joe random user that is at
> the console to prevent suspend by just pressing Escape. Maybe magic
> key to do that would be acceptable...

Magic key? Do you mean a password? I suppose that could be a
configuration option. I for one love being able to just press escape
when I realise there was something I wanted to do before I shut the
computer down, and I'll bet there'll be tons of people who think the
same way. I could certainly go for a password option. The only question
would be, how to configure the password. Perhaps a root-only proc entry?

Regards,

Nigel

-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.

