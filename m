Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269092AbRG3XnL>; Mon, 30 Jul 2001 19:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269090AbRG3Xmv>; Mon, 30 Jul 2001 19:42:51 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:17929 "HELO dvmwest.gt.owl.de")
	by vger.kernel.org with SMTP id <S269089AbRG3Xmn>;
	Mon, 30 Jul 2001 19:42:43 -0400
Date: Tue, 31 Jul 2001 01:42:50 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: LANCE ethernet chip - ~24 drivers
Message-ID: <20010731014250.F19713@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux mail 2.4.5 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi!

I was recently hacking the declance.c driver to support my
DS5000/200. While hanging around I looked over the code to
count the current implementations of Am7990 Lance drivers:

Driver file                                   | Mentioned Chip
----------------------------------------------+--------------------
./drivers/net/declance.c
./xxx/declance.c        # as for DS5k/200
./drivers/net/bagetlance.c                      none mentioned
./drivers/net/sk_g16.c                          Am7990
./drivers/net/ni65.c                            ni6510 aka Am7990
./drivers/net/ewk3.c                            Am7990
./drivers/net/sk_mca.c                          Am7990
./drivers/net/sunlance.c                        NCR92c990
        `-> Father of declance.c as I think
./drivers/net/sunhme.c                          none mentioned
        `-> *some* cards seem to be compatible?!
./drivers/net/a2065.c                           Am7990
./drivers/net/ariadne.c                         Am79c960
./drivers/net/atarilance.c                      none mentioned
./drivers/net/sunqu.c                           "looks like LANCE"
./drivers/net/atari_pamsnet.c                   none mentioned
./drivers/net/lance.c                           Am7990, Am79c970A
./drivers/net/pcnet32.c                         none mentioned
./drivers/net/sgiseeq.c                         Seeq8003 (different buffer
                                                layout for speed)
./drivers/net/am79c961a.c                       Am79c961A
./drivers/net/sun3lance.c                       none mentioned, but adopted from sunlance.c
./drivers/net/pcmcia/nmclan_cs.c                Am79c90
./drivers/net/ibmlana.c                         "start of LANCE"
./drivers/net/7990.c            *** GENERIC ROUTINES!!! ***
./drivers/net/hplance.c                         Uses 7990.c!
./drivers/net/mvme147.c                         Uses 7990.c!

That are *many* drivers for at least *one* chip. For now, I'm
working to get a serial keyboard running. However - having
more than 20 drivers for one kind of device sucks a lot. So
I'd like you to comment on this. There is a generic chip
implementation of an Am7990 driver (7990.c), but I can't
tell about it's quality. I'd *really* like to ask maintainers
and/or authors of those drivers to think about having
theit "own" driver. I think, it will be a 2.5.x thing to
re-unify them again (at lease, write a central implementation
for the chip and let bus specific drivers use it). Just the
same words are to be said for the Zilog8530 serial chip.

Thinking about it, we really have to do a lot on drivers for
a *chip* and those for I/O *busses* to work together. This way,
we could IMHO get rid of many lines of code, not giving up
any functionality. In fact, this would ease maintainance a lot,
wouldn't it?

Gest regards,
	Jan-Benedict Glaw

