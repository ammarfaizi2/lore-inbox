Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270452AbTGSARD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 20:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270454AbTGSARC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 20:17:02 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:4271 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S270452AbTGSAQ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 20:16:58 -0400
Date: Fri, 18 Jul 2003 19:31:08 -0500
From: linas@austin.ibm.com
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, linas@linas.org
Subject: Re: KDB in the mainstream 2.4.x kernels?
Message-ID: <20030718193107.B45512@forte.austin.ibm.com>
References: <aJIn.3mj.15@gated-at.bofh.it> <m3smp3y38y.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m3smp3y38y.fsf@averell.firstfloor.org>; from ak@muc.de on Fri, Jul 18, 2003 at 10:43:57PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

I'm happy to get a response...

On Fri, Jul 18, 2003 at 10:43:57PM +0200, Andi Kleen wrote:
> 
> One argument i have against it: KDB is incredibly ugly code. 
> Before it could be even considered for merging it would need quite a lot 
> of cleanup.

What in particular?  I just looked at kdb/kdbmain.c and kdb/kdb_bt.c
and it looks fine to me; fairly minimal even.  I don't know about 
arch-specific code.  Is there a particular file you're complaining about?

(very very off-topic: I love reading about the neat things that 
reiser v4 will do, but wow, every time I read reiserfs code, 'ugly'
is indeed the word that flies to mind).

> I actually started on porting the KDB backtracer recently to get
> reliable frame pointer based backtraces, but it turns out the code
> for that is so complicated and ugly that the chances of ever merging
> it would be very slim.
?

I have not (yet?) studied the code in detail, so point me at something
ugly; I'm not sure what you are talking about.  Now, stack traces are
in general ugly because registers and args are splattered all over 
the place, and the struct pt_regs are even worse.  So there's some
inherent ugliness there ...

Since I live in KDB, I might have some spare time to cleanup/fix,etc.
so nows a good time to talk .. 

> As for your home crash debugging I suspect you would be better of with LKCD
> or Mcore (crash dump, saving an crash image on some partition, with examining
> the crash dump after reboot) 

I'll look ... given that I own lots flaky IDE hardware, though, I'm catious.
I get 'DriveReady SeekComplete Error' messages daily ... I learned the hard
way that these aren't necessarily the fault of the hard drive, and I have
suffered through corrupted fs's as a result ...

Generically, for servers, if you can just save the dump, reboot, and
let the server go on, and analyze the dump at leisure, that is the 
prefered way to do things.  Especially if you are doing customer support. 
(Linux is at the dawn of the era of having customers who have actually
spent in excess of $100K or $1M on a server and who will be going
apoplectic when it crashes.  This will put a spotlight on dump tools).

> KDB is usually not useful for debugging hangs on desktop boxes (and even
> many servers) because you have usually X running. When the machine crashes and
> goes in KDB you cannot see the text output and debug anything. I learned

I'm willing to put console on serial port. I've got enough machines 
& serial cables, this doesn't bother me.  

> Disadvantage is that the current crash dump mechanisms (lkcd, mcore
> crash, netdump) are all still not very reliable and have horrible
> error handling. 

This statement makes me nervous. One of the worst feelings one can get
when debugging is not being able to trust the data you are looking at.
Its too easy to loose a lot of time (and credibility) making incorrect 
hypothesis based on bad data.

Dedicating a partition that is unformated, and whose sole purpose
in life is to record a dump -- that is a viable option, at least on
servers, where high uptime is more important, and storage is cheap.

On my home machines, its sort of the other way around: I don't trust 
IDE, I don't have the disk space.

But you convinced me; I need more time on lkcd, etc. 

--linas

