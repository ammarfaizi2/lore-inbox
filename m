Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965005AbWEOUCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbWEOUCm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 16:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbWEOUCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 16:02:41 -0400
Received: from ns1.suse.de ([195.135.220.2]:27859 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965005AbWEOUCl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 16:02:41 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] x86 NUMA panic compile error
Date: Mon, 15 May 2006 22:02:30 +0200
User-Agent: KMail/1.9.1
Cc: mingo@elte.hu, haveblue@us.ibm.com, apw@shadowen.org,
       linux-kernel@vger.kernel.org
References: <20060515005637.00b54560.akpm@osdl.org> <200605152147.02232.ak@suse.de> <20060515125906.5c7af5ac.akpm@osdl.org>
In-Reply-To: <20060515125906.5c7af5ac.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605152202.31277.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 May 2006 21:59, Andrew Morton wrote:

> > On Monday 15 May 2006 21:39, Andrew Morton wrote:
> > > Ingo Molnar <mingo@elte.hu> wrote:
> > > >
> > > > Nevertheless for hard-to-debug bugs i prefer if they can be reproduced 
> > > > and debugged on 32-bit too, because x86_64 debugging is still quite a 
> > > > PITA and wastes alot of time: for example it has no support for exact 
> > > > kernel stacktraces. Also, the printout of the backtrace is butt-ugly and 
> > > > as un-ergonomic to the human eye as it gets
> > > 
> > > Yes, I find x86_64 traces significantly harder to follow.  And I miss the
> > > display of the length of the functions (do_md_run+1208 instead of
> > > do_md_run+1208/2043).  The latter form makes it easier to work out
> > > whereabouts in the function things happened.
> > > 
> > > That, plus the mix of hex and decimal numbers..
> > > 
> > > > who came up with that 
> > > > "two-maybe-one function entries per-line" nonsense? [Whoever did it he 
> > > > never had to look at (and make sense of) hundreds of stacktraces in a 
> > > > row.]
> > > 
> > > Plus they're wide enough to get usefully wordwrapped when someone mails
> > > them to you.
> > 
> > Hmm, I didn't realize they were _that_ unpopular. If you got the i386 
> > like space wasting backtraces would you guys all switch your development machines
> > to x86-64 ? @)
> > 
> 
> Developers use serial consoles for such things.  (I discovered
> `console=uart,...' yesterday.  It works nicely as an earlyprintk on ia64..)

I can also recommend firescope + firewire cards. It's not early
yet, but I hope eventually. But it can work without the target still
being alive and also does on most laptops.
 
> It's reports-from-the-field which are the problem.

In my experience the biggest problem in the field is that most 
of it scrolls away. That is why I tweaked the x86-64 format to be as space
efficient as possible. That's also why the "executive summary" was added.

But Ingo has a point that it usually doesn't help anyways because backtraces
tend to be so overlong now after the code got through 20 callbacks before
it can do something actually useful.


> A lot of these problems can be address by simple cranking up the VGA screen
> resolution, but I discovered that I don't know how to do that - I've always
> used `vga=extended', but that doesn't work on an EFI-booted ia64 box.
> 
> Does anyone know what the magic option is to make the vga console use 50
> rows?

I use vga=0x0f07

It's a butt ugly font, but it's the smallest I could find without using
the slow fbcon.

If you can't remember the hex number use vga=ask

-Andi

