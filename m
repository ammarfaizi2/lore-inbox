Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276340AbRJCOxW>; Wed, 3 Oct 2001 10:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276344AbRJCOxM>; Wed, 3 Oct 2001 10:53:12 -0400
Received: from chiara.elte.hu ([157.181.150.200]:41224 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S276340AbRJCOw7>;
	Wed, 3 Oct 2001 10:52:59 -0400
Date: Wed, 3 Oct 2001 16:51:02 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: jamal <hadi@cyberus.ca>
Cc: <linux-kernel@vger.kernel.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, <netdev@oss.sgi.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Simon Kirby <sim@netnation.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.GSO.4.30.0110030819540.4495-100000@shell.cyberus.ca>
Message-ID: <Pine.LNX.4.33.0110031528370.6272-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Oct 2001, jamal wrote:

> You dont need the patch for 2.4 to work against any lockups. And
> infact i am suprised that you observe _any_ lockups on a PIII which
> are not observed on my PII. [...]

as mentioned before, it's dead easy to lock up current kernels via high
enough networking irq/softirq load:

    box:~> wc -l udpspam.c
    131 udpspam.c

    box:~> ./udpspam 10.0.3.4

10.0.3.4 is running vanilla 2.4.11-pre2 UP, a 466 MHz PII box with enough
RAM, using eepro100. The system effectively locks up - even in the full
knowledge of what is happening, i can hardly switch consoles, let alone do
anything like ifconfig eth0 down to fix the lockup. Until this kind of
load is present the only option is to power-cycle the box. SysRq does not
work.

(ask Simon for the code.)

and frankly, this has been well-known for a long time - it's just since
Simon sent me this testcode that i realized how trivial it is. Alexey told
me about Linux routers effectively locking up if put under 100 mbit IRQ
load more than a year ago, when i first tried to fix softirq latencies. I
think if you are doing networking patches then you should be aware of it
as well.

your refusal to accept this problem as an existing and real problem is
really puzzling me.

	Ingo

