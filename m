Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129657AbRBMAMh>; Mon, 12 Feb 2001 19:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129752AbRBMAM1>; Mon, 12 Feb 2001 19:12:27 -0500
Received: from mailgate.bridgetrading.com ([62.49.201.178]:1034 "EHLO 
	directcommunications.net") by vger.kernel.org with ESMTP
	id <S129657AbRBMAMU>; Mon, 12 Feb 2001 19:12:20 -0500
Date: Tue, 13 Feb 2001 00:13:53 +0000 (GMT)
From: Chris Funderburg <chris@Funderburg.com>
To: Jérôme Augé <jauge@club-internet.fr>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: opl3sa not detected anymore
In-Reply-To: <3A8873F3.772D75E7@club-internet.fr>
Message-ID: <Pine.LNX.4.30.0102122359150.1412-100000@pikachu.bti.com>
X-Unexpected-Header: Hello!!!
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well what do you know...
I added isapnp=0 and it worked.

<OPL3-SA3> at 0x370
<MS Sound System (CS4231)> at 0x534 irq 5 dma 1,0
<MPU-401 0.0  Midi interface #1> at 0x330 irq 5 dma -1,0

The dma and the MSS address (0x534) looks odd, but at least it
seems to play now.

And no, AFAIK, this driver has never been able to detect PNP settings.
If you try to run it without them, you get this:

opl3sa2: io, mss_io, irq, dma, and dma2 must be set

Thanks for your help!

CF


On Tue, 13 Feb 2001, Jérôme Augé wrote:

> Chris Funderburg wrote:
> > following in /etc/modules.conf:
> >
> > alias sound-slot-0 opl3sa2
> > options sound dmabuf=1
> > alias midi opl3
> > options opl3 io=0x388
> > options opl3sa2 mss_io=0x530 irq=5 dma=1 dma2=0 mpu_io=0x330 io=0x370
> >
> > The midi works fine, but 'modprobe sound' reports:
> >
> > opl3sa2: No cards found
> > opl3sa2: 0 PnP card(s) found.
> >
> > If the settings above look ok, then how can help debug it?
>
> Try to add "isapnp=0" to the opl3sa2 options list :
>
> opl3sa2 mss_io=0x530 irq=5 dma=1 dma2=0 mpu_io=0x330 io=0x370 isapnp=0
>
> I had the same problem and adding isapnp=0 solved it, but PNP isn't
> supposed to automaticaly detect those options ?
>
>

-- 
... Any resemblance between the above views and those of my employer,
my terminal, or the view out my window are purely coincidental.  Any
resemblance between the above and my own views is non-deterministic.  The
question of the existence of views in the absence of anyone to hold them
is left as an exercise for the reader.  The question of the existence of
the reader is left as an exercise for the second god coefficient.  (A
discussion of non-orthogonal, non-integral polytheism is beyond the scope
of this article.)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
