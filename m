Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262715AbRFRNR5>; Mon, 18 Jun 2001 09:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262982AbRFRNRi>; Mon, 18 Jun 2001 09:17:38 -0400
Received: from [213.97.184.209] ([213.97.184.209]:3712 "HELO piraos.com")
	by vger.kernel.org with SMTP id <S262715AbRFRNRb>;
	Mon, 18 Jun 2001 09:17:31 -0400
Date: Mon, 18 Jun 2001 15:17:31 +0200 (CEST)
From: German Gomez Garcia <german@piraos.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Mailing List Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Strange behaviour of swap under 2.4.5-ac15
In-Reply-To: <20010618143559.A23006@athlon.random>
Message-ID: <Pine.LNX.4.33.0106181500480.270-100000@hal9000.piraos.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2001, Andrea Arcangeli wrote:

> On Mon, Jun 18, 2001 at 12:14:01PM +0200, German Gomez Garcia wrote:
> > 	Hello,
> >
> > 	I've running 2.4.5-ac15 for almost a day (22 hours) and I found
> > some strange behaviour of the kswap, at least it was not present in
> > 2.4.5-ac9. The swap memory increase with time as the cache dedicated
> > memory also increase, that is swapping process at a very fast rate, even
> > when no program is getting more memory. Is that the expected behaviour?
> > 	An example, with no process running (just the usual daemons and
> > none of them getting extra memory) the command:
> >
> > 	free ; sleep 60; free
> >
> >              total       used       free     shared    buffers     cached
> > Mem:        513416     393184     120232        364      63276     254576
> > -/+ buffers/cache:      75332     438084
> > Swap:       530104      14228     515876
> >
> >              total       used       free     shared    buffers     cached
> > Mem:        513416     393192     120224        364      63276     258412
> > -/+ buffers/cache:      71504     441912
> > Swap:       530104      18064     512040
> >
> > 	Any idea?
>
> either apply this patch to 2.4.5ac15:
>
> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.5aa3/00_fix-unusable-vm-on-alpha-1
>
> (note it is not an alpha specific bug, it's just that I was triggering
> all the time on alpha so I called the patch that way)

	It doesn't fix it, swapped memory and cache memory increase at a
rate of about 40K/s, swapping process very fast, even the "agetty"
processes get 64 out of 68 K swapped one or two minutes after booting.
This rate gets lower as nothing but the essential (4K of "agetty", etc) is
left in the physical memory.

> or better use 2.4.6pre3aa1:
>
> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.6pre3aa1.bz2

	I'll test this later as I cannot reboot the machine right now.
Just one question, is this kernel 'stable', I was running 2.4.5-ac9 for
a week without problems, even when 'stress-testing' the emu10k1 and the
mga modules.

	Regards,

	- german

PS: swapoff -a fixes the problem :-)
-------------------------------------------------------------------------
German Gomez Garcia         | "This isn't right.  This isn't even wrong."
<german@piraos.com>         |                         -- Wolfgang Pauli

