Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130127AbRAPAVB>; Mon, 15 Jan 2001 19:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130393AbRAPAUw>; Mon, 15 Jan 2001 19:20:52 -0500
Received: from sandy.surfsouth.com ([216.128.200.25]:59654 "EHLO
	sandy.surfsouth.com") by vger.kernel.org with ESMTP
	id <S130127AbRAPAUg>; Mon, 15 Jan 2001 19:20:36 -0500
Date: Mon, 15 Jan 2001 19:22:08 -0500
To: linux-kernel@vger.kernel.org
Subject: matroxfb on 2.4.0 / PCI: Failed to allocate...
Message-ID: <20010115192208.A372@cahoots.surfsouth.com>
Reply-To: cmiller@surfsouth.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-mrl-nonsense: It's better to be Pavlov's Dog than Schrodenger's Cat.
X-key-info: GPG key at http://web.chad.org/home/gpgkey
From: Chad Miller <cmiller@surfsouth.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all.  I'm trying to get matroxfb running on a G400Max (dualhead).

Of course, I have i2c bit-banging on and the relevant Matrox options
turned on (as modules or compiled-in), and I don't see the expected
`framebuffer: blah' after the `matroxfb: Matrox Millennium G400 MAX (AGP)
detected'.

I worry about some PCI initialization output (from dmesg):

# PCI: Probing PCI hardware
# Unknown bridge resource 0: assuming transparent
# PCI: Using IRQ router VIA [1106/0686] at 00:07.0
# PCI: Cannot allocate resource region 0 of device 01:00.0
# PCI: Failed to allocate resource 0 for Matrox Graphics, Inc. MGA G400 AGP
[...]

That `device 01:00.0' is obviously the AGP MGA.  'dmesg' continues later
with...

# matroxfb: Matrox Millennium G400 MAX (AGP) detected
# i2c-core.o: i2c core module
# i2c-algo-bit.o: i2c bit algorithm module
# i2c-core.o: driver maven registered.  [...]

...and the loaded modules include...

Module                  Size  Used by
matroxfb_crtc2          6928   0 (unused)
matroxfb_maven          9552   0 (unused)
i2c-matroxfb            3632   0 (unused)
i2c-algo-bit            7392   0 [i2c-matroxfb]
i2c-core               13072   0 [matroxfb_maven i2c-algo-bit]
matroxfb_base          16848   0 [matroxfb_crtc2 i2c-matroxfb]
matroxfb_DAC1064        5824   0 [matroxfb_crtc2 matroxfb_base]
matroxfb_accel          8192   0 [matroxfb_crtc2 matroxfb_maven \
i2c-matroxfb matroxfb_base matroxfb_DAC1064]
matroxfb_misc          13088   0 [matroxfb_crtc2 matroxfb_maven \
i2c-matroxfb matroxfb_base matroxfb_DAC1064 matroxfb_accel]
agpgart                13536   0 (unused)

...but...

cmiller@canard:~$ cat /proc/fb
cmiller@canard:~$

Ideas?  Pointers?  I'm available for questions and flames.

						- chad

--
Chad Miller <cmiller@surfsouth.com>   URL: http://web.chad.org/   (GPG)
"Any technology distinguishable from magic is insufficiently advanced".
First corollary to Clarke's Third Law (Jargon File, v4.2.0, 'magic')
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
