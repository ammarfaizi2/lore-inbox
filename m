Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292027AbSBAUye>; Fri, 1 Feb 2002 15:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292015AbSBAUyS>; Fri, 1 Feb 2002 15:54:18 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:39396 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S292019AbSBAUx5>; Fri, 1 Feb 2002 15:53:57 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@mandrakesoft.com (Jeff Garzik), linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: [PATCH] IBM Lanstreamer bugfixes
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFB91B46B3.DE7448D0-ON85256B53.0071158D@raleigh.ibm.com>
From: "Kent E Yoder" <yoder1@us.ibm.com>
Date: Fri, 1 Feb 2002 14:53:43 -0600
X-MIMETrack: Serialize by Router on D04NM109/04/M/IBM(Release 5.0.9 |November 16, 2001) at
 02/01/2002 03:53:55 PM,
	Serialize complete at 02/01/2002 03:53:55 PM
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > effects.  I tested by removing all the delays and instead putting 
> > something like:
> >         writew(val, addr);
> >         (void) readw(addr);

  Ok, now I'm curious about something...

  If the readw() above is needed here (it definitely fixes *something*), 
what purpose does the volatile below serve? 

io.h:122:#define writew(b,addr) (*(volatile unsigned short *) 
__io_virt(addr) = (b))X

Is this a sort of "go do this now" command to flush it from the CPU to the 
PCI bus, while the readw() makes sure its flushed out of the PCI cache? 

> > 
> > instead, to flush the PCI cache.  Things seem to be happy. 
> > 
> > Is this the best way to make sure the PCI cache is flushed for writes 
that 
> > need to happen immediately?  I don't see many other drivers doing 
it...

 Another question is, if the PCI bus is caching like this, how does it 
handle adapters which write to one address and read from another for the 
same variable?  I'm guessing it flushes all writes on a read?  This is 
exactly what lanstreamer does, and I'm thinking this may have caused 
problems before.

Thanks,
Kent

