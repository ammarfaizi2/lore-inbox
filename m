Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278629AbRJ1SPf>; Sun, 28 Oct 2001 13:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278617AbRJ1SPZ>; Sun, 28 Oct 2001 13:15:25 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43789 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278629AbRJ1SPQ>; Sun, 28 Oct 2001 13:15:16 -0500
Subject: Re: xmm2 - monitor Linux MM active/inactive lists graphically
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sun, 28 Oct 2001 18:22:00 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        zlatko.calusic@iskon.hr (Zlatko Calusic), axboe@suse.de (Jens Axboe),
        marcelo@conectiva.com.br (Marcelo Tosatti), linux-mm@kvack.org,
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <Pine.LNX.4.33.0110280945150.7360-100000@penguin.transmeta.com> from "Linus Torvalds" at Oct 28, 2001 09:59:14 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15xuZM-0008W5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In contrast, the -ac logic says roughly "Who the hell cares if the driver
> can merge requests or not, we can just give it thousands of small requests
> instead, and cap the total number of _sectors_ instead of capping the
> total number of requests earlier"

If you think about it the major resource constraint is sectors - or another
way to think of it "number of pinned pages the VM cannot rescue until the
I/O is done". We also have many devices where the latency is horribly
important - IDE is one because it lacks sensible overlapping I/O. I'm less
sure what the latency trade offs are. Less commands means less turnarounds
so there is counterbalance.

In the case of IDE the -ac tree will do basically the same merging - the
limitations on IDE DMA are pretty reasonable. DMA IDE has scatter gather
tables and is actually smarter than many older scsi controllers. The IDE
layer supports up to 128 chunks of up to just under 64Kb (should be 64K
but some chipsets get 64K = 0 wrong and its not pretty)

> In my opinion, the -ac logic is really bad, but one thing it does allow is
> for stupid drivers that look like high-performance drivers. Which may be
> why it got implemented.

Well I'm all for making dumb hardware go as fast as smart stuff but that
wasn't the original goal - the original goal was to fix the bad behaviour
with the base kernel and large I/O queues to slow devices like M/O disks.

