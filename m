Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271856AbSISRXD>; Thu, 19 Sep 2002 13:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271864AbSISRXD>; Thu, 19 Sep 2002 13:23:03 -0400
Received: from auscon.arc.nasa.gov ([143.232.69.76]:21376 "EHLO
	rudi.arc.nasa.gov") by vger.kernel.org with ESMTP
	id <S271856AbSISRXC>; Thu, 19 Sep 2002 13:23:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dan Christian <dchristian@mail.arc.nasa.gov>
Reply-To: dchristian@mail.arc.nasa.gov
Organization: NASA Ames Research Center
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andreas Steinmetz <ast@domdv.de>
Subject: Re: 2.4.18 serial drops characters with 16654
Date: Thu, 19 Sep 2002 10:27:46 -0700
User-Agent: KMail/1.4.1
Cc: Ed Vance <EdV@macrolink.com>, linux-kernel@vger.kernel.org
References: <11E89240C407D311958800A0C9ACF7D13A7992@EXCHANGE> <3D7FCDE0.200@domdv.de> <1031818855.2994.47.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1031818855.2994.47.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209191027.46127.dchristian@mail.arc.nasa.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The weird thing is that it looks like the 16654 loses data on the 
TRANSMIT side.  A FIFO underrun on transmit should never loose data.  A 
16550 works perfectly.  I don't think that this is a over/under run 
problem.  

The problem seems to be related to the RTS/CTS flow control handling.  
The 16654 handles flow control in hardware, but the 16550 does it in 
software (I've verified this with a digital oscilloscope).  I don't 
currently have the equipment to compare when the lines drop and which 
characters are lost.

-Dan

On Thursday 12 September 2002 01:20, Alan Cox wrote:
> On Thu, 2002-09-12 at 00:12, Andreas Steinmetz wrote:
> > I did see something that looks quite similar like dropped
> > characters on Redhat and 2.4.9 based UP systems (that's customers
> > choice and couldn't be changed) equipped with a NS-87336.
> > I can't go into detail but my company did port an application from
> > DOS to Linux. The application communicates with an electronic cash
> > device
>
> Other than the usual PIO mode IDE suspects I've had no problems going
> up to 460800bps with a decent UART (ie one with a fifo). At
> 920Kbit/sec you begin to overrun the flip buffers if you run with the
> usual 100Mhz timer tick.
>
> 2.4 is a bit worse nowdays because of the ksoftirqd stuff but you
> could easily disable that if you think it is triggering.
