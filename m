Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbUBHHcm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 02:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbUBHHcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 02:32:42 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:18692 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262652AbUBHHcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 02:32:41 -0500
Date: Sun, 8 Feb 2004 08:31:51 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Athol Mullen <athol_SPIT_SPAM@idl.net.au>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] IDE 80-core cable detect - chipset-specific code to over-ride eighty_ninty_three()
Message-ID: <20040208073151.GC29363@alpha.home.local>
References: <1mtPj-7oQ-3@gated-at.bofh.it> <1mwNn-1xb-27@gated-at.bofh.it> <200402081145.19027.athol_SPIT_SPAM@idl.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402081145.19027.athol_SPIT_SPAM@idl.net.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 08, 2004 at 11:45:18AM +1100, Athol Mullen wrote:
> Before I modified eighty_ninty_three(), it returning 0 caused the _indicated_ 
> mode to drop to UDMA33.  Check in /proc/ide/piix to see what mode the driver 
> tells you.  IIRC (could be wrong), dmesg and hdparm both believe it to be in 
> UDMA33 while the init code and /proc/ide/piix both showed it as UDMA5.

I captured dmesg and /proc/ide/piix, but forgot to post them. They're at work
now. But I did the change, by commenting out the call to eighty_ninety_three()
in piix.c, and my disks came back to 54 MB/s each, and 64 MB/s cumulated.
dmesg showed UDMA33 before and now displays UDMA100 again. But I obviously
cannot let it like that because if I install this kernel in a 40-pin machine,
I will get some surprizes !

> I'm starting to wonder if my ICH5 _is_ actually running UDMA5...  It's doing 
> 21MB/s, which I've been blaming on the old 30G Quantum, whereas the ICH4 with 
> a 120G drive is doing 56MB/s...  I think I checked the bit flags in 
> /proc/ide/ide0/config and it showed up as UDMA5.

I'm certain that this one changed before and after the patch, but I cannot
tell you what the differences were.

> >> I'm not certain exactly how this would be implemented, but I'd like to see 
> >> eighty_ninty_three() check for chipset-specific detection code, and use the 
> > well, why not in piix:piix_ratemask() around line 315 ?
> 
> I could put it there, but I was actually intending to use it to also return a 
> value properly for eighty_ninty_three(), and figured that it would need to be 
> a separate routine - I expect that the module structure needs to change, and 
> that's where I'm not sure - it could affect _all_ ide drivers.  There might 
> be others that have their own specific detection code, and what I'm looking 
> to do is establish the framework for that.
 
I understand. But could you please post your ICH5 detection code so that I
can try it on this machine. I still can play with it for a few days before
it gets racked. And I can try with both 40 and 80-pin cables.

> business .sig wasn't supposed to get tacked on after my usenet .sig...  It 
> _was_ a spam-free email address.  :-(

Now the only thing you can do is to count how many days elapse before you
get your first spam...

Regards,
Willy

