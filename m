Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271977AbSISR3S>; Thu, 19 Sep 2002 13:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271997AbSISR3S>; Thu, 19 Sep 2002 13:29:18 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:10744
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S271977AbSISR3Q>; Thu, 19 Sep 2002 13:29:16 -0400
Subject: Re: 2.4.18 serial drops characters with 16654
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: dchristian@mail.arc.nasa.gov, linux-kernel@vger.kernel.org
In-Reply-To: <200209191027.46127.dchristian@mail.arc.nasa.gov>
References: <11E89240C407D311958800A0C9ACF7D13A7992@EXCHANGE>
	<3D7FCDE0.200@domdv.de>
	<1031818855.2994.47.camel@irongate.swansea.linux.org.uk> 
	<200209191027.46127.dchristian@mail.arc.nasa.gov>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Sep 2002 18:38:52 +0100
Message-Id: <1032457132.27721.45.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-19 at 18:27, Dan Christian wrote:
> The problem seems to be related to the RTS/CTS flow control handling.  
> The 16654 handles flow control in hardware, but the 16550 does it in 
> software (I've verified this with a digital oscilloscope).  I don't 
> currently have the equipment to compare when the lines drop and which 
> characters are lost.

Actually you can do it in hardware on the 16550 depending how its wired.
Take a look at the usenet-2 serial port design some day. The software
mode we do does in theory mean heavy delay to the bh handling might
delay the assertion excessively. That I think may be the real
explanation here.

Its
         buffer full
         bh handler delayed by bh load (tasklet nowdays I guess I mean)
         overrun
         overrun
         ...
         ksoftirqd
         Oh look I should do carrier

Russell - does that sound reasonable.

If so the answer yet again (as with the gige performance and some
others) might be to make it much much harder for stuff tofall back to
ksoftirqd.




