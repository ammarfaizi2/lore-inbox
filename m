Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276594AbRJCR1m>; Wed, 3 Oct 2001 13:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276591AbRJCR1d>; Wed, 3 Oct 2001 13:27:33 -0400
Received: from chiara.elte.hu ([157.181.150.200]:60936 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S276589AbRJCR1N>;
	Wed, 3 Oct 2001 13:27:13 -0400
Date: Wed, 3 Oct 2001 19:25:18 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ben Greear <greearb@candelatech.com>, jamal <hadi@cyberus.ca>,
        <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, <netdev@oss.sgi.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.LNX.4.33.0110030920500.9427-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0110031920410.9973-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Oct 2001, Linus Torvalds wrote:

> [...] I would not be surprised if Ingo finds that trying to put the
> machine under heavy disk load with multiple disk controllers might
> also cause interrupt mitigation, which would be unacceptably BAD.

well, just tested my RAID testsystem as well. I have not tested heavy
IO-related IRQ load with the patch before (so it was not tuned for that
test in any way), but did so now: an IO test running on 12 disks, (5 IO
interfaces: 3 SCSI cards and 2 IDE interfaces) producing 150 MB/sec block
IO load and a fair number of SCSI and IDE interrupts, did not trigger the
overload code. I started the network overload utility during this test,
and the code detected overload on the network interrupt (and only on the
network interrupt). IO load is still high (down to 130 MB/sec), while a
fair amount of networking load is handled as well. (While there certainly
are higher IO loads on some Linux boxes, mine should be above the average
IO traffic.)

	Ingo

