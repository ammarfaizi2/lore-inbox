Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130056AbRBHVoM>; Thu, 8 Feb 2001 16:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131306AbRBHVn5>; Thu, 8 Feb 2001 16:43:57 -0500
Received: from colorfullife.com ([216.156.138.34]:33037 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130056AbRBHVnw>;
	Thu, 8 Feb 2001 16:43:52 -0500
Message-ID: <3A831313.A23EE2A1@colorfullife.com>
Date: Thu, 08 Feb 2001 22:43:47 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Ion Badulescu <ionut@cs.columbia.edu>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>, Alan Cox <alan@redhat.com>,
        linux-kernel@vger.kernel.org, jes@linuxcare.com,
        Donald Becker <becker@scyld.com>
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <Pine.LNX.4.30.0102081259090.31024-100000@age.cs.columbia.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ion Badulescu wrote:
> 
> > > +#if defined(__ia64__) || defined(__alpha__)
> > > +#define PKT_SHOULD_COPY(pkt_len)       1
> > > +#else
> > > +#define PKT_SHOULD_COPY(pkt_len)       (pkt_len < rx_copybreak)
> > > +#endif
> >
> [snip]
> 
> It's not *required* per se, as far as I know both the Alpha and IA64 have
> handlers for unaligned access traps. *However*, copying each packet is
> definitely better than taking an exception for each packet!
>

What about changing the default for rx_copybreak instead?
Set it to 1536 on ia64 and Alpha, 0 for the rest.
tulip and eepro100 use that aproach.

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
