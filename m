Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315042AbSE2L3v>; Wed, 29 May 2002 07:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315091AbSE2L3u>; Wed, 29 May 2002 07:29:50 -0400
Received: from [195.39.17.254] ([195.39.17.254]:25757 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S315042AbSE2L3t>;
	Wed, 29 May 2002 07:29:49 -0400
Date: Wed, 29 May 2002 13:21:37 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: Steve Whitehouse <Steve@ChyGwyn.com>,
        linux kernel <linux-kernel@vger.kernel.org>, alan@lxorguk.ukuu.org.uk,
        chen_xiangping@emc.com
Subject: Re: Kernel deadlock using nbd over acenic driver
Message-ID: <20020529112137.GA397@elf.ucw.cz>
In-Reply-To: <20020527134413.E35@toy.ucw.cz> <200205291051.g4TApEC24775@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Look in some of the block drivers, floppy.c or loop.c.  These do call
> > > the task queue, even though that's only as an aid to the rest of the
> > > kernel, because they know they can help at that point, and it's not at
> > > all clear what context they're in.  Perhaps it's best to look in
> > > floppy.c, which runs the task queue in its init routine!  I mean to say
> > 
> > Init routine is called from insmod context or at kernel bootup (from pid==1).
> 
> That's nitpicking!  

I did not want to be nitpicking. init() really is considered process
context, and it looks to me like unplug is *blocking* operation so it
really needs proceess context.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
