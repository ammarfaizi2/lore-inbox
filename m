Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbWEAI7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWEAI7j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 04:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWEAI7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 04:59:39 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:17682 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751309AbWEAI7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 04:59:39 -0400
Date: Mon, 1 May 2006 10:59:39 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] kernel/sys.c: possible cleanups
Message-ID: <20060501085939.GV3570@stusta.de>
References: <20060501071134.GH3570@stusta.de> <20060501001803.48ac34df.akpm@osdl.org> <20060501073514.GQ3570@stusta.de> <1146469146.20760.31.camel@laptopd505.fenrus.org> <20060501004925.36e4dd21.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060501004925.36e4dd21.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2006 at 12:49:25AM -0700, Andrew Morton wrote:
> Arjan van de Ven <arjan@infradead.org> wrote:
> >
> > > If removing exports requires a process, adding exports requires a 
> >  > similar process.
> > 
> >  alternatively we should bite the bullet, and just stick those 900 on the
> >  "we'll kill all these in 3 months" list, have a thing to disable them
> >  now via a config option (so that people actually notice rather than just
> >  having them in the depreciation file) and fix the 5 or 10 or so that
> >  actually will be used soon in those 3 months.
> > 
> 
> I'd instead suggest that we implement a new EXPORT_SYMBOL_UNEXPORT_SCHEDULED
> (?) and use that.  Suitable compile-time and modprobe-time warnings would
> be needed.  Put the unexport date in a comment at the
> EXPORT_SYMBOL_UNEXPORT_SCHEDULED site or even in the modprobe-time warning
> message, if that's convenient:
> 
> EXPORT_SYMBOL_UNEXPORT_SCHEDULED(foo, "Dec 2006");

__deprecated_for_modules already does everything required for compile 
time warnings.

No need to make the kernel image even bigger for unused stuff.

Looking over the patches I sent, this might affect perhaps 200 unused 
exports today.

So the work would expand to:
- writing 200 feature-removal-schedule.txt entries
- marking 200 functions and variables as __deprecated_for_modules

And in a few months:
- removing 200 feature-removal-schedule.txt entries
- removing 200 __deprecated_for_modules markers
- removing the 200 unused exports

But what do we gain by doing this extra work?
As I said in my other email, there is no good reason to not break 
external modules.

And this is reaching the point where I'm spending too much of the part 
of my spare time I'm devoting to Linux kernel development in following 
useless processes instead of doing something having a result making it 
worth spending my time for.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

