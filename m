Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317376AbSFHApu>; Fri, 7 Jun 2002 20:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317377AbSFHApt>; Fri, 7 Jun 2002 20:45:49 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:11648 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S317376AbSFHAps>;
	Fri, 7 Jun 2002 20:45:48 -0400
Date: Sat, 8 Jun 2002 02:45:39 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, diego@biurrun.de, jerry.c.t@web.de,
        mike@pieper-family.de, hollis@austin.ibm.com
Subject: Updates to matroxfb: do you want DFP or TVOut on G450/G550?
Message-ID: <20020608004539.GB5090@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody,
  at http://platan.vc.cvut.cz/ftp/pub/linux/matrox-latest
you can find mga-2.5.20-tvout.gz. It is patch against
2.5.20-changeset1.465 (but should apply to 2.5.20
too, and with minor glitches also to 2.4.x - but I do
not plan to put this into official 2.4.x).

   Patch adds:
(0) Fixes CRTC2 bug in 2.5.x kernels. It will reject
    in 2.4.x, and 2.5.x before James's merges.

(1) You can change TV Out parameters on G400
    (luminance, hue, ...). Contributed by Mike Pipper,
    it should be compatible with V4L2.

(2) You can use TV Out capabilities of G450/G550.
    Do not forget that G450/G550 do not have vertical
    downscaler (or at least I did not find one),
    so for PAL use
    fbset -xres X -yres 580 -upper 22 -lower 22 -vslen 1
    where 456 <= X <= 1023 and for NTSC
    fbset -xres X -yres 480 -upper 22 -lower 22 -vslen 1
    where 464 <= X <= 1024. Pixclock does not matter,
    driver computes it to get 50Hz on PAL/59.94Hz on NTSC.
    Also do not forget that only CRTC2 can drive
    TV output on G450/G550. 
    Use matroxset to change secondary output mode
    between PAL/NTSC/monitor.

(3) You can now use DVI output of G550. By default
    you have same picture on all three outputs. Use
    matroxset to change it.

(4) You can read PINS through /proc.

   Known problems:
(a) If you have DFP connected to DVI port when MGA BIOS
    initializes hardware, it somehow forces whole card
    to be driven by TMDS clocks (or something like that...)
    and I did not found how to bring PLLs back to normal. 
    So it is possible that TVOut will not work for you in 
    such case. Simple hit ctrl-alt-del, disconnect DVI,
    and on LILO prompt connect it back. Help wanted...

   To do:
(A) Add changes (TVOut,1) to G450/G550 code. 

(B) Fix code which enforces 525/625 lines on screen in TVOut
    mode. Current behavior is very suboptimal.

(C) Verify that (DVI,3) works on G450. It should, but I have
    no G450-DVI to verify it.

(D) Rewrite DAC handling and PLL handling code. Currently
    it sets some registers unnecessary many times during
    mode switches, including reprogramming PLL even when
    PLL is not needed.

(E) Find what goes wrong if DFP is connected to DVI when
    BIOS boots.

(F) Add DDC support for G450/G550 secondary outputs & DVI.

(G) Add powersaving capabilities to secondary output,
    and to DVI (if someone will tell me how DVI powerdown
    happens).

(H) Change /proc code to use driverfs instead. Linus refused
    /proc based code already.

   Maybe:
(i) Get dual-DVI G550 and find whether it works, or not, and
    what needs to be done...

(ii) Port it to fbgen interface.

  Current version prints TONS of debug messages needed to
find what is wrong if it goes wrong - if driver does not work
for you, complain loudly. If patch breaks G400 or older card
support, please tell me too.

  Thanks should go to everyone who forced me to
look at DVI and TVOut capabilities of these beasts.

				Best regards,
					Petr Vandrovec
					vandrove@vc.cvut.cz

