Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266155AbUJVTUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266155AbUJVTUE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 15:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266175AbUJVTSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 15:18:01 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:20741 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S266155AbUJVTQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 15:16:43 -0400
Date: Fri, 22 Oct 2004 21:16:08 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, linux-net@vger.kernel.org
Subject: Re: 2.6.9-mm1: timer_event multiple definition
Message-ID: <20041022191608.GB22558@stusta.de>
References: <20041022032039.730eb226.akpm@osdl.org> <20041022135026.GC2831@stusta.de> <Pine.LNX.4.58.0410220812170.7868@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410220812170.7868@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 08:24:44AM -0700, Christoph Lameter wrote:
> On Fri, 22 Oct 2004, Adrian Bunk wrote:
> 
> >   LD      .tmp_vmlinux1
> > drivers/built-in.o(.text+0x30a210): In function `timer_event':
> > : multiple definition of `timer_event'
> > kernel/built-in.o(.text+0x16270): first defined here
> > ld: Warning: size of symbol `timer_event' changed from 157 in
> > kernel/built-in.o to 11 in drivers/built-in.o
> > make: *** [.tmp_vmlinux1] Error 1
> >
> > <--  snip  -->
> >
> >
> > I'd say drivers/net/skfp/queue.c is more at fault for using the pretty
> > generic timer_event name...
> 
> It built fine on my system ?!?.
>...


You don't have "SysKonnect FDDI PCI support" enabled in your .config?


That's what I wanted to say in my comment:


There's a name clash between two global `timer_event':
The one you introduced, and the one in drivers/net/skfp/queue.c .

I don't know whether `timer_event' is too generic for the use you 
introduced, but for the use in drivers/net/skfp/queue.c (which was 
already present) it seems too generic.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

