Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317431AbSGOLEi>; Mon, 15 Jul 2002 07:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317433AbSGOLEh>; Mon, 15 Jul 2002 07:04:37 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:56257 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S317432AbSGOLEf>; Mon, 15 Jul 2002 07:04:35 -0400
Date: Mon, 15 Jul 2002 12:01:22 +0200
From: Richard Zidlicky 
	<Richard.Zidlicky@stud.informatik.uni-erlangen.de>
To: Joerg Schilling <schilling@fokus.gmd.de>
Cc: andersen@codepoet.org, linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Message-ID: <20020715120122.C1173@linux-m68k.org>
References: <200207142013.g6EKDJb5019442@burner.fokus.gmd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200207142013.g6EKDJb5019442@burner.fokus.gmd.de>; from schilling@fokus.gmd.de on Sun, Jul 14, 2002 at 10:13:19PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2002 at 10:13:19PM +0200, Joerg Schilling wrote:

> 
> BTW: did you ever look at Solaris / HP-UX, ... and the way they
> name disks?

still have fresh memories how everything was renamed and broke 
some of my apps.

> someting like: /dev/{r}dsk/c0t0d0s0
> 
> This is SCSI bus, target, lun and slice.

You can have that type of names with devfs, no need to work
around kernel functionality in cdrecord.
On pure IDE hardware that doesn't make sense anyway, in fact
cdrecord mapping is strongly counterintuitive here. 
CD-RW = hdd = bus1,target2 but cdrecord sees it as 0,0,0.

> >There is another problem, with your scsi transport library you
> >are bypassing normal Linux devices. Try
> >  mount /dev/scd0 /mnt
> >  cdrecord -dev 0,0,0 -blank=fast
> >  ls -al /mnt
> 
> >Nice? It certainly isn't the fault of Linux if you choose to
> >bypass normal device usage and it can be very annoying not
> >only for beginners.
> 
> It is not a fault of cdrecord either.

A cure would be nice and I don't see what the kernel could do
to solve this problem as long as cdrecord insists on talking
to the SCSI bus directly.

If nothing else, cdrecord manpage
 - should make a big fat warning about it
 - should stop claiming that it is safe to suid cdrecord

The potential for breakage is huge, people run automounters on CD's,
file managers may try to mount the CD without asking the user.

Richard
