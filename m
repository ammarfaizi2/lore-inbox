Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129160AbRA2Ukq>; Mon, 29 Jan 2001 15:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129184AbRA2Ukg>; Mon, 29 Jan 2001 15:40:36 -0500
Received: from colorfullife.com ([216.156.138.34]:44812 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129160AbRA2UkW>;
	Mon, 29 Jan 2001 15:40:22 -0500
Message-ID: <3A75D533.7F3F4019@colorfullife.com>
Date: Mon, 29 Jan 2001 21:40:19 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ingo Molnar <mingo@chiara.elte.hu>, Andrew Morton <andrewm@uow.edu.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.0, 2.4.0-ac12: APIC lock-ups
In-Reply-To: <Pine.GSO.3.96.1010129182851.29329A-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Maciej W. Rozycki" wrote:
> 
>  I'll implement an 82489DX update in a few days, but for now I'd like
> everyone interested to test the following patch as much as possible.  It
> applies to 2.4.0, 2.4.0-ac12 and 2.4.1-pre11 cleanly.
>
I'm not totally convinced that this fixes all problems:

No lockup, and but a slightly increased packet loss: every few minutes a
block of 5-10 packets is lost. Cpu load is low (~30%), I'm running 3
concurrent bw_tcp, the io apic computer is the 'server'.

IIRC my original patch caused a far higher packet loss, perhaps because
it's slower? (you wrote something about 2 r/w accesses).

Are you sure that this really fixed the bug?
Remember that switching the 'trigger mode' bit will revive the io apic.

It's possible that 
* the io apic still locks up.
* but now {en,dis}able_irq() switches the 'trigger mode' bit, and thus
resets the io apic after a few msec --> a few lost packets.

It's far better than before, but I assume the bug is hidden, not fixed.

I'll make additional tests.

Send the patch to Linus - it makes ne2k cards usable with 2.4+io apic.

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
