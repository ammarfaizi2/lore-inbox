Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129903AbRALVb7>; Fri, 12 Jan 2001 16:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135268AbRALVbw>; Fri, 12 Jan 2001 16:31:52 -0500
Received: from colorfullife.com ([216.156.138.34]:62213 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129903AbRALVbo>;
	Fri, 12 Jan 2001 16:31:44 -0500
Message-ID: <3A5F77B1.90AE31CE@colorfullife.com>
Date: Fri, 12 Jan 2001 22:31:29 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Frank de Lange <frank@unternet.org>
CC: mingo@elte.hu, Linus Torvalds <torvalds@transmeta.com>,
        dwmw2@infradead.org, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardwarerelated?
In-Reply-To: <Pine.LNX.4.30.0101122136180.2772-100000@e2> <3A5F6F07.88564D5B@colorfullife.com> <20010112220729.D27809@unternet.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank de Lange wrote:
> 
> On Fri, Jan 12, 2001 at 09:54:31PM +0100, Manfred Spraul wrote:
> > I have found one combination that doesn't hang with the unpatched
> > 8390.c, but network throughput is down to 1/2. I hope that's due to the
> > debugging changes.
> 
> Hm, could it be that the fact that network throughput is halved causes the
> problem not to appear?

No. The problem is still there. But now lots of losts packets instead of
a total hang.

Due to the modification of mask_irq now disable_irq_nosync and
enable_irq act as if I would press SysRQ+q every millisecond, and thus
the io apic is immediatly reset when it got stuck.

Btw, my initial assumption about EOI to masked interrupt must be wrong:
2.2 always first masks the irq, then it sends the EOI, and 2.2 doesn't
hang.

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
