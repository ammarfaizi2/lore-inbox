Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270529AbRHHRN6>; Wed, 8 Aug 2001 13:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270528AbRHHRNr>; Wed, 8 Aug 2001 13:13:47 -0400
Received: from mhw.ulib.iupui.edu ([134.68.164.123]:55801 "EHLO
	mhw.ULib.IUPUI.Edu") by vger.kernel.org with ESMTP
	id <S270527AbRHHRNa>; Wed, 8 Aug 2001 13:13:30 -0400
Date: Wed, 8 Aug 2001 12:13:40 -0500 (EST)
From: "Mark H. Wood" <mwood@IUPUI.Edu>
X-X-Sender: <mwood@mhw.ULib.IUPUI.Edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: how to tell Linux *not* to share IRQs ? 
In-Reply-To: <20010808000528.DB146BF02@wawura.off.connect.com.au>
Message-ID: <Pine.LNX.4.33.0108081205200.30852-100000@mhw.ULib.IUPUI.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Aug 2001, Andrew McNamara wrote:
[snippage]
> The problem is largely historical - each interrupt traditionally had a
> physically line associated with it, and lines on your backplane were a
> limited resource.
>
> If you were to do it again these days, you might have some sort of
> shared serial bus, so devices could give detailed data to the cpu
> (not only to uniquely identify the interrupting device, but also
> identify sub-devices - say a USB peripheral).

See for example "vectored interrupts" on the PDP10.  The device driver
tells the device where the driver's ISR is, and when the device
interrupts, it puts that address on the bus.  The interrupt logic jumps
directly to the ISR, which "knows" it is the only driver that would be
interested in this interrupt.  (You could set up a jump table if you
wanted to, so that each device of the same type could identify itself
uniquely, but that typically wasn't a big problem in '10 installations
where multiples were most likely in a PDP11 on the other side of a DTE20,
or Massbus devices on a single RH20.)

Apparently this idea is now so old that it is new. :-)

-- 
Mark H. Wood, Lead System Programmer   mwood@IUPUI.Edu
Make a good day.

