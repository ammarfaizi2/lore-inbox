Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S283870AbRLITjr>; Sun, 9 Dec 2001 14:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S283871AbRLITjh>; Sun, 9 Dec 2001 14:39:37 -0500
Received: from mx7.port.ru ([194.67.57.17]:15527 "EHLO mx7.port.ru") by vger.kernel.org with ESMTP id <S283870AbRLITj2>; Sun, 9 Dec 2001 14:39:28 -0500
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200112082158.fB8Lw4012155@vegae.deep.net>
Subject: Re: 2.4.12-ac4 10Mbit NE2k interrupt load kills p166
To: gandalf@wlug.westbo.se (Martin Josefsson)
Date: Sun, 9 Dec 2001 00:58:03 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0110252234270.27907-100000@tux.rsn.bth.se>
 from "Martin Josefsson" at Oct 25, 2001 10:40:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"  Martin Josefsson wrote:"
> 
> > > >        Hello folks...
> > > > 
> > > > 	Host A: p166, ISA NE2K, linux-2.4.12-ac4
> > > > 	Host B: p2-400, rtl-8129, WinXP (heh, not my box though ;)
> > > > 
> > > > 	Load: smbmount connection from host A to the host B, and getting
> > > >      large files.
> > > 
> > > Solution: replace NE2K with a decent network card.
> > 
> > The ne2k driver goes to great pains to keep interrupts enabled it isnt the
> > culprit as far as I can tell
> 
> I had an AMD K6 200 with an ISA NE2K card whan I started using Linux...
> I started using kernel 2.0 and that card worked very nice.
> I could even play quake while sending out data at 10Mbit/s, I didn't even
> notice that the transfer had started.
> 
> Then I upgraded to kernel 2.2 and I was no longer able to play quake while
> tranmitting at 10Mbit/s with the exact same hardware. Sometimes I could
> hardly even play mp3's :(
> 
> Then a friend of mine that also upgraded to kernel 2.2 began complaining
> that his machine also became extremely slow and unresponsive while
> transitting at 10Mbit/s, in fact that machine was even slower than mine
> during the transfers and his cpu was a bit faster than mine (also AMD).
> 
> Then I upgraded that machine to pIII 700 and even that machine slows to a
> crawl while transmitting with that bloody ISA NE2K. It's the same thing in
> kernel 2.4 too. These days I simply don't use that card anymore...
> 
> So something seems to have taken a wrong turn between 2.0 and 2.2
> I don't think this is a problem intruduced in 2.4.
    The question is whether anybody is interesting in investigation of
  such broken behaviour.
    i`ve made a further research and discovered the fact that
	ping -l 99999999 		- does not corrupt the sound
	ping -l 99999999 -s 256		- does not corrupt the sound
	ping -l 99999999 -s 512		- significantly corrupts the sound
	ping -l 99999999 -s 16384 	- heavily corrupts the sound with stalls

    as a reminder -l xxxx option forces ping to spit out data as fast as possible
    making it a great bandwidth loader...


    Initial look at the result makes me think that at certain level the
   interrupt handler just takes too long time and preempts the sound driver
   or whatever.
    My thinking is that if 2.0 was better than 2.4 in this case, we definitely
   need to find out why was it so and use its strong side.


regards, Samium Gromoff
  

