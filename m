Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130999AbQKJOy2>; Fri, 10 Nov 2000 09:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131077AbQKJOyT>; Fri, 10 Nov 2000 09:54:19 -0500
Received: from [62.254.209.2] ([62.254.209.2]:23791 "EHLO cam-gw.zeus.co.uk")
	by vger.kernel.org with ESMTP id <S130999AbQKJOyD>;
	Fri, 10 Nov 2000 09:54:03 -0500
Date: Fri, 10 Nov 2000 14:54:00 +0000 (GMT)
From: Ben Mansell <ben@zeus.com>
To: "David S. Miller" <davem@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Missing ACKs with Linux 2.2/2.4?
In-Reply-To: <200011101146.DAA15898@pizda.ninka.net>
Message-ID: <Pine.LNX.4.30.0011101435140.11937-100000@artemis.cam.zeus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2000, David S. Miller wrote:

>    Date: Fri, 10 Nov 2000 11:49:13 +0000 (GMT)
>    From: Ben Mansell <ben@zeus.com>
>
>    (client-side tcpdump)
>  ...
>    11:05:32.547518 cobalt-box.echo > artemis.39061: P 1:1449(1448) ack 1602 win 31856 <nop,nop,timestamp 0 76152422> (DF)
>                 ^^^^^^^^^^^
>
>    (server-side)
>  ...
>     11:05:32.437733 cobalt-box.echo > artemis.39061: P 1:1449(1448) ack 1602 win 31856 <nop,nop,timestamp 0 76152422> (DF)
>                  ^^^^^^^^^^^
>
> Wheee... zero timestamp from Cobalt box.  Artemis (correctly) drops
> this packet (due to PAWS test because a zero timestamp is "older" than
> the most recent timestamp Artemis saw from cobalt-box).  Upgrade it's
> kernel and retest :-)

Bingo! Thanks very much for spotting this... yup, looks like the cobalt
box was at fault all along, and the clients that 'worked' were indeed
ignoring the timestamping.

The cobalt machines have now had a kernel upgrade (only to 2.2.14, thats
the most recent that Cobalt provide...), and the problem has
disappeared.


Thanks once more,

Ben

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
