Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261561AbRE2T0q>; Tue, 29 May 2001 15:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261576AbRE2T0g>; Tue, 29 May 2001 15:26:36 -0400
Received: from vulcan.datanet.hu ([194.149.0.156]:64928 "EHLO relay.datanet.hu")
	by vger.kernel.org with ESMTP id <S261561AbRE2T0S>;
	Tue, 29 May 2001 15:26:18 -0400
From: "Bakonyi Ferenc" <fero@drama.obuda.kando.hu>
Organization: =?ISO-8859-2?Q?Datakart_Geodzia_KFT.?=
To: sduchene@mindspring.com
Date: Tue, 29 May 2001 17:03:54 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: console colors messed up with 2.4.X Rivafb driver
CC: linux-kernel@vger.kernel.org, Louis Garcia <louisg00@bellsouth.net>
Message-ID: <3B13D688.12981.6392980@localhost>
In-Reply-To: <20010529102920.H790@mug.hdqt.valinux.com>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hi!

Steven A. DuChene wrote:
> I have a Riva128 based video card in a older SMP P-Pro system and with all
> of the lastest 2.4 series of kernels (mostly the ac stuff) I have screwy colors
> on the console (the penguin boot logos are shades of blue) and initially when
> I start X (XFree86 4.0.3) the colors are very dark until I switch to a console
> and back again. Once I switch to a console and back to X things are fine in
Pressing 'ctrl alt +' and 'ctrl alt -' is enough. On Riva 128 cards 
rivafb uses 8 bit color registers but XFree86 4.0.x still uses 6 bit 
color registers.

>...
> The fbset output on this system says:
> 
> mode "1280x1024-74"
>     # D: 135.007 MHz, H: 78.859 kHz, V: 74.116 Hz
>     geometry 1280 1024 1280 1024 16
>     timings 7407 256 32 34 3 144 3
>     accel true
>     rgba 5/11,6/5,5/0,0/0
^^^^^^^^^^^^^^^^^^^^^^^^^^^
This line indicates you are using rivafb in 16 bpp mode. Unfortunetly 
16 bpp is not supported by Riva 128 hw. It's a bug, in a perfect 
world rivafb should disable 16 bpp mode on Riva 128. In this case 
hardware is set to 15 bpp, but rivafb thinks it's set to 16 bpp. (Or 
something similar.)

Fastest solution: try using 15 bpp or 32 bpp.

> endmode
> 
> The same thing still occurs if I set the color depth to 8 bit.
If you boot with 8 bpp and you do not use X, console and logo colors 
should be fine. Please detail this problem!

> 
> This is a pci card with 4Mb of video memory. I also have a AMD K6 system with a 16Mb
> AGP TNT2 card and this does not happen on that machine.
> 
> BTW, why is the mtrr for the Riva set to 0M ???
Because you said yes to 'Processor type and features ---> MTRR 
(Memory Type Range Register) support'.

Regards:
	Ferenc Bakonyi

