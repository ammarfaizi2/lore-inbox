Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbTIKMeh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 08:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbTIKMeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 08:34:37 -0400
Received: from www.inreko.ee ([195.222.18.2]:26124 "EHLO www.inreko.ee")
	by vger.kernel.org with ESMTP id S261259AbTIKMee (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 08:34:34 -0400
Date: Thu, 11 Sep 2003 15:34:18 +0300
From: Marko Kreen <marko@l-t.ee>
To: Ronny Buchmann <ronny-lkml@vlugnet.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [OOPS] 2.4.22 / HPT372N
Message-ID: <20030911123418.GA6798@l-t.ee>
References: <200309091406.56334.ronny-lkml@vlugnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309091406.56334.ronny-lkml@vlugnet.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 02:06:56PM +0200, Ronny Buchmann wrote:
> Marko Kreen wrote:
> > Now we did some experimenting with it and no BIOS settings seem
> > to affect the FREQ numbers. (Lower CPU/mem speed, 50/25 AGP/PCI speed.)
> > The FREQ still stays fixed at 85.
> > 
> > Motherboard is EP-4PDA2+.
> > 
> > Any idea how to remove the overclocking?  Otherwise it seems
> > like driver bug to me.
> What bios version do you use? Have you tried a CMOS reset?

BIOS is 6/20/2003.

Yes, we did CMOS reset, because the board 'played dead' for a
while.  After staying without battery it woke up again.
HPT acts still same.  I looked BIOS changelog, did not saw
anything related to overclocking.

> I have the same motherboard but a different problem with the hpt chip, only 
> the first channel is recognized. (see 
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=97824)

I saw something like that too - when disk was in second channel,
it did not crash because it did not detect anything.

> part from dmesg (klogd) output
> ---
> Sep  7 23:50:17 bserv kernel: HPT366: IDE controller at PCI slot 02:00.0
> Sep  7 23:50:17 bserv kernel: HPT366: chipset revision 6
> Sep  7 23:50:17 bserv kernel: HPT366: not 100%% native mode: will probe irqs 
> later
> Sep  7 23:50:17 bserv kernel: hpt: HPT372N detected, using 372N timing.
> Sep  7 23:50:17 bserv kernel: FREQ: 82 PLL: 35

"FREQ: 82" is pretty high as the limit is 85.

I replaced "< 0x55" with "<= 0x55" in hpt366.c and the driver
did not crash, but it also did not detect cdrom - only thing
behind it ATM - so I did not bother messing with it further.

> Currently the driver provided by highpoint 
> (http://www.highpoint-tech.com/hpt3xx-opensource-v131.tgz) is working ok for 
> me (apart from it's lack of s.ma.r.t. support).
> 
> Did you try this?

Now I tried - that one also did not detect cdrom.  I cant
experiment further as the machine needs to go to production
soon.  ATM I disabled onboard HPT, and put in separate IDE
controller (HPT370) to get needed IDE channel.

My conclusions:

1) Motherboard is overclocked by manufacturer - so in the future
   I intend to stay away from EPOX.

2) HPT372n support in Linux is beta (as documented...)

-- 
marko

