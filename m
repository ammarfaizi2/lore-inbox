Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289866AbSA3T2G>; Wed, 30 Jan 2002 14:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290022AbSA3T1r>; Wed, 30 Jan 2002 14:27:47 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:33667 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S289866AbSA3T1h>; Wed, 30 Jan 2002 14:27:37 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@mandrakesoft.com (Jeff Garzik), linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: [PATCH] IBM Lanstreamer bugfixes
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF0323731B.AAE52C6B-ON85256B51.005748CD@raleigh.ibm.com>
From: "Kent E Yoder" <yoder1@us.ibm.com>
Date: Wed, 30 Jan 2002 13:27:29 -0600
X-MIMETrack: Serialize by Router on D04NM109/04/M/IBM(Release 5.0.9 |November 16, 2001) at
 01/30/2002 02:27:35 PM,
	Serialize complete at 01/30/2002 02:27:35 PM
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I think the delays in the driver *were* just working around PCI posting 
effects.  I tested by removing all the delays and instead putting 
something like:
        writew(val, addr);
        (void) read(addr);

instead, to flush the PCI cache.  Things seem to be happy. 

Is this the best way to make sure the PCI cache is flushed for writes that 
need to happen immediately?  I don't see many other drivers doing it...

Kent



> >   BTW, I don't know what PCI posting effects are...
> 
> Ok given
> 
>                  writel(foo, dev->reg);
>                  udelay(5);
>                  writel(bar, dev->reg);
> 
> The pci bridge is at liberty to delay the first write until the second or 
a
> read from that device comes along (and wants to do so to merge bursts). 
It
> tends to bite people
> 
>                  -               When they do a write to clear the IRQ 
status and don't do
>                                  a read so they keep handling lots of 
phantom level triggered
>                                  interrupts.
> 
>                  -               When there is a delay (reset is common) 
that has to be observed
> 
>                  -               At the end of a DMA transfer when people 
unmap stuff early
>                                  and the "stop the DMA" command got 
delayed
> 
> Alan



