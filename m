Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130836AbRAaJUF>; Wed, 31 Jan 2001 04:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131015AbRAaJTz>; Wed, 31 Jan 2001 04:19:55 -0500
Received: from pop.gmx.net ([194.221.183.20]:60554 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S130836AbRAaJTo>;
	Wed, 31 Jan 2001 04:19:44 -0500
Message-ID: <3A77D89C.20E0AC72@gmx.de>
Date: Wed, 31 Jan 2001 10:19:25 +0100
From: Martin Rauh <martin.rauh@gmx.de>
X-Mailer: Mozilla 4.6 [de] (WinNT; U)
X-Accept-Language: de
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Packet loss in IP/UDP Stack?
In-Reply-To: <3A71BB68.21B998AB@gmx.de> <20010126190856.A19098@gruyere.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The UDP packet loss went away by setting the rmem_max and rmem_default
in /proc/sys/net/core on the receiving linux box to about 80 percent of the
size of the
transfered file (~50MB).

Many thanks for the fast help!

greetings,

Martin Rauh


Andi Kleen wrote:

> On Fri, Jan 26, 2001 at 07:01:12PM +0100, Martin Rauh wrote:
> > Hi folks,
> >
> > It seems that we are loosing packets in the UDP stack.
> > Somebody might think that this is not astonishing, but
> > the packets are not lost at the network layer. They seem to get
> > lost in the IP/UDP Layer of the receiving box.
> >
> > We have got the following configuration:
> > Two linux boxes (P4, 733 MHz, 256 MB RAM, kernel 2.4.0)
> > are directly connected with two syskonnect sk98xx
> > gigabit ethernet cards. We are sending a file from one host to the other
> >
> > with UDP. About half of the file is lost in the receiving application.
> > But according to the statistics in /proc/net/dev no errors (fifo, frame,
> > dropped...)
> > occured in the network layer. Even the transmitted and received
> > data at the network layer (tx-bytes, -packets) are identical
> > to the amount of the transfered file (plus network overhead).
> >
> > Doas anybody know where the loss occurs? Is there a loss at the
> > network layer or in the higher protocol layers?
>
> UDP by default has 64K buffer and drops packets when it overflows.
> You can check that using netstat -s.
> You can increase it use the SO_{SND,RCV}BUF socket options and/or the
> net/core/[rw]mem_* sysctls.
>
> -Andi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
