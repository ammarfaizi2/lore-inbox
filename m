Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269504AbRHCRUc>; Fri, 3 Aug 2001 13:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269503AbRHCRUW>; Fri, 3 Aug 2001 13:20:22 -0400
Received: from chaos.analogic.com ([204.178.40.224]:5248 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S269495AbRHCRUO>; Fri, 3 Aug 2001 13:20:14 -0400
Date: Fri, 3 Aug 2001 13:19:53 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Tim Hockin <thockin@hockin.org>
cc: "chen, xiangping" <chen_xiangping@emc.com>, "'Todd'" <todd@unm.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: PCI bus speed
In-Reply-To: <200108031639.f73GdJB23498@www.hockin.org>
Message-ID: <Pine.LNX.3.95.1010803130717.1018A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2001, Tim Hockin wrote:

> > yes. I see some items with flags listed as:
> > 	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 10    
> 
> I think that reflects the '66 MHz CAPABLE' bit.  That means that IFF every
> device on the segment and IFF the bridge ALL can run at 66MHz, you MIGHT be
> at 66 MHz.  Or anywhere between 33 and 66, or for that matter, less than
> 33.
> 
> Tim

Yes, sort-of.  Bit 5 in the status register is supposed to be
"hard-wired by designer" according to the 2.2 spec. It is
TRUE if the board is capable of running at 66MHz.

However, some boards reflect the state of the bus 66MHz capable
bit. Any board that is not 66MHz capable must pull this bit to
ground (logic low). This will automatically switch a 66MHz bus
to 33MHz, usually by changing a divisor in a clock-chip.

This makes certain that any board that is not 66MHz capable will
force the bus to run at 33MHz. However, it might ALSO make any
status, bit 5  in other devices "strangely" show that they are
not 66MHz capable anymore. IOW, if I have all 66MHz devices on my
bus, and add a new board, suddenly __none__ of the devices appear
66MHz, capable. It's hard to find out the culprit without removing
boards one-at-a-time.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


