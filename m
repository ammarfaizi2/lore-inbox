Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbTIBM6P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 08:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbTIBM6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 08:58:15 -0400
Received: from chaos.analogic.com ([204.178.40.224]:42115 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261620AbTIBMzi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 08:55:38 -0400
Date: Tue, 2 Sep 2003 08:57:12 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Marcelo Tosatti <marcelo@parcelfarce.linux.theplanet.co.uk>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.22
In-Reply-To: <Pine.LNX.4.44.0309011743420.6008-100000@logos.cnet>
Message-ID: <Pine.LNX.4.53.0309020851300.11590@chaos>
References: <Pine.LNX.4.44.0309011743420.6008-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Sep 2003, Marcelo Tosatti wrote:

>
>
> On Tue, 26 Aug 2003, Richard B. Johnson wrote:
>
> >
> > I configured, built and booted Linux-2.4.22. There are
> > some problems.
> >
> > (1) `dmesg` fails to read the first part of the buffered
> > kernel log. I have attached two files, dmesg-20 (normal)
> > and dmesg-22 (bad). File dmesg-22 is from Linux-2.4.22
> > and dmesg-20 is from Linux-2.4.20. To save space, I
> > snip everything after 'NET4'.
> >
> > (2)  The ipx module fails to load with undefined symbols.
> > This module loads fine in Linux-2.4.20.
> >
> > depmod: *** Unresolved symbols in /lib/modules/2.4.22/kernel/net/ipx/ipx.o
> > depmod: 	unregister_8022_client
> > depmod: 	make_EII_client
> > depmod: 	register_8022_client
> > depmod: 	register_snap_client
> > depmod: 	make_8023_client
> > depmod: 	destroy_8023_client
> > depmod: 	destroy_EII_client
> > depmod: 	unregister_snap_client
>
> > (3)  When umounting the root file-system, the machine usually
> > hangs. The result is a long `fsck` on the next boot. The problem
> > seems to be that sendmail doesn't get killed during the `init 0`
> > sequence. It remains with a file open and the root file-system isn't
> > unmounted. A temporary work-round is to `ifconfig eth0 down` before
> > starting shutdown. Otherwise, sendmail remains stuck in the 'D' state.
>
> Which previous kernel didnt show this behaviour?
>

Previous kernel was linux-2.4.20. Linux-2.4.21 would never complete
a boot on my system so I gave up on that one.

> >
> > (4)  When mounting the DOS file-systems during startup, the echo
> > on the screen shows about 15 lines of white-space. This never
> > happened before. When mounting /proc, there are 6 lines of
> > white-space, also strange.
>
> Again, which kernel doesnt show that behaviour?
>

Also, I replaced linux-2.4.22/kernel/prink.c with the one from
linux-2.4.21 and it did not help the missing boot data problem.
I also changed the buffer size to 131,072 and it didn't help
either so the problem is not in printk.c, but somewhere else,
perhaps klogd.

> Thanks
>

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
On Mon, 1 Sep 2003, Marcelo Tosatti wrote:

>
>
> On Tue, 26 Aug 2003, Richard B. Johnson wrote:
>
> >
> > I configured, built and booted Linux-2.4.22. There are
> > some problems.
> >
> > (1) `dmesg` fails to read the first part of the buffered
> > kernel log. I have attached two files, dmesg-20 (normal)
> > and dmesg-22 (bad). File dmesg-22 is from Linux-2.4.22
> > and dmesg-20 is from Linux-2.4.20. To save space, I
> > snip everything after 'NET4'.
> >
> > (2)  The ipx module fails to load with undefined symbols.
> > This module loads fine in Linux-2.4.20.
> >
> > depmod: *** Unresolved symbols in /lib/modules/2.4.22/kernel/net/ipx/ipx.o
> > depmod: 	unregister_8022_client
> > depmod: 	make_EII_client
> > depmod: 	register_8022_client
> > depmod: 	register_snap_client
> > depmod: 	make_8023_client
> > depmod: 	destroy_8023_client
> > depmod: 	destroy_EII_client
> > depmod: 	unregister_snap_client
>
> > (3)  When umounting the root file-system, the machine usually
> > hangs. The result is a long `fsck` on the next boot. The problem
> > seems to be that sendmail doesn't get killed during the `init 0`
> > sequence. It remains with a file open and the root file-system isn't
> > unmounted. A temporary work-round is to `ifconfig eth0 down` before
> > starting shutdown. Otherwise, sendmail remains stuck in the 'D' state.
>
> Which previous kernel didnt show this behaviour?
>

Previous kernel was linux-2.4.20. Linux-2.4.21 would never complete
a boot on my system so I gave up on that one.

> >
> > (4)  When mounting the DOS file-systems during startup, the echo
> > on the screen shows about 15 lines of white-space. This never
> > happened before. When mounting /proc, there are 6 lines of
> > white-space, also strange.
>
> Again, which kernel doesnt show that behaviour?
>

Also, I replaced linux-2.4.22/kernel/prink.c with the one from
linux-2.4.21 and it did not help the missing boot data problem.
I also changed the buffer size to 131,072 and it didn't help
either so the problem is not in printk.c, but somewhere else,
perhaps klogd.

> Thanks
>

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


