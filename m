Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264930AbUBONtK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 08:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264933AbUBONtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 08:49:10 -0500
Received: from gizmo10bw.bigpond.com ([144.140.70.20]:59291 "HELO
	gizmo10bw.bigpond.com") by vger.kernel.org with SMTP
	id S264930AbUBONtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 08:49:02 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.24 Paging Fault, Cache tries to swap with no swap partition
Date: Sun, 15 Feb 2004 23:49:36 +1000
User-Agent: KMail/1.5.1
References: <200402150306.35704.ross@datscreative.com.au> <200402142233.23740.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200402142233.23740.vda@port.imtp.ilyichevsk.odessa.ua>
Cc: vda@port.imtp.ilyichevsk.odessa.ua
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402152349.36136.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 February 2004 06:33, you wrote:
> On Saturday 14 February 2004 19:06, Ross Dickson wrote:
> > I have an imaging system writing files to removable hard drives.
> > Compact Flash boot with ram drives so I usually have no swap partition or
> > file.
> >
> > Recently I upgraded kernel from 2.4.20 to 2.4.24.
> >
> > System has "mem=460M" (512M ram fitted) and starts with about
> > 400M free. After recording for a while the Cached ram acquires all
> > but about 4Mb MemFree.
> >
> > On a hot 38C day it started Oops'ing re paging memory. It runs the
> 
> Too vague.
> Do you have any logging? At least a circular buffer? Anything?

Unfortunately not much, I was hot, tired, not at my best - should have
grabbed it when I had the chance. All I grabbed was a partial code string
at the bottom of the  Oops which I doubt is of any benefit without the rest.
8b 5f 04 8d 77 08 83 eb 18 8b
Oh yeah, it killed init too. 
System defaults to not logging to permanent storage, flash would die over
time from writes and info would be meaningless to customer on their removable
hard drive. Note to self - must change that - I'm sure customer could spare some
space. 

I assumed I could reproduce the fault today if but it wouldn't fault.
First misbehaved Friday 13th, reproduced Sat 14th.
Self cured??? Sunday 15th. Doh!!!

> 
> > same 2 programs all day gathering and compressing images.
> > Sorry I have no detail on the Oops at the moment, computer is in a vehicle
> > and does not normally have a screen. From memory it couldn't allocate a
> > virtual page.
> >
> > I found if I put in a 16Mb ram drive as swap then it would grab
> > roughly 1.4Mb of it on occasion and keep it until recording stopped
> > for a while. SwapCached is either 0Kb or 1024Kb, not anything else.
> 
> If swap is active, some of it may be used even when box is not
> heavily loaded. That's normal.
> 
> > Is this behaviour expected - to require a swap file?
> 
> No.
> 
> > Can the paging cache be tuned in /proc or somewhere to prevent it being so
> > greedy as to want more memory than the machine has?
> 
> Maybe. But you should concentrate on finding where exactly it oopsed.

I note memfree stabilises at around 4Mb when running OK, given it only wanted
an extra 1Mb cache swap, can I cat something to /proc/sys/vm/????? to force
it to stabilise at around 10Mb or 20Mb? Otherwise can I change a constant
and recompile kernel to achieve same? It might help give more headroom when
the event occurs.

> 
> > Is the quickest fix to give it more ram. I read on another posting that
> > with greater than 512Mb the cache won't grab any more?
> 
> Please don't succumb to 'add more RAM' syndrome. 460 megs should be fine
> for you. I'd say better find the root of the problem.

I admit it, I since tried the 'add more RAM' but a couple of capture card devices
did not like more than about 800Mb so I pulled the stick back out. It ran quite
well in 256Mb with the old kernel for about a year so it is puzzling.

> vda
> 

Thanks for the response
Regards
Ross.

