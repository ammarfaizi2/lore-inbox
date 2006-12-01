Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031279AbWLAMzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031279AbWLAMzA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 07:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031322AbWLAMzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 07:55:00 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:42247 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1031279AbWLAMy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 07:54:59 -0500
Date: Fri, 1 Dec 2006 13:55:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: please pull from the trivial tree
Message-ID: <20061201125504.GC11084@stusta.de>
References: <20061201113740.GP11084@stusta.de> <Pine.LNX.4.63.0612011329130.3090@fink.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612011329130.3090@fink.physik3.uni-rostock.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 01:41:18PM +0100, Tim Schmielau wrote:
> > Chase Venters (1):
> >       Fix jiffies.h comment
> 
> This one actually obscures the comment rather than fixing it.
> 
> >From jiffies.h:
> > 76 /*
> > 77  * The 64-bit value is not volatile - you MUST NOT read it
> > 78  * without sampling the sequence number in xtime_lock.
> > 79  * get_jiffies_64() will do this for you as appropriate.
> > 80  */
> > 81  extern u64 __jiffy_data jiffies_64;
> > 82  extern unsigned long volatile __jiffy_data jiffies;
> 
> Note that jiffies is volatile, while jiffies_64 is not; the comment 
> currently explains that. The proposed patch
> 
> > Fix jiffies.h comment
> > jiffies.h includes a comment informing that jiffies_64 must be read with the
> > assistance of the xtime_lock seqlock. The comment text, however, calls
> > jiffies_64 "not volatile", which should probably read "not atomic".
> > 
> > --- a/include/linux/jiffies.h
> > +++ b/include/linux/jiffies.h
> > @@ -74,7 +74,7 @@
> > #define __jiffy_data __attribute__((section(".data")))
> > /*
> > - * The 64-bit value is not volatile - you MUST NOT read it
> > + * The 64-bit value is not atomic - you MUST NOT read it
> > * without sampling the sequence number in xtime_lock.
> > * get_jiffies_64() will do this for you as appropriate.
> > */
> 
> would leave a comment that is correct, but less useful (I'd expect any 
> kernel hacker to know that u64 is non-atomic on many platforms).


If kernel hackers are expected to already know it's non-atomic we could 
remove the whole comment.

The comment regarding "volatile" was bogus since "volatile" wouldn't 
help against getting garbage when reading an u64 variable.


> Tim

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

