Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263705AbTEFNgA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 09:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263711AbTEFNf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 09:35:59 -0400
Received: from chaos.analogic.com ([204.178.40.224]:30849 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263705AbTEFNf6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 09:35:58 -0400
Date: Tue, 6 May 2003 09:50:27 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Nir Livni <nir_l3@netvision.net.il>
cc: linux-kernel@vger.kernel.org
Subject: Re: shared objects, ELFs and memory usage
In-Reply-To: <001401c313db$767bdb60$ded1b3d4@pinguin>
Message-ID: <Pine.LNX.4.53.0305060938260.5836@chaos>
References: <001401c313db$767bdb60$ded1b3d4@pinguin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 May 2003, Nir Livni wrote:

> Hi all,
> If this is not the mailing list to ask this question - please let me know
> where should I ask it.
>
> I have an executable whose size is almost 2MB, and it uses a shared object
> that is almost 2MB.
> when I run the process, I see (using "top") that the amount of "used memory"
> raises with 4MB. (make sence...). the process seem to share 2MB ("shared"
> column).
>
> When the process forks, it seems that the amount of "used memory" raises
> with 4MB again.
>
> Does it mean the shared object is not really shared ? That doesn't make
> sence...
>
> Help is appreciated.
> Please CC me because I am not subscribed.
>
> Thanks,
> Nir

If your shared object is truly a shared object, then it is shared.
Use `strace` to trace the startup of your program. You should
see it mmap() some portion of your shared object. You can also
put a pause() in you program, then look at /proc/<PID>/maps and
see what your program has memapped.

Note that merely linking some object files together does not
create a shared object! You need to compile any 'C' code
with the '-shared' parameter, and any assembly code needs
to not use COMM variables. Then you need to link them as

	ld -warn-common -O2 -shared -Map Shared.Map $(OBJS) -o $(SLIB)

...where OBJS is you list of object files, and SLIB is your new
shared library.

You can inspect Shared.Map to see what is in the library. When
you link against the shared library, you need to tell the linker
where to find the runtime file, i.e., you need to use -rpath.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

