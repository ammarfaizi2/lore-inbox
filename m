Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277758AbRJLTBW>; Fri, 12 Oct 2001 15:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277803AbRJLTBD>; Fri, 12 Oct 2001 15:01:03 -0400
Received: from D8FA50AA.ptr.dia.nextlink.net ([216.250.80.170]:14088 "EHLO
	mail.applianceware.com") by vger.kernel.org with ESMTP
	id <S277758AbRJLTAu>; Fri, 12 Oct 2001 15:00:50 -0400
Message-ID: <006501c15351$76e881d0$cc00000a@foo>
From: "Jean-Gabriel Rican" <grican@applianceware.com>
To: "Ingo Molnar" <mingo@redhat.com>, <gaby@applianceware.com>
Cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0110120220290.7954-100000@devserv.devel.redhat.com>
Subject: Re: [PATCH] for Multiple Device driver - md.c (kernel 2.4.12)
Date: Fri, 12 Oct 2001 12:09:49 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

Yes you are right: raidhotadd does the job and I cannot believe that I
wasn't considering it myself. Probably I was so focused on the process of
adding a hot spare that I forgot to try this.

It looks that my patch isn't necessary required after all. The only
advantage that it offers is that it saves a raidhotremove call (and the test
to see if the drive is really faulty or still present in the RAID array -
because raidhotadd will fail in this case), but in rest it seems to be
rather equivalent.

Anyway, thank you for the solution and I hope that I didn't caused any
inconvenience.

Jean-Gabriel Rican

>
> > Suppose you can hot-swap a hard disk in a system. Now if you have a
> > degraded Software RAID device (for example a RAID-5 with one disk
> > failed) and you replace the failed disk on-the-fly you cannot start
> > reconstruction (with raidhotadd) of the Software RAID device with the
> > replaced disk because it says it is BUSY.
>
> this is possible already: you should first raidhotremove the failed drive,
> then raidhotadd the new drive. It can be the 'same' drive if it's a
> hot-swap disk, or it can be another, spare disk.
>
> > + if (rdev && rdev->faulty) {
> > + err = hot_remove_disk(mddev, dev);
>
> what your patch does is a forced remove of any drive that is
> raidhotadd-ed. This is less finegrained than the current solution, and
> might make the method more volatile. (easier to mess up accidentally.) Is
> there anything your patch allows that is not possible today, via
> raidhotremove+raidhotadd?
>
> Ingo
>

