Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268576AbRGYSCa>; Wed, 25 Jul 2001 14:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268603AbRGYSCU>; Wed, 25 Jul 2001 14:02:20 -0400
Received: from dragoran.quelltext.com ([212.46.119.29]:30995 "HELO
	mailgate.quelltext.com") by vger.kernel.org with SMTP
	id <S268576AbRGYSCN>; Wed, 25 Jul 2001 14:02:13 -0400
Date: Wed, 25 Jul 2001 20:02:04 +0200
From: Arndt Schoenewald <abs@src00024x007.mc.schoenewald.de>
To: Allan Sandfeld Jensen <snowwolf@one2one-networks.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: ps2/ new data for mouse protocol (fwd msg attached)
Message-ID: <20010725200204.A21273@digda.intern.quelltext.com>
In-Reply-To: <Pine.LNX.4.10.10107250905030.8057-100000@transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10107250905030.8057-100000@transvirtual.com>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi Allen,

I received your following message since James Simmons CC'd it to the
linuxconsole-dev mailing list:

> > However, some mouse secrets from various sources I hacked in here:
> > http://home.t-online.de/home/gunther.mayer/gm_psauxprint-0.01.c -
> 
> Very nice. I am currently looking for some info to solve a problem with 
> thinkpads and logitech cordless mice over ps/2. Basicly the wheel doesnt 
> work. Looking closer they dont respond to the imps/2 or mousemanps/2 
> protocol. Since cordless mice are more common than thinkpads, I think the 
> problem would be solved if it was with the mouse. So I am guessing the IBM 
> defaults to just repeating standard ps/2 protocol, and you have to first 
> trick that before you trick the mouse. Since it works in windows there IS a 
> way...
> 
> Where do I find the public available protocols, and the secrets? :)
> 
> And for the list, who should I notify that I am working on autodetecting IBM 
> thinkpad  ps/2 repeaters in mouse driver?

recently I spent a lot of time figuring out how to make a chordless wheel
mouse, which had two extra buttons on the left and on the right, work
on Linux with gpm and XFree86 4.0.3. The mouse was supposed to support
both the IntelliMouse and IntelliMouse Explorer protocol extensions,
but no matter which protocol selection I tried with gpm, the mouse would
stick in its 3 byte standard PS/2 mode. The same happened without gpm,
when I tried to use the mouse with XFree86's "ExplorerPS/2" setting.

After many hours of research I finally discovered why. The initialization
sequence used by both programs is not exactly what the mouse needs:

  - XFree86's "ExplorerPS/2" setting sends an initialization sequence of
    { 243, 200, 243, 200, 243, 80 }. For this mouse, however, the sequence
    must be { 243, 200, 243, 100, 243, 80, 243, 200, 243, 200, 243, 80 }.

  - The initialization sequence used by gpm 1.19.3 includes the byte 246
    which is meant to reset some mouse settings back to normal. However,
    for this mouse, it also resets it to 3 byte standard PS/2 mode.

I already submitted a patch to the XFree86 team, but don't know whom to
contact for the gpm fix.

I hope this helps you with your mouse!
Arndt

PS1: A good reading for mouse related stuff is Adam Chapweske's page at
http://panda.cs.ndsu.nodak.edu/~achapwes/PICmicro/mouse/mouse.html.

PS2: FWIW, my mouse is a NEO AirView 405 RF, which is a OEM product sold
in Germany under multiple brand (at least Neolec, Typhoon, Dexxa) and
product names (see e.g. http://neolec.de/news/indexAirView405RF.html).

-- 
 /////    Quelltext AG -- Professional Software Services
//   //   Arndt Schoenewald <abs@src00024x007.mc.schoenewald.de>. CEO
//   //   Ostenhellweg 31, 44135 Dortmund, Germany
//  \\/   Tel +49 231 9503750, Fax +49 231 9503751
 ////\\   Web http://quelltext.com
