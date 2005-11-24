Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161069AbVKXXWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161069AbVKXXWO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 18:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbVKXXWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 18:22:14 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:35083 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751404AbVKXXWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 18:22:13 -0500
Date: Fri, 25 Nov 2005 00:22:10 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Andreas Haumer <andreas@xss.co.at>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4.31 + aic79xx] SCSI error: Infinite interrupt loop, INTSTAT = 0
Message-ID: <20051124232210.GB23855@alpha.home.local>
References: <43838ECC.5060204@xss.co.at> <20051124053952.GI11266@alpha.home.local> <4385BA96.1080804@xss.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4385BA96.1080804@xss.co.at>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Thu, Nov 24, 2005 at 02:05:26PM +0100, Andreas Haumer wrote:

> >> I've never tried an adaptec U320 yet, only a few 29160 in various servers.
> > 
> I have tried the external RAID with the following controllers now:
> 
> Adaptec 29160 - works fine (with the aic7xxx driver)
> Adaptec 29320ALP - does not work (tried with two different cards)
> Adaptec 29320A - does not work

OK so the problem is only related to 29320 + aic79xx driver.

> > Today I tried to integrate the external EonStor RAID and first
> > it seemd to work fine, too. The system did find the devices
> > and I could create a new volume group with several logical
> > volumes out of them.
> > 
> > But as soon as I try to create a filesystem on the new logical
> > volumes or do some other work with the devices, the SCSI driver
> > goes berserk:
> > 
> > 
> >> So could we say when you have very low traffic (device identification,
> >> write a few sectors to create the volume), everything's OK, and when
> >> you write larger amounts of data, the problem strikes ?
> > 
> 
> The probability for SCSI timeouts and bus resets is higher with
> higher bus activity. I did a lot of testing in the past few days
> and sometimes (but not always) I get timeouts and bus resets even
> when scanning the partition table in the initial ramdisk...
> 
> >> It may be possible that you have a termination and/or cable problem
> >> and that the driver does not correctly recover from such a condition.
> > 
> I can not completely rule out bad SCSI cabling, but:
> 
> * I replaced cables
>   -> problem remains the same
> * I tried with three different 29320 controller boards (LP and non-LP)
>   -> problem remains the same
> * I tried with the original setup (cables, RAID device, server, software),
>   but used a 29160 controller and it worked. But of course at a lower data
>   transfer speed on the SCSI bus and with a different SCSI driver (aic7xxx)!
> 
> This is not a cheap setup: high quality SCSI cables and VHDCI connectors,
> not-so-cheap external RAID and server, everything connected to an 2200VA
> UPS, air conditioned computer room. SCSI bus termination is internal and
> automatically handled by the RAID subsystem.
> I can't rule out bad hardware, but to me it seems unlikely. I have set up
> several similar systems in the past year (same server, same RAID subsystem)
> and never had any problems.

OK, I'll fully trust you on your setup then and won't ask you is the power
plug is connected to the wall :-)

> This is the first one where I want to use those Adaptec 29320 controllers,
> though... ;-)

:-)

> [...]
> > 
> > I found some messages reporting similar problems on this
> > list, a few weeks ago (beginning of October 2005). There
> > was also a patch for the aic79xx driver mentioned, but I
> > haven't found any report about it since then, so I don't
> > know the status of the patch (it was for the 2.6 kernel,
> > anyway, as far as I remember)
> > 
> > 
> >> would you please send a link to this patch, or even the
> >> whole thread if there were responses ?
> > 
> This was a thread crossposted on both linux-kernel and linux-scsi,
> starting on September 28th, 2005 going until October 4th, 2005.
> Subject was "Infinite interrupt loop, INTSTAT = 0"
> (See http://marc.theaimsgroup.com/?l=linux-scsi&m=112791530210044&w=2)
> 
> A patch was posted by James Bottomley on October 3rd, 2004
> (See http://marc.theaimsgroup.com/?l=linux-scsi&m=112837144508743&w=2)

Interesting, I've archived it. James presented it as a workaround,
waiting for something cleaner, but I've not seen any followup (may
be I've not searched well).

> > What can I do to make the external RAID usable?
> > Dump the Adaptec cards and replace them with something better?
> > 
> > 
> >> I've heard several people tell me that they have no problem with LSI
> >> logic cards, but as I don't have problems either with AIC79xx, I don't
> >> know how that should be interpreted.
> > 
> I also have good experience with LSI Logic cards (Fusion MPT driver).
> Yesterday I ordered several of them, I hope I'll get them soon so I
> can do further tests.

OK, it will definitely rule out bad cables and RAID array.

> > Patch the driver?
> > 
> > 
> >> There is a large patch from the driver's author on his site. In fact,
> >> it's not really a patch, it's the whole driver directory. I've used
> >> it for a long time now (a few years) in my kernels without any problem.
> >> You may want to try it :
> > 
> >>   http://people.freebsd.org/~gibbs/linux/
> > 
> >> You can also get it as a patch from my tree :
> > 
> >>   http://w.ods.org/kernel/2.4-wt/2.4.31-wt1/patches-2.4.31-wt1/pool/aic79xx-20040522-linux-2.4.30-pre3.rediff
> > 
> I downloaded the driver from Justin's site (aic79xx-linux-2.4-20040522-tar.gz)
> and compiled the driver for kernel 2.4.31. Compilation went well and without
> errors or warnings. Driver version is 2.0.12 for the aic79xx driver.
> 
> With the new driver (v2.0.12) the problem basically remains the same, though the
> messages are a little bit different:

Often (in my experience), when different versions of a driver find different
error conditions, it is caused by timing problems. Perhaps the driver has to
respect some pauses on the bus that are not quite correctly respected. Have
you tried to lower the speed to 160 MB/s ?

> [...]
...  log output ...
> [...]
> 
> And so on...
> 
> I have now run out of test hardware. For further testing
> I'll have to wait until the new LSI Logic controllers arrive,
> hopefully until tomorrow.
> 
> Any other idea?

Unfortunately not. I had thought about running a "verify media" test
from the adaptec bios on one of the RAID disks, but I then realized
that it will only transfer commands and no data, so the test will be
useless.

Regards,
Willy

