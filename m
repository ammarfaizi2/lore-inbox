Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129624AbRBIVpK>; Fri, 9 Feb 2001 16:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129448AbRBIVpA>; Fri, 9 Feb 2001 16:45:00 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:27920 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129712AbRBIVoo>;
	Fri, 9 Feb 2001 16:44:44 -0500
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Ion Badulescu <ionut@cs.columbia.edu>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, Alan Cox <alan@redhat.com>,
        linux-kernel@vger.kernel.org, Donald Becker <becker@scyld.com>
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <Pine.LNX.4.30.0102081259090.31024-100000@age.cs.columbia.edu> <3A831313.A23EE2A1@colorfullife.com>
From: Jes Sorensen <jes@linuxcare.com>
Date: 09 Feb 2001 22:43:53 +0100
In-Reply-To: Manfred Spraul's message of "Thu, 08 Feb 2001 22:43:47 +0100"
Message-ID: <d38znfwmzq.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Manfred" == Manfred Spraul <manfred@colorfullife.com> writes:

Manfred> Ion Badulescu wrote:
>>  > > +#if defined(__ia64__) || defined(__alpha__) > > +#define
>> PKT_SHOULD_COPY(pkt_len) 1 > > +#else > > +#define
>> PKT_SHOULD_COPY(pkt_len) (pkt_len < rx_copybreak) > > +#endif >
>> [snip]
>> 
>> It's not *required* per se, as far as I know both the Alpha and
>> IA64 have handlers for unaligned access traps. *However*, copying
>> each packet is definitely better than taking an exception for each
>> packet!

Manfred> What about changing the default for rx_copybreak instead?
Manfred> Set it to 1536 on ia64 and Alpha, 0 for the rest.  tulip and
Manfred> eepro100 use that aproach.

Inefficient, my patch will make the unused code path disappear during
compilation, what you suggest results in an extra branch and unused
code.

The eepro100 and tulip drivers really should be changed to use the
same trick.

Jes
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
