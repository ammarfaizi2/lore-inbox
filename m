Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264659AbUEJMQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264659AbUEJMQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 08:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264663AbUEJMQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 08:16:27 -0400
Received: from chaos.analogic.com ([204.178.40.224]:23688 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264659AbUEJMQC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 08:16:02 -0400
Date: Mon, 10 May 2004 08:17:35 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Shobhit Mathur <shobhitmmathur@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: PCI excessive retry error
In-Reply-To: <20040510113303.20724.qmail@web51003.mail.yahoo.com>
Message-ID: <Pine.LNX.4.53.0405100757470.28174@chaos>
References: <20040510113303.20724.qmail@web51003.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2004, Shobhit Mathur wrote:

> Hello,
>
> I have a situation in which sending ioctls from a user
> application to an HBA at the same time as active I/Os
> running on the same card causes a critical error as -
> PCI excessive retry error.
>
> I would like to know what can be the causes of such a
> problem and what type of solution can resolve such
> problems.....?
>
> - Thank you
>

How do you know? The PCI/Bus transparently retries. What
facillity reports the error?  In any event, if the PCI/Bus
hasn't been destroyed, the problem is caused by the failure
of some driver to set the cache-line size and/or the
latency timer. For ix86 machines the cache-line size
is "8" (8 longwords). Some software may mistakenly
set it to 32 because the author didn't understand the
documentation. A latency timer of 64 or lower, and a
cache-line size of 8 should solve your problems. These
problems don't show up unless the PCI device is a bus-master.

I mentioned a "broken bus" in the beginning. Some new
PCI boards are not 5-volt tolerant. If you plug them into
the PCI bus of some motherboards (Intel 865PE chipset),
The Intel D865PERL, for one, the PCI/Bus will get blown.
Same with the MS-6585 (648 MAX board). I blew up several
boards by plugging 3.5 volt PCI cards into the 5 volt
bus. According to the rules, it's supposed to work unless
the PCI slots have "Cadium Yellow" or "Brilliant Blue"
keying plugs (I kid you not, it's in the PCI specs).

Anyway, you get to eat a few US$150 boards if you are not
careful.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5557.45 BogoMips).
            Note 96.31% of all statistics are fiction.


