Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbUCANXN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 08:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbUCANXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 08:23:12 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:62215 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S261263AbUCANXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 08:23:08 -0500
Subject: Re: Worrisome IDE PIO transfers...
From: Christophe Saout <christophe@saout.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jeff Garzik <jgarzik@pobox.com>, Matt Mackall <mpm@selenic.com>,
       Jens Axboe <axboe@suse.de>, Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200403010147.47808.bzolnier@elka.pw.edu.pl>
References: <4041232C.7030305@pobox.com> <20040229015041.GQ3883@waste.org>
	 <40415152.8040205@pobox.com>  <200403010147.47808.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Message-Id: <1078147381.7497.15.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 01 Mar 2004 14:23:02 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo, den 01.03.2004 schrieb Bartlomiej Zolnierkiewicz um 01:47:

> http://www.kernel.org/pub/linux/kernel/people/bart/dm-byteswap-2.6.4-rc1.patch
> 
> Guess what's this? :)

The thieves... they've stolen my precioussss. ;)

> It is simply a stripped down dm-crypt.c, so all credits go to Christophe.
> I have tested it quickly with loop device and it seems to work.

Yes, it's not that complicated. Looks good.
BTW: You don't need the km_types voodoo as the conversion routine is
never called from a softirq context and you are allowed (but should try
to avoid it) to sleep. You could add a conditional reschedule after
kunmapping the buffers to keep the latency low on non-preempt kernels.

BTW: I've got some cleanups and a small fix in Andrew's latest tree
(using a #define for the log prefix and I bvec array thingy).


