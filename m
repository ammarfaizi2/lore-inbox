Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261637AbSJANl5>; Tue, 1 Oct 2002 09:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261639AbSJANl5>; Tue, 1 Oct 2002 09:41:57 -0400
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:3200 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261637AbSJANlx> convert rfc822-to-8bit; Tue, 1 Oct 2002 09:41:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [BENCHMARK] 2.5.39-mm1
Date: Tue, 1 Oct 2002 23:44:21 +1000
User-Agent: KMail/1.4.3
References: <200209301941.41627.conman@kolivas.net> <200210012219.53464.conman@kolivas.net> <20021001123013.GS3867@suse.de>
In-Reply-To: <20021001123013.GS3867@suse.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210012344.38964.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 01 Oct 2002 10:30 pm, Jens Axboe wrote:
> On Tue, Oct 01 2002, Con Kolivas wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > On Tuesday 01 Oct 2002 8:20 pm, Andrew Morton wrote:
> > > Jens Axboe wrote:
> > > > On Mon, Sep 30 2002, Andrew Morton wrote:
> > > > > > io_load:
> > > > > > Kernel                  Time            CPU             Ratio
> > > > > > 2.4.19                  216.05          33%             3.19
> > > > > > 2.5.38                  887.76          8%              13.11
> > > > > > 2.5.38-mm3              105.17          70%             1.55
> > > > > > 2.5.39                  229.4           34%             3.4
> > > > > > 2.5.39-mm1              239.5           33%             3.4
> > > > >
> > > > > I think I'll set fifo_batch to 16 again...
> > > >
> > > > As not to compare oranges and apples, I'd very much like to see a
> > > > 2.5.39-mm1 vs 2.5.39-mm1 with fifo_batch=16. Con, would you do that?
> > > > Thanks!
> > >
> > > The presence of /proc/sys/vm/fifo_batch should make that pretty easy.
> >
> > Thanks. That made it a lot easier and faster, and made me curious enough
> > to create a family or very interesting results. All these are with
> > 2.5.39-mm1 with fifo_batch set to 1->16, average of three runs. The first
> > result is the unmodified 2.5.39-mm1 (fifo_batch=32).
>
> Ah excellent, thanks a lot!
>
> > io_load:
> > Kernel                  Time            CPU%            Ratio
> > 2.5.39-mm1              239.5           32              3.54
> > 2539mm1fb16             131.2           57              1.94
> > 2539mm1fb8              109.1           68              1.61
> > 2539mm1fb4              146.4           51              2.16
> > 2539mm1fb2              112.7           65              1.67
> > 2539mm1fb1              125.4           60              1.85
> >
> > What's most interesting is the variation was small until the number was
> > <8; then the variation between runs increased. Dare I say it there
> > appears to be a sweet spot in the results.
>
> Yes it's an interesting curve. What makes it interesting is that 8 is
> better than 16. Both allow one seek to be dispatched, they only differ
> in the streamed amount of data we allow to dispatch. 8 will give you
> either 1 seek, or 8*256 == 2048 sectors == 1MiB. 16 will give you 1 seek
> or 2MiB of streamed I/O.
>
> Tests with other io benchmarks need to be considered as well. And I need
> a bit of time to digest this :-). The 8 vs 16 numbers are not what I
> expected.

It would seem reasonable to me to assume it may be related to the filesystem 
in use (in this case ReiserFS). If this is the case it is possible that each 
different filesystem has a different sweetspot? (and for that matter each 
piece of hardware, each type of ata driver etc etc..)

This was performed on an ATA100 5400rpm drive running ReiserFS. I'm afraid I 
don't have the hardware to do any other comparisons of different filesystems.

> But the deadline io scheduler looks damn good in this test, if I have to
> say so myself.

Agree with you on that I can; Great job!

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9maa1F6dfvkL3i1gRAqX5AKCdYYuzvqe57tB+EjzwO2WNo0ik6QCfU0RS
9bQXpIFvSgYb5WKk+6T2NUU=
=Njny
-----END PGP SIGNATURE-----
