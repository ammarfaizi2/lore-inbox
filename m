Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272345AbRIYSuS>; Tue, 25 Sep 2001 14:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272465AbRIYSuI>; Tue, 25 Sep 2001 14:50:08 -0400
Received: from [195.223.140.107] ([195.223.140.107]:45550 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S272620AbRIYSt6>;
	Tue, 25 Sep 2001 14:49:58 -0400
Date: Tue, 25 Sep 2001 20:49:29 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10aa1 (00_vm-tweaks-1)
Message-ID: <20010925204929.B8350@athlon.random>
In-Reply-To: <20010923232511.B1466@athlon.random> <Pine.NEB.4.40.0109241529440.27952-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.NEB.4.40.0109241529440.27952-100000@mimas.fachschaften.tu-muenchen.de>; from bunk@fs.tum.de on Mon, Sep 24, 2001 at 03:42:59PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2001 at 03:42:59PM +0200, Adrian Bunk wrote:
> On Sun, 23 Sep 2001, Andrea Arcangeli wrote:
> 
> > If you are interested about the VM behaviour under swap (and non) please
> > test the 00_vm-tweaks-1 (can be applied to plain 2.4.10), here the swap
> > behaviour seems improved with it. Thanks!
> >...
> 
> 2.4.10 seems to behave worse than kernels up to 2.4.9 and 2.4.9ac12
> (haven't tried above) with the following workload (everything is only a
> subjective impression as a user; I don't look at how long the "rm" and the
> "tar" take because that's not very important for me):
> 
> FVWM with 6 open xterms is running
> XMMS is running
> 
> mv linux linux.old
> nice rm -rf linux.old &
> tar xzf linux-2.4.10.tar.gz &
> lynx ftp://ftp.kernel.org/pub/linux/kernel/testing
> 
> 
> up to 2.4.9 and 2.4.9ac12:
> everything works fine
> 
> 2.4.10:
> interactive use of the machine is very bad, I can't type a command in
> another xterm

yes, that's because you didn't applied vm-tweaks-1 yet and you didn't
enough ram and you needed to swap.

> 
> 2.4.10 + 00_vm-tweaks-1:
> interactive use of the machine works all right, but XMMS does sometimes
> stutter

it didn't happen here but let's look into it.

> This is on a K6 with 300 Mhz. free in 2.4.10 + 00_vm-tweaks-1 gives the
> following output:
> 
> $ free
>              total       used       free     shared    buffers     cached
> Mem:         62252      60400       1852          0       2408      32792
> -/+ buffers/cache:      25200      37052
> Swap:       947824      10264     937560
> $
> 
> 
> My impression is that there's a problem when several processes do heavy
> non-cachable disk IO.

I've a few ideas on what to change incrementally to vm-tweaks-1, but can
you send me the `vmstat 1` output, plus also the /proc/meminfo output
snapshotted at regular intervals while xmms is "stuttering" just to
avoid looking at the wrong place? thanks,

Andrea
