Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129084AbRDNQX4>; Sat, 14 Apr 2001 12:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132220AbRDNQXr>; Sat, 14 Apr 2001 12:23:47 -0400
Received: from dystopia.lab43.org ([209.217.122.210]:49363 "EHLO
	dystopia.lab43.org") by vger.kernel.org with ESMTP
	id <S129084AbRDNQXg>; Sat, 14 Apr 2001 12:23:36 -0400
Date: Sat, 14 Apr 2001 12:21:34 -0400 (EDT)
From: Rod Stewart <stewart@dystopia.lab43.org>
To: Manfred Spraul <manfred@colorfullife.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 8139too: defunct threads
In-Reply-To: <002e01c0c4eb$5854b940$5517fea9@local>
Message-ID: <Pine.LNX.4.33.0104141219450.11838-100000@dystopia.lab43.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 14 Apr 2001, Manfred Spraul wrote:

> >> Ah. Of course. All (or most) kernel initialisation is
> >> done by PID 1. Search for "kernel_thread" in init/main.c
> >>
> >> So it seems that in your setup, process 1 is not reaping
> >> children, which is why this hasn't been reported before.
> >> Is there something unusual about your setup?
>
> > I found the difference which causes this. If I build my kernel with
> > IP_PNP (IP: kernel level autoconfiguration) support I get a defunt
> > thread for each 8139too device. If I don't build with IP_PNP
> > support I don't get any, defunct ethernet threads.
>
> Does init(8) reap children that died before it was spawned? I assume
> that the defunct tasks were there _before_ init was spawned.
>
> Perhaps init() [in linux/init/main.c] should reap all defunct tasks
> before the execve("/sbin/init").
>
> I've attached an untested patch, could you try it?

Yes, that fixes my problem.  No more defunct eth? processes when IP_PNP is
compiled in.  With the fix you said to the patch; replacing curtask with
current.

Thanks,
-Rms

