Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbTEVWbE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 18:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263353AbTEVWbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 18:31:04 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:30650 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263338AbTEVWbC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 18:31:02 -0400
Date: Fri, 23 May 2003 00:43:51 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Julien Oster <lkml@mf.frodoid.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.69-mm8] ide_dmaq_intr: stat=40, not expected
In-Reply-To: <frodoid.frodo.874r3m39ae.fsf@usenet.frodoid.org>
Message-ID: <Pine.SOL.4.30.0305230040540.27109-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

Can you compile without IDE TCQ and tell whats the difference?

Regards,
--
Bartlomiej

On Fri, 23 May 2003, Julien Oster wrote:

> Hello,
>
> I already mentioned it in another thread, but here again, more
> complete.
>
> Booting my workstation with 2.5.69-mm8 works, but I get the following
> message many times per second:
>
> May 22 23:34:01 frodo kernel: ide_dmaq_intr: stat=42, not expected
> May 22 23:34:01 frodo kernel: ide_dmaq_intr: stat=40, not expected
> May 22 23:34:01 frodo last message repeated 34 times
>
> It's mostly stat=40, sometimes stat=42. Look at the time: it's really
> very often. (more often than 34 times, there are other normal messages
> in between)
>
> The harddisks are attached on a Promise PDC20276 onboard RAID
> controller, but it's only used as an IDE controller. However, I have
> Linux RAID Partitions on the disks (all mounted filesystems are). Most
> are RAID 1, one is RAID 0, but the latter isn't accessed very often.
>
> Even more interesting: after a while, at least /var/log/kern.log
> (where the kernel messages are logged to) gets jammed. Here's
> something pasted right away from "less /var/log/kern.log":
>
> May 22 23:34:32 frodo kernel: ide_dmaq_intr: stat=40, not expected
> ^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
> ^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@
> [...]
> <A0><81><CA>^Y^A<9A>|!#n:<C8><F6><F5>^E<AF><EE><B5>@^D<A5>]^L<90><C0><98>=f<F3>A
> `<C7>^Y^F<A0>%H;4<9A>^L<E9><FA><BE><AD><DD><AA>~<B5>^U<FB>[^GB<83><AC>^@w<B5>eMa
> y 22 23:41:23 frodo kernel: klogd 1.4.1#11, log source = /proc/kmsg started.
>
> I cutted it down to a few lines, however the binary garbage is quite a
> lot. Obviously, something got jammed for good, because as you can see,
> the next readable line is from the (fine running) 2.4.21-rc2 kernel,
> which I booted immediately afterwards.
>
> Note however, that I didn't do a clean shutdown, since I forgot to
> include my input devices into the kernel (ouch). I just pressed
> reset. The fsck done by the working 2.4.21-rc2 kernel afterwards also
> ate up a configuration file from tomcat (unused inode, cleaned).
>
> All mirrored arrays were reconstructing right after booting
> 2.5.69-mm8, since they weren't clean before. I pressed reset before
> the reconstruction got finished (I had no input device and the
> ide_dmaq_intr-message actually scared me).
>
> So, taking the unclean shutdown and the reconstructing RAID into
> account, the jammed files may not be a cause of the strange message
> the kernel gives me.
>
> I included my .config and an "lspci -v" output with this mail. Please
> note that the latter one was created with my currently running
> 2.4.21-rc2 kernel, but that shouldn't matter I believe.
>
> Regards,
> Julien

