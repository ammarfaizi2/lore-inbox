Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277564AbRJVS1t>; Mon, 22 Oct 2001 14:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277554AbRJVS1j>; Mon, 22 Oct 2001 14:27:39 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:22021 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S277531AbRJVS1e>; Mon, 22 Oct 2001 14:27:34 -0400
Date: Mon, 22 Oct 2001 14:28:09 -0400
Message-Id: <200110221828.f9MIS9f16047@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Poor floppy performance in kernel 2.4.10
X-Newsgroups: linux.dev.kernel
In-Reply-To: <200110211136.f9LBa9B17801@hitchhiker.org.lu>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200110211136.f9LBa9B17801@hitchhiker.org.lu> Alain.Knaff@hitchhiker.org.lu wrote:
| Sorry for joining this discussion so late, but I only check
| linux-kernel only about once or twice a week.
| 
| Rather than responding to each message individually, here's a small
| summary about my take on the issues:

| Bill Davidsen wrote:
| >That said, I have a few other thoughts. First, can't the kernel 
| >detect when a new floppy is inserted?
| 
| Yes, the kernel (floppy driver) can do this, and indeed it does.
| 
| >I can't remember if there is an 
| >interupt generated when the floppy seats or not. 
| 
| Actually, it is not really an interrupt, but a bit that is set in the
| FD_DIR register. It stays set until the floppy disk driver
| acknowledges it by seeking the drive, or by selecting/unselecting it.
| 
| Before reading from the disk (or whenever it needs to know whether a
| disk has been changed or not), the floppy driver reads this bit, and
| if set notifies the VFS of the disk change. It then proceeds to seek,
| in order to clear this flag (needed in order to detect further
| changes)
| 
| 
| >I 
| >seem to remember that not all drives provide the signal, at least back 
| >when I wrote my last floppy driver (DEC Rainbow, about 20 years
| ago). 
| 
| Yes, very old drives have problems supplying the signal. However, most
| _recent_ cases of broken disk change line are due to ... badly
| inserted cabled (d'oh). [ tech details ]

  As was pointed out to me, old floppies don't generate the information
in all cases, nor do some drives for laptop use. But the suggestion was
made that once we get the status for media changed that we can (only)
then flag the status as trusted and not flush the cache on final close.
Unless you boot the system with the floppy inserted I would expect
inserting the first media to set this if the system is trustworthy.

  Drives which don't always work, and cables which are so marginal that
they work or not depending on temperature or vibration could happily be
ignored IMHO, flakey hardware is not deserving of such care, as opposed
to hardware which misbehaves in a predictable way.

-- 
bill davidsen <davidsen@tmr.com>
  His first management concern is not solving the problem, but covering
his ass. If he lived in the middle ages he'd wear his codpiece backward.
