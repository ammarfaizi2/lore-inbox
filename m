Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129603AbRBEIii>; Mon, 5 Feb 2001 03:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129964AbRBEIi3>; Mon, 5 Feb 2001 03:38:29 -0500
Received: from colorfullife.com ([216.156.138.34]:5125 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129603AbRBEIiS>;
	Mon, 5 Feb 2001 03:38:18 -0500
Message-ID: <3A7E6670.4AD21D20@colorfullife.com>
Date: Mon, 05 Feb 2001 09:38:08 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Thomas Stewart <T.Stewart@student.umist.ac.uk>
CC: Urban Widmark <urban@teststation.com>,
        Jonathan Morton <chromi@cyberspace.org>, linux-kernel@vger.kernel.org,
        ksa1 <ksa1@gmx.de>
Subject: Re: d-link dfe-530 tx (bug-report)
In-Reply-To: <3A7D77B5.ABF5A850@colorfullife.com> <3A7DEEB2.20915.276D09D@localhost>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Stewart wrote:
> 
> >
> > CmdReset is not instant, it may need a delay. There is also a "force
> > software reset" operation that sounds good, I assume that one also
> > could use a delay so I gave it 6ms.
> >

6 ms is quite long:
I added a reset into tx_timeout, and that function should not take more
than 1 ms or so.
Did you find something about the delay in the documentation? Is it
possible to poll for reset completion?

I know that the winbond-840 chipset resets in 4 pci cycles - perhaps the
via-rhine is also fast?

> 
> I applyed Manfred's patch but that changed nothing.
>

That's expected, my patch fixes another bug.
The NIC now recover from "Tx timeout" messages. ksa confirmed that, but
there is still a delay of a few seconds. I'll try to fix that.

> Then I applyed your patch and still changed nothing as you suspected.
> But there are regs that are different.
>
Did you run via-diag before or after loading the via-rhine module?

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
