Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261205AbSKTQSH>; Wed, 20 Nov 2002 11:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261356AbSKTQSH>; Wed, 20 Nov 2002 11:18:07 -0500
Received: from graze.net ([65.207.24.2]:2962 "EHLO graze.net")
	by vger.kernel.org with ESMTP id <S261205AbSKTQSG>;
	Wed, 20 Nov 2002 11:18:06 -0500
Date: Wed, 20 Nov 2002 11:25:11 -0500 (EST)
From: "Brian C. Huffman" <sheep@graze.net>
To: linux-kernel@vger.kernel.org
cc: alan@lxorguk.ukuu.org.uk
Subject: i810 audio (AD1981A)
Message-ID: <Pine.LNX.4.44.0211201109030.20057-100000@graze.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

anyone?  Bueller...Bueller...

TIA,
Brian

---------- Forwarded message ----------
Date: Tue, 19 Nov 2002 11:09:33 -0500 (EST)
From: Brian C. Huffman <sheep@graze.net>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Peter Kundrat <kundrat@kundrat.sk>
Subject: Re: i810 audio (AD1981A)

Ok - so I have got this figured out a little more.  The Intel 845 board 
uses the AD1981A (AC97 compatible) BUT they attach the headphone out (of 
the codec) to the lineout on the motherboard...apparently b/c there's a 
headphone amp in the chip and this way you can just plug the headphones 
into the back of the computer.  :-(  Now looking at the latest drivers 
from OSS and ALSA, this looks to be common, however the register setup for 
the AD1981A is different from the others: AD1980, and AD1886...  
Therefore, the patches in ALSA to disable the headphone out don't work.  

If I can't find a way to write to the registers to make this work 
properly, I'd be happy just swapping what the mixer thinks the 
registers are for Main Volume w/ Headphone out.  Unfortunately, I tried 
this (with the kernel OSS) in linux/drivers/sound/ac97.h:

#define  AC97_RESET              0x0000      //
// #define  AC97_MASTER_VOL_STEREO  0x0002      // Line Out
#define  AC97_MASTER_VOL_STEREO  0x0004      // Line Out
//#define  AC97_HEADPHONE_VOL      0x0004      //
#define  AC97_HEADPHONE_VOL      0x0002      //

This still doesn't work, though!?  Can anyone direct me to what I might be 
doing wrong?

Thanks in advance!
Brian

> On Tue, 2002-11-12 at 19:43, Alan Cox wrote:
> 
> > The kernel knows which AC'97 chip is attached so it could be given a
> > table to specify chips where "volume" should either not be presented or
> > should be remapped. Do you know what AC97 chip is on your board (Linux
> > will print the info in the i810 load, windows and the manual probably
> > claim that you have that as your sound chip (typically "Analog
> > something" or "Crystal something").
> > 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

