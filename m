Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262000AbUKJCc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbUKJCc3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 21:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbUKJCc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 21:32:29 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:26129 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262001AbUKJCar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 21:30:47 -0500
Date: Wed, 10 Nov 2004 03:30:15 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kill IN_STRING_C
Message-ID: <20041110023015.GF4089@stusta.de>
References: <20041107142445.GH14308@stusta.de> <20041108134448.GA2456@wotan.suse.de> <20041108153436.GB9783@stusta.de> <200411091458.35134.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411091458.35134.arnd@arndb.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 02:58:34PM +0100, Arnd Bergmann wrote:
> > On Mon, Nov 08, 2004 at 02:44:49PM +0100, Andi Kleen wrote:
> > 
> > > > Can you still reproduce this problem?
> > > > If not, I'll suggest to apply the patch below which saves a few kB in 
> > > > lib/string.o .
> > > 
> > > I would prefer to keep it because there is no guarantee in gcc
> > > that it always inlines all string functions unless you pass
> > > -minline-all-stringops. And with that the code would
> > > be bloated much more than the few out of lined fallback
> > > string functions.
> > 
> > If I understand your changelog entry correctly, this wasn't the problem
> > (the asm string functions are "static inline").
> 
> Actually, shouldn't the string functions be "extern inline" then?
> That would mean we use the copy from lib/string.c instead of generating
> a new copy for each file in which gcc decides not to inline the function.
>...

In the kernel, we #define inline to __attribute__((always_inline)) [1]
leaving gcc no room for a decision to not inline it.

> 	Arnd <><

cu
Adrian

[1] only for gcc >= 3.1, but I don't remember problems with older gcc 
    versions

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

