Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267235AbTAKOg3>; Sat, 11 Jan 2003 09:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267238AbTAKOg3>; Sat, 11 Jan 2003 09:36:29 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:43412
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267235AbTAKOg0>; Sat, 11 Jan 2003 09:36:26 -0500
Subject: Re: any chance of 2.6.0-test*?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030111140602.GA20221@averell>
References: <20030110165441$1a8a@gated-at.bofh.it>
	 <20030110165505$38d9@gated-at.bofh.it>
	 <m3iswv27o3.fsf@averell.firstfloor.org>
	 <1042295999.2517.10.camel@irongate.swansea.linux.org.uk>
	 <20030111140602.GA20221@averell>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042299059.2517.29.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 11 Jan 2003 15:31:00 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-01-11 at 14:06, Andi Kleen wrote:
> > The main problems are
> >   - Incorrect locking all over the place
> 
> Hmm bad. Is it that hard to fix ?

Very. Just read the settings/proc code for an example

> >   - Incorrect timings on some phases
> 
> Can't you just take out the timings in that case? 
> My (not very informed) understanding is: 
> everything should work with the BIOS timings and generic IDE,
> having own timings is just an optimization to squeeze out a bit
> more speed.

These are timing for phases not drive timings. Drive timings from
the BIOS are also frequently questionable. These have to be fixed
and as boxes get faster it becomes more important they are

> >   - Lots of random oopses on boot/remove that were apparently
> >     introduced by the kobject/sysfs people and need chasing
> >     down. (There are some non sysfs ones mostly fixed)
> 
> I guess the kobject/sysfs stuff could be ripped out if it doesn't
> work - it is probably not a "must have" feature.

Without a doubt. 

> >   - ide-scsi needs some cleanup to fix switchover ide-cd/scsi
> >     (We can't dump ide-scsi)
> >   - Unregister path has races which cause all the long
> >     standing problems with pcmcia and prevents pci unreg
> 
> Can't you just disable module unloading for the release ?

Only if I can also nail shut your PCMCIA slot, disallow SATA and remove
some ioctls people use for docking.

> >   - IDE raid hasn't been ported to 2.5 at all yet
> 
> Vendor problem ?

It needs a rewrite to the new bio layer or rewriting to use the device
mapper, which is a distinct option here.


> > Which works really well with all the IRQ paths on it
> 
> Then 2.0/2.2/2.4 would have been racy too :-) Apparently they worked though.

Long ago lock_kernel had meaning against IRQ paths. TTY never caught up.

