Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273474AbRIUMOz>; Fri, 21 Sep 2001 08:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273470AbRIUMOr>; Fri, 21 Sep 2001 08:14:47 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9747 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273477AbRIUMOd>; Fri, 21 Sep 2001 08:14:33 -0400
Subject: Re: [reiserfs-list] Re: [PATCH] Significant performace improvements on reiserfs systems
To: Nikita@namesys.com (Nikita Danilov)
Date: Fri, 21 Sep 2001 13:18:31 +0100 (BST)
Cc: akpm@zip.com.au (Andrew Morton), george@mvista.com (george anzinger),
        andrea@suse.de (Andrea Arcangeli), rml@tech9.net (Robert Love),
        Dieter.Nuetzel@hamburg.de (Dieter =?iso-8859-1?Q?N=FCtzel?=),
        mason@suse.com (Chris Mason), kuib-kl@ljbc.wa.edu.au (Beau Kuiper),
        linux-kernel@vger.kernel.org (Linux Kernel List),
        reiserfs-list@namesys.com (ReiserFS List)
In-Reply-To: <15275.2374.92496.536594@gargle.gargle.HOWL> from "Nikita Danilov" at Sep 21, 2001 01:32:54 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15kPGJ-0008EU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In Solaris, before spinning on a busy spin-lock, thread checks whether
> spin-lock holder runs on the same processor. If so, thread goes to sleep
> and holder wakes it up on spin-lock release. The same, I guess is going


> for interrupts that are served as separate threads. This way, one can
> re-schedule with spin-locks held.

This is one of the things interrupt handling by threads gives you, but the
performance cost is not nice. When you consider that ksoftirqd when it
kicks in (currently far too often) takes up to 10% off gigabit ethernet
performance, you can appreciate why we don't want to go that path.

Our spinlock paths are supposed to be very small and predictable. Where 
there is sleeping involved we have semaphores.

As lockmeter shows we still have a few io_request_lock cases at least where
we lock for far too long

Alan
