Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315441AbSEVOpB>; Wed, 22 May 2002 10:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315540AbSEVOnk>; Wed, 22 May 2002 10:43:40 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:27660 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S315528AbSEVOmf>; Wed, 22 May 2002 10:42:35 -0400
Date: Wed, 22 May 2002 16:42:36 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@zip.com.au>,
        Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: AUDIT: copy_from_user is a deathtrap.
Message-ID: <20020522144236.GA2357@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020522141306.GB29028@atrey.karlin.mff.cuni.cz> <E17AXVZ-0001up-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > In such case, linus, here is your "reasonable" example. For PPro, it
> > is faster to copy out-of-order, and if we wanted to use that for
> > copy_to_user, you'd have your example.
> 
> I think there is a misunderstanding here.
> 
> Nothing in the standards says that
> 
> 	write(pipe_fd, halfmappedbuffer, 2*PAGE_SIZE)
> 
> 
> must return PAGE_SIZE on an error. What it seems to say is that it if an error
> is reported then no data got written down the actual pipe itself. Putting
> 4K into the pipe then reporting Esomething is not allowed. Copying 4K into
> a buffer faulting and erroring with Efoo then throwing away the buffer is
> allowed

So... Is copy_to_user allowed to copy more than it actually reported?
Because if so, it might return 0/-EFAULT as well ;-).

									Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
