Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264311AbTDWXqP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 19:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264312AbTDWXqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 19:46:15 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:27404 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264311AbTDWXqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 19:46:13 -0400
Date: Thu, 24 Apr 2003 01:58:20 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Nigel Cunningham <ncunningham@clear.net.nz>,
       Marc Giger <gigerstyle@gmx.ch>, Pavel Machek <pavel@ucw.cz>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Fix SWSUSP & !SWAP
Message-ID: <20030423235820.GB32577@atrey.karlin.mff.cuni.cz>
References: <1051136725.4439.5.camel@laptop-linux> <1584040000.1051140524@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584040000.1051140524@flay>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> Ok! I see the advantages / disadvantages of each version. But what
> >> happens if the memory AND swap space are full and nothing can't be
> >> freed? When I watch the memory and swap consumption on my laptop, I
> >> think it's the most time the case...
> > 
> > If you're getting yourself in that situation, you should be increasing
> > your swap space (and memory if possible) anyway.
> > 
> >> Another question:
> >> Is it a big problem to save the memory in a separate file on the file
> >> system, and save somewhere the pointer to it (as example in swap. Also
> >> we could set a flag in swap so that we now that the last shutdown was
> >> a hybernation). One Problem will be, that we don't know the filesystem
> >> type on resume...(We could save the module in swap...)
> >> All that is just theoretical. It's only a idea.
> > 
> > I guess the simplest answer is would it be worth the pain? Since disk
> > space is cheap, it just requires a little forethought when installing
> > Linux, to ensure enough swap is allocated. I certainly understand that
> > using a file rather than swap makes adjusting the amount of space
> > available easier, but as you rightly acknowledge, it does complicate
> > things a fair bit more.
> 
> Can't you just create a pre-reserved separate swsusp area on disk the size 
> of RAM (maybe a partition rather than a file to make things easier), and 
> then you know you're safe (basically what Marc was suggesting, except pre-allocated)? Or does that make me the prince of all evil? ;-)
> 
> However much swap space you allocate, it can always all be used, so that
> seems futile ...

Well, but if all the swaps gets used, you go OOM and randomly kill
processes. That means that machines have way more swap than they need.

If you really want to "solve" it reliably, you can always

swapon /dev/hdfoo666

where hdfoo666 is as big as ram, just before starting swsusp. We could
even make swapon part of swsusp where its locked to kill races.

But I believe its not needed. Problem just is not there in practise.


							Pavel 

-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
