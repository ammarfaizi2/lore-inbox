Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265931AbTGLPWu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 11:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265966AbTGLPWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 11:22:50 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:2793 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S265931AbTGLPWt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 11:22:49 -0400
Date: Sat, 12 Jul 2003 17:37:19 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Thoughts wanted on merging Software Suspend enhancements
Message-ID: <20030712153719.GA206@elf.ucw.cz>
References: <1057963547.3207.22.camel@laptop-linux> <20030712140057.GC284@elf.ucw.cz> <1058021722.1687.16.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058021722.1687.16.camel@laptop-linux>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Don't ask me why I'm awake at 3am. I don't know.

;-). Its 5pm here...

> > Well, you probably did want Linus to answer, but I see some new stuff
> > here.
> 
> Yeah, I did. But it wasn't going to happen :>

Well, Linus just tends to drop the mail. [Killed him from Cc].

> > > - save a full image rather than freeing just about all the memory first
> > > - highmem support
> > > - image compression support
> > > - swapfile support in progress
> > 
> > This seems extremely hard to do right. If you can do it right and not
> > rewrite half of kernel, that's okay, but I don't think you can do that.
> 
> I assume you mean swapfile only. The first two have been working for a
> while now. For swapfile support, my approach is simple. I'll store the
> info rw_swap_page_base calculates and save it in the pagedir, using it
> to read back the data at resume without requiring any knowledge of the
> filesystem. (Of course I'm assuming the data isn't compressed etc but
> since swapfiles work, this seems to be a reasonable assumption; I can
> always mirror changes in the swapfile code). I'll also take advantage of
> the fact that much of the pagedir data we're storing is very easily
> compressable itself to ensure that this doesn't result in severe bloat
> of the pagedirs. I've already got a little patch to test it the theory,
> and results look very encouraging but I won't try to explain it here.
> I'll just confuse the issue.

Okay, that's sane approach to do it... But where do you store pointer
to pagedir?

> > > - nice display
> > > - user can abort at any time during suspend (oh, I forgot, I wanted
> > > to...) by just pressing Escape
> > 
> > That seems like missfeature. We don't want joe random user that is at
> > the console to prevent suspend by just pressing Escape. Maybe magic
> > key to do that would be acceptable...
> 
> Magic key? Do you mean a password? I suppose that could be a

Documentation/sysrq.txt. Magic sysrq driver will answer some
interesting questions like "how to press esc on the serial line", etc,
and it is also /proc configurable.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
