Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313743AbSF3Jpd>; Sun, 30 Jun 2002 05:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314680AbSF3Jpc>; Sun, 30 Jun 2002 05:45:32 -0400
Received: from realimage.realnet.co.sz ([196.28.7.3]:2774 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S313743AbSF3Jpb>; Sun, 30 Jun 2002 05:45:31 -0400
Date: Sun, 30 Jun 2002 11:17:11 +0200 (SAST)
From: Zwane Mwaikambo <zwane@mwaikambo.name>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>,
       Martin Dalecki <dalecki@evision-ventures.com>, <alex@ssi.bg>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.24 IDE 95
In-Reply-To: <Pine.SOL.4.30.0206300024030.12467-300000@mion.elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.44.0206301112470.10717-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jun 2002, Bartlomiej Zolnierkiewicz wrote:

> > (1) ide-taskfile.c: ide_do_drive_cmd(..., ide_preempt) holds channel
> >     lock. Do not reacquire. NMI watchdog triggered by just booting
> >     computer with IDE cdrom.
> 
> Mentioned in 95 changelog.
> Already fixed in my tree, but thanks anyway.

Hmm i just spent some time last night trying to go through possible 
paths for ide_do_drive_cmd to come up with a solution for that one, do you 
use some sort of SCM so that i can keep track of whats been covered?

> Attached patch is next ide-clean patch pre-patch ;), just not to duplicate
> efforts. Changelog is also included. As always use with care, standard
> disclaimer apply.

Thanks

> And final note: I think that previous locking (2.4.x but ch->lock instead
> of global io_request_lock) was well tuned and almost 100% correct.
> Recent changes just made it worse (sorry Martin :) ).
> Now even if we add unmasking IRQs with disabling currently handled IRQ, it
> will be less friendlier to shared PCI interrupts (especially in PIO it
> will be overkill to disable shared IRQ for handling PIO intr!),
> so I want to revert to previous scheme...

Agreed there, thanks again for the patches.

	Zwane Mwaikambo

-- 
http://function.linuxpower.ca
		

