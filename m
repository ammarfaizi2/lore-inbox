Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbTJRMw4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 08:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbTJRMw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 08:52:56 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:23245 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261595AbTJRMwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 08:52:53 -0400
Date: Sat, 18 Oct 2003 14:52:52 +0200
From: Jens Axboe <axboe@suse.de>
To: Jan Rychter <jan@rychter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] laptop mode
Message-ID: <20031018125252.GQ1128@suse.de>
References: <3F856A7E.2010607@pobox.com> <Pine.LNX.4.44.0310091109010.3040-100000@logos.cnet> <20031009141143.GF1232@suse.de> <m2ekxb7isq.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2ekxb7isq.fsf@tnuctip.rychter.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 17 2003, Jan Rychter wrote:
> >>>>> "Jens" == Jens Axboe <axboe@suse.de> writes:
>  Jens> On Thu, Oct 09 2003, Marcelo Tosatti wrote:
>  >> On Thu, 9 Oct 2003, Jeff Garzik wrote:
>  > Linux Kernel Mailing List wrote:
>  > > ChangeSet 1.1150.1.52, 2003/10/08 10:49:45-03:00, axboe@suse.de
>  > > 	[PATCH] laptop mode
>  > >
>  > > 	Hi Marcelo,
>  > >
>  > > 	Lots of people have been using this patch with great success,
>  > > 	and it's been in the SuSE kernel for some months now too. It is
>  > > 	also in the -benh ppc tree
>  > >
>  > > 	Basically, it introduces a write back mode of dirty and journal
>  > > 	data that is more suitable for laptops. At the block layer end,
>  > > 	it schedules write out of dirty data after the disk has been
>  > > 	idle for 5 seconds.
>  > >
>  > > 	Laptop mode can be switched on and off with
>  > > 	/proc/sys/vm/laptop_mode.  There is also a block_dump sysctl,
>  > > 	which if enabled will dump who dirties and writes out data. This
>  > > 	is very helpful in pinning down who is causing unnecessary
>  > > 	writes to the disk.
>  >
>  > Red Hat just dropped this patch since it was suspected of data
>  > corruption ;-(
>  >>
>  >> Uh, oh... Jens?
> 
>  Jens> See my previous mail. I don't see any problems with it, and I've
>  Jens> certainly not heard of (or experienced myself) problems with the
>  Jens> patch.  I'm waiting for Jeff to expand on his mail, surely he/RH
>  Jens> must know more about this issue.
> 
> FWIW, I've been using laptop-mode for a long time now, with no problems
> whatsoever. It's a great addition and really helps laptop users.

Glad to hear that.

> On a related note, a very desirable feature would be to be able to trace
> which processes do I/O. Unfortunately, Linux distributions aren't very
> well adapted to laptops and many applications are way too
> "trigger-happy" when it comes to hard drive accesses. I guess most
> developers don't use laptops and just assume that they can write or
> read data at will. It is very difficult to trace the culprits when your
> HD light goes on every couple of seconds.

You do know that the laptop-mode patch included a feature to help with
just that very problem, block_dump? If you do

echo "1" > /proc/sys/vm/block_dump

(shut down klogd first), it will tell you which process caused the hd
activity, either directly or by dirtying a page of data.

-- 
Jens Axboe

