Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265607AbRGCIbw>; Tue, 3 Jul 2001 04:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265605AbRGCIbm>; Tue, 3 Jul 2001 04:31:42 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:15784 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S265607AbRGCIb2>;
	Tue, 3 Jul 2001 04:31:28 -0400
Message-ID: <3B4182DD.FCDD8DDE@mandrakesoft.com>
Date: Tue, 03 Jul 2001 04:31:25 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Woodhouse <dwmw2@infradead.org>, Jes Sorensen <jes@sunsite.dk>,
        linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: [RFC] I/O Access Abstractions
In-Reply-To: <3963.994148157@warthog.cambridge.redhat.com> <3B4180BB.ED7B45F@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I also point out that using ioremap for PIO adds flexibility while
keeping most drivers relatively unchanged.  Everyone uses a base address
anyway, so whether its obtained directly (address from PCI BAR) or
indirectly (via ioremap), you already store it and use it.

Further, code lacking ioremap for PIO (100% of PIO code, at present)
does not require a flag day.  Drivers can be transitioned as foreign
arches start supporting ioremap for PIO... if ioremap is no-op on x86,
drivers continue to work on x86 before and after the update.  Assuming a
stored not hardcoded base address (common case), the only change to a
driver is in probe and remove, nowhere else.

-- 
Jeff Garzik      | "I respect faith, but doubt is
Building 1024    |  what gives you an education."
MandrakeSoft     |           -- Wilson Mizner
