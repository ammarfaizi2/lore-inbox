Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129148AbQKOJjr>; Wed, 15 Nov 2000 04:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129516AbQKOJj1>; Wed, 15 Nov 2000 04:39:27 -0500
Received: from chiara.elte.hu ([157.181.150.200]:58638 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129148AbQKOJjR>;
	Wed, 15 Nov 2000 04:39:17 -0500
Date: Wed, 15 Nov 2000 11:19:10 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: Andrew Morton <andrewm@uow.edu.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [prepatch] removal of oops->printk deadlocks
In-Reply-To: <3A1115C5.4C04CD6A@uow.edu.au>
Message-ID: <Pine.LNX.4.21.0011151114130.1253-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 14 Nov 2000, Andrew Morton wrote:

> It also changes the x86 NMI oopser so that it no longer shuts the
> console up after the first NMI oops.  Instead, each CPU is allowed
> to print out NMI diagnostics a single time per reboot.

this is not how the NMI oopser works. It does *not* shut down the console
- you can still see everything in 'dmesg'. If you want to see it on the
console again, you can do 'dmesg -n 8'. Adding a 'once per reboot'
restriction is unreasonable - there are user-space applications that can
be terminated via the NMI-oopser safely. In 99% of the cases it's the
first oops that counts, and most people do not have serial console set up,
so writing the first oops down from screen is important.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
