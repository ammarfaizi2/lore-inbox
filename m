Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315199AbSEKWBS>; Sat, 11 May 2002 18:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315201AbSEKWBR>; Sat, 11 May 2002 18:01:17 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:52370 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315199AbSEKWBR>; Sat, 11 May 2002 18:01:17 -0400
To: Jens Axboe <axboe@suse.de>
cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Linus Torvalds <torvalds@transmeta.com>, Lincoln Dale <ltd@cisco.com>,
        Andrew Morton <akpm@zip.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Lahr <lahr@us.ibm.com>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: O_DIRECT performance impact on 2.4.18 (was: Re: [PATCH] 2.5.14 IDE 56) 
In-Reply-To: Your message of Sat, 11 May 2002 22:17:42 +0200.
             <20020511201742.GA1106@suse.de> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1284.1021156065.1@us.ibm.com>
Date: Sat, 11 May 2002 15:27:45 -0700
Message-Id: <E176fL7-0000Km-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020511201742.GA1106@suse.de>, > : Jens Axboe writes:
> On Sat, May 11 2002, Gerrit Huizenga wrote:
> > In message <20020511142434.GA1224@suse.de>, > : Jens Axboe writes:
> > > On Sat, May 11 2002, Roy Sigurd Karlsbakk wrote:
> > > > On Friday 10 May 2002 17:55, Linus Torvalds wrote:
> > > > > On Fri, 10 May 2002, Lincoln Dale wrote:
> > > > > > so O_DIRECT in 2.4.18 still shows up as a 55% performance hit versus no
> > > > > > O_DIRECT. anyone have any clues?
> > > > >
> > > > > Yes.
> > > > >
> > > > > O_DIRECT isn't doing any read-ahead.
> > > > >
> > > > > For O_DIRECT to be a win, you need to make it asynchronous.
> > > > 
> > > > Will the use of O_DIRECT affect disk elevatoring?
> > > 
> > > No, the I/O scheduler can't even tell whether it's being handed
> > > O_DIRECT buffers or not.
> > 
> > We tried disabling the elevator while doing Raw IO with DB2
> > a couple of weeks ago.  The database performance degraded much
> 
> I'm curious how you did this -- did you disable sorting and merging, or
> just sorting? Merging is pretty essential to getting decent I/O speeds
> in current kernels.
 
I believe sorting AND merging were turned off.  BTW, this was 2.4 only,
our primary focus is getting product into people's hands this year.  We
are hoping to play with the 2.5 IO scheduler, possibly in a few months.

> > more than expected.  Disks were FC connected Tritons or SCSI
> > connected ServerRaid (or both?).  Oracle often asks for a patch
> > to disable the elevator since they believe they can schedule IO
> > better.  We didn't try with Oracle in this case, but DB2 and RAW
> > IO without and elevator was not a good choice.
> 
> Due to excessive queue scan times, lock contention, or just slight waste
> of cycles?
 
A lot more interrupts on the RAID device, indicating a lot more
IOs, probably a direct result of disabling merging.  Overall IO throughput
dropped pretty dramatically, reducing database throughput.

A good indication to gen a patch with just sorting turned off and
see where that gets us...

gerrit
