Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750698AbWJOJke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750698AbWJOJke (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 05:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750699AbWJOJke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 05:40:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:25697 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750698AbWJOJkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 05:40:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kSU5DSdi99i+r8cbBcIVXi1YBpgh4cXR3eE4KsP/TFUqtSCa0JgRJyRfnFIGaSX6QnqW9MezbBjrP0iCezLsmo9pSK3FqPvRngzKXWDxXU3mPKcsyq6d/m11sRthKftx5loJd1kHq+2Skkx7osy2Y3MP4HFK0FfmDWcoyl+8G9w=
Message-ID: <74d0deb30610150240y16d6ea92mc96705576b8f0824@mail.gmail.com>
Date: Sun, 15 Oct 2006 11:40:31 +0200
From: "pHilipp Zabel" <philipp.zabel@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] Use own work queue
In-Reply-To: <20061013075626.GB28654@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061001124240.16996.34557.stgit@poseidon.drzeus.cx>
	 <74d0deb30610070717k17079940ybedbf94dc8af8460@mail.gmail.com>
	 <452AB97B.5040309@drzeus.cx>
	 <20061013075626.GB28654@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/06, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> On Mon, Oct 09, 2006 at 11:04:59PM +0200, Pierre Ossman wrote:
> > pHilipp Zabel wrote:
> > >
> > > This patch makes pxamci stop working for me on a HTC Magician (PXA272).
> > > Switching from 2.6.18 to 2.6.19-rc1 I got a kernel panic:
> > >
> > > mmc0: clock 0Hz busmode 1 powermode 0 cs 0  Vdd 0 width 0
> > > PXAMCI: clkrt = 0 cmdat = 0
> > > VFS: Cannot open root device "mmcblk0p2" or unknown-block(0,0)
> > > Please append a correct "root=" boot option
> > > Kernel panic - not syncing: VFS: Unable to mount root fs on
> > > unknown-block(0,0)
> > >
> > > After removing this patch from 2.6.19-rc1, everything is working again.
> > > Are there any changes to pxamci.c needed to be compatible with it?
> > >
> >
> > No, the drivers shouldn't be affected. As this is a root device, my
> > guess would be that you have a race in your bootup that is causing problem.
>
> The problem is likely that the boot is continuing in parallel with
> detecting the card, because the card detection is running in its own
> separate thread.  Meanwhile, the init thread is trying to read from
> the as-yet missing root device and erroring out.

Thanks, I can work around this by using the rootdelay kernel parameter.
So does that mean this is the expected behavior, or should I do anything
in the bootup sequence to make the init process wait for mmc detection?

regards
Philipp
