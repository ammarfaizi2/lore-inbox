Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315285AbSF3Qlt>; Sun, 30 Jun 2002 12:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315293AbSF3Qls>; Sun, 30 Jun 2002 12:41:48 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:45453 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S315285AbSF3Qlr>; Sun, 30 Jun 2002 12:41:47 -0400
Date: Sun, 30 Jun 2002 18:34:44 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Zwane Mwaikambo <zwane@mwaikambo.name>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>,
       Martin Dalecki <dalecki@evision-ventures.com>, <alex@ssi.bg>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.24 IDE 95
In-Reply-To: <Pine.LNX.4.44.0206301112470.10717-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.SOL.4.30.0206301820170.18032-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 30 Jun 2002, Zwane Mwaikambo wrote:

> On Sun, 30 Jun 2002, Bartlomiej Zolnierkiewicz wrote:
>
> > > (1) ide-taskfile.c: ide_do_drive_cmd(..., ide_preempt) holds channel
> > >     lock. Do not reacquire. NMI watchdog triggered by just booting
> > >     computer with IDE cdrom.
> >
> > Mentioned in 95 changelog.
> > Already fixed in my tree, but thanks anyway.
>
> Hmm i just spent some time last night trying to go through possible
> paths for ide_do_drive_cmd to come up with a solution for that one, do you
> use some sort of SCM so that i can keep track of whats been covered?

Unfortunately no, I have only dialup...

> > Attached patch is next ide-clean patch pre-patch ;), just not to duplicate
> > efforts. Changelog is also included. As always use with care, standard
> > disclaimer apply.
>
> Thanks
>
> > And final note: I think that previous locking (2.4.x but ch->lock instead
> > of global io_request_lock) was well tuned and almost 100% correct.
> > Recent changes just made it worse (sorry Martin :) ).
> > Now even if we add unmasking IRQs with disabling currently handled IRQ, it
> > will be less friendlier to shared PCI interrupts (especially in PIO it
> > will be overkill to disable shared IRQ for handling PIO intr!),
> > so I want to revert to previous scheme...
>
> Agreed there, thanks again for the patches.
>
> 	Zwane Mwaikambo
>
> --
> http://function.linuxpower.ca

I will also forward You my reply to Petr, it shows my (correct?)
understanding of previous vs. actual IDE locking...
If you find any errors in thinking please let my now :)

Greets.
--
Bartlomiej


