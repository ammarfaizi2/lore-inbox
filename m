Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285018AbRLRUWy>; Tue, 18 Dec 2001 15:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284958AbRLRUWn>; Tue, 18 Dec 2001 15:22:43 -0500
Received: from cs182072.pp.htv.fi ([213.243.182.72]:12672 "EHLO
	cs182072.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S284931AbRLRUW2>; Tue, 18 Dec 2001 15:22:28 -0500
Message-ID: <3C1FA558.E889A00D@welho.com>
Date: Tue, 18 Dec 2001 22:21:44 +0200
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: Mika.Liljeberg@nokia.com, davem@redhat.com, linux-kernel@vger.kernel.org,
        sarolaht@cs.helsinki.fi
Subject: Re: TCP LAST-ACK state broken in 2.4.17-pre2 [NEW DATA]
In-Reply-To: <200112181837.VAA10394@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> 
> Hello!
> 
> > from the SYN exchange (about 200 ms). So, something is wrong?
> 
> Well, the guess was right and this is pleasant.

Yes. We also saw a case, where the RTO was quite high but not quite 120,
so we got exactly one retransmission.

> The only minor :-) question remained is to guess how rto could happen
> to be at this value. I will think. Well, if you have some guesses,
> please, tell me.

Sorry, I'm not really trying to debug Linux so I haven't given it much
thought. We're exercising retransmission algorithms with a packet loss
ratio of 5% if that's any help.

> Is this intel btw?

It's ARM in little endian mode.

> I just see that other side
> sends bogus misaligned tcp options... not a problem, but it can
> be reason of funnyies with some probability.

Heh, they're not bogus, just differently aligned. :) This is an
implementation where packet processing latency is not highest 
item on the list of optimization targets.

Now that you mention it, tcp_parse_options() in input.c seems to expect
that the timestamps are word aligned, which is not the case here, and a
false assumption in any case. I would have expected a bus error for
that, unless the pointer cast generates code that magically word aligns
the resulting pointer...

Cheers,

	MikaL
