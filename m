Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129527AbRBLJBN>; Mon, 12 Feb 2001 04:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129946AbRBLJBE>; Mon, 12 Feb 2001 04:01:04 -0500
Received: from cs.columbia.edu ([128.59.16.20]:20383 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S129527AbRBLJAx>;
	Mon, 12 Feb 2001 04:00:53 -0500
Date: Mon, 12 Feb 2001 01:00:34 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Andrey Savochkin <saw@saw.sw.com.sg>
cc: <vido@ldh.org>, Alan Cox <alan@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: eepro100.c, kernel 2.4.1
In-Reply-To: <20010212133248.A7147@saw.sw.com.sg>
Message-ID: <Pine.LNX.4.30.0102120048160.4687-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2001, Andrey Savochkin wrote:

> I've just checked: "Sending a multicast list set command" is printed only on
> high debug levels, so Augustin might not see them.

I could have sworn that I saw the message being printed unconditionally. 
But you're right, so we're back to square one..

BTW, stalling Rx for 2 seconds is enough to trigger even NFS warnings. It 
might not be enough to show up on performance graphs, though.

> If "Receiver lock-up workaround activated" message is printed, then the
> workaround is really activated.

What's more worrying is that lately I've seen an (unrelated) report with
the workaround activated even on i82559 chips -- even though in theory the 
i82559 cannot possibly have this bug. It might be that the eeprom was 
improperly initialized, but that's something I'd expect from an OEM, not 
from Intel:

00:0d.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 09)
        Subsystem: Intel Corporation: Unknown device 2411

kernel: eth0: Intel PCI EtherExpress Pro100 82557, 00:10:A4:0E:7F:EC, IRQ 10.
kernel:   Board assembly 000695-001, Physical connectors present: RJ45
kernel:   Primary interface chip i82555 PHY #1.
kernel:   General self-test: passed.
kernel:   Serial sub-system self-test: passed.
kernel:   Internal registers self-test: passed.
kernel:   ROM checksum self-test: passed (0xdbd8681d).
kernel:   Receiver lock-up workaround activated.

This was with 2.2.18 (not my report, taken from the list).

> I doubt that the real reason is that RX bug, but periodic multicast list set
> commands may certainly affect the behavior.

Full chip re-initialization, only the descriptor lists are untouched..

> Augustin, could you send the output of `lspci' and `eepro100-diag -ee', please?
> (The latter may be taken from ftp://scyld.com/pub/diag/)

I'd be curious to see them too.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
