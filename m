Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275681AbRJAWp3>; Mon, 1 Oct 2001 18:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275672AbRJAWpJ>; Mon, 1 Oct 2001 18:45:09 -0400
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:2834
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S275670AbRJAWpC>; Mon, 1 Oct 2001 18:45:02 -0400
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200110012226.f91MQQe02638@www.hockin.org>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
To: mingo@elte.hu
Date: Mon, 1 Oct 2001 15:26:26 -0700 (PDT)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        kuznet@ms2.inr.ac.ru (Alexey Kuznetsov),
        andrea@suse.de (Andrea Arcangeli), sim@netnation.com (Simon Kirby)
In-Reply-To: <Pine.LNX.4.33.0110012305350.3280-200000@localhost.localdomain> from "Ingo Molnar" at Oct 02, 2001 12:16:06 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - a little utility written by Simon Kirby proved that no matter how much
>   softirq throttling, it's easy to lock up a pretty powerful Linux
>   box via a high rate of network interrupts, from relatively low-powered
>   clients as well. 2.4.6, 2.4.7, 2.4.10 all lock up. Alexey said it as
>   well that it's still easy to lock up low-powered Linux routers via more
>   or less normal traffic.

We proved this a year+ ago.  We've got some code brewing to do fair sharing
of IRQs for heavy load situations.  I don't have all the details, but
eventually...

> i've tested the patch on both UP, SMP, XT-PIC and APIC systems, it
> correctly limits network interrupt rates (and other device interrupt
> rates) to the given limit. I've done stress-testing as well. The patch is
> against 2.4.11-pre1, but it applies just fine to the -ac tree as well.

Our solution/needs are slightly different - we want to service as many
interrupts as possible and do as much network traffic as possible, and
interactive-tasks be damned.
