Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262621AbREOEfl>; Tue, 15 May 2001 00:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262622AbREOEfV>; Tue, 15 May 2001 00:35:21 -0400
Received: from bitmover.com ([207.181.251.162]:7200 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S262621AbREOEfR>;
	Tue, 15 May 2001 00:35:17 -0400
Date: Mon, 14 May 2001 21:35:16 -0700
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events
Message-ID: <20010514213516.A15744@work.bitmover.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Richard Gooch <rgooch@ras.ucalgary.ca>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200105142319.f4ENJpf19203@vindaloo.ras.ucalgary.ca> <Pine.LNX.4.21.0105142054180.23578-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0105142054180.23578-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, May 14, 2001 at 09:00:44PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2001 at 09:00:44PM -0700, Linus Torvalds wrote:
> Or rather, there is a fundamental reason why we must NEVER EVER look at
> the buffer cache: it is not coherent with the page cache. 

Not that Linus needs any backing up but Sun got rid of the buffer cache
and just had a page cache in SunOS 4.0, which was before I got there, I 
suspect something like 15 years ago.  It was a good move.  SunOS was 
an extremely pleasant place to work, all you had to understand was 
vnode,offset and you basically understood the VM system.

It is so _blindingly_ obvious that Linus is right, it's been proven,
you don't have to think about it, just read some history.

Hell, that's the OS that gave us mmap, remember that?  

> Really. Give it up. Your silly "make bootup faster" is not going to happen
> this way. You're trying to break some rather fundamental data structures,
> all for the unusual case of booting up. There are other ways to boot up
> quickly: look into pre-filling your memory image (aka "resume from disk"),

Which is pretty much what I have been asking for, in a general way, for
a long time.  I've wanted "directory clustering" forever, where you read
one file, read the next, and go into "file readahead mode" wherein you
slurp in the entire directories worth of files in one I/O.  If we had
that, not only would we go faster in general, you could easily tweak it
slightly for the fast bootup.  

> You know, the mark of intelligence is realizing when you're making the
> same mistake over and over and over again, and not hitting your head in
> the wall five hundred times before you understand that it's not a clever
> thing to do.
> 
> Please show some intelligence.

Those who don't learn from history are doomed to repeat it, eh?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
