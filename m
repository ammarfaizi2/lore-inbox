Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264694AbSJUC3N>; Sun, 20 Oct 2002 22:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264697AbSJUC3N>; Sun, 20 Oct 2002 22:29:13 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:57863 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S264694AbSJUC3M>; Sun, 20 Oct 2002 22:29:12 -0400
Date: Sun, 20 Oct 2002 22:34:52 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
cc: davidsen <root@tmr.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: NCR adaptor doesn't see devices (was: 2.5.43 aic7xxx segfault)
In-Reply-To: <Pine.LNX.4.44.0210201436260.9763-100000@filesrv1.baby-dragons.com>
Message-ID: <Pine.LNX.3.96.1021020222224.1655A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Oct 2002, Mr. James W. Laferriere wrote:

> On Sun, 20 Oct 2002, Bill Davidsen wrote:
> > No, the sym-anything seems to be for the newer chopsets, and not the old
> > ncr825. I believe I tried 2.5.38 or so with that driver and it couldn't
> > find a device it liked. I'll try building that module again, but it didn't
> > work and I thought it might be causing a problem trying.
> 	Iirc ,  Gerard said that the Sym-2 is for all chipsets again .
> 	see: linux/drivers/scsi/sym53c8xx_2/Documentation.txt
> 	The ncr53c8xx was the original driver that he produced .  Then
> 	came the sym53c8xx version which was NOT for the older chips
> 	supported by the ncr53c8xx.c .

First, you are right, using the new sym driver the card works. But:
 1. it doesn't build (2.5.43) as a module, up through -mm3
 2. the ncr module works in 2.4, and should work or be remnoved.
    Typically we keep old modules, like the something7,8xx (yes, comma
    in the module name).
 3. Building in makes it load before the ide-scsi module, and changes all
    the device name and assignments. I have enough problems going between
    2.4 and 2.5, I'm afraid of ising devfs on top of that. If it works.
 
> > Also note that the driver inserts and fails twice (see dmesg) which is not
> > intuitive to me.
> 	Yes , I noted them below using a grep of your document .  It
> 	appears that the SYM53c8xx driver gets loaded   THEN the
> 	ncr53c8xx attempts to load & of course conflicts with the
> 	SYM53c8xx .  These two drivers can not co-exist ,  Without very
> 	special care as to how they get loaded or some such .
> 	I still highly recommend the sym2 driver rather than either of
> 	the two being loaded .  But if it won't recognise the drives ...
> 		Hth ,  JimL

Most good catch, I saw the ncr52c8xx and missed the module name, don't
know how that got turned on.

So I can run as long as I'm very ccareful what scripts do, and the ncr
module could be fix (probably trivial) or the sym-2 could be made to work
as a module. I can provide the config and anything else if that proves
hard to replicate, I'm in the habbit of building almost everything as a
module, so I hit rather more of these problems than I would like.

Again thanks for the catch, I'm working, the system uses all devices, and
the swap of /dev/sc0<=>/dev/scd1 assignment is acceptable for a
development machine. I'll probably change the scripts to use cdrom1..N and
just make the symlinks in rc.local.

I couldn't get netfilter to build as modules the last time I tried, I have
to look at that Wednesday, when I'm back in the office.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

