Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263406AbTJQKEV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 06:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263408AbTJQKEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 06:04:21 -0400
Received: from a205017.upc-a.chello.nl ([62.163.205.17]:1408 "EHLO
	mail.fluido.as") by vger.kernel.org with ESMTP id S263406AbTJQKEL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 06:04:11 -0400
Date: Fri, 17 Oct 2003 12:04:12 +0200
From: "Carlo E. Prelz" <fluido@fluido.as>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Re: FBDEV 2.6.0-test7 updates.
Message-ID: <20031017100412.GA1639@casa.fluido.as>
References: <20031015162056.018737f1.akpm@osdl.org> <Pine.LNX.4.44.0310160022210.13660-100000@phoenix.infradead.org> <20031016091918.GA1002@casa.fluido.as> <1066298431.1407.119.camel@gaston> <20031016101905.GA7454@casa.fluido.as> <1066300935.646.136.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1066300935.646.136.camel@gaston>
X-operating-system: Linux casa 2.6.0-test7-radeon
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Subject: Re: [Linux-fbdev-devel] Re: FBDEV 2.6.0-test7 updates.
	Date: gio, ott 16, 2003 at 12:42:15 +0200

Quoting Benjamin Herrenschmidt (benh@kernel.crashing.org):

> You also have an rsync mirror of that tree at
> source.mivsta.com::linuxppc-2.5-benh

Ok. I got the code (it is mvista, not mivsta...). My card is
recognized without modifications:

--8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<--

bus pci: add driver radeonfb
radeonfb_pci_register BEGIN
radeonfb: probed DDR SGRAM 131072k videoram
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=200.00 Mhz, System=166.00 MHz
Starting monitor auto detection...
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 4) ... not found
radeonfb: I2C (port 3) ... found CRT display
radeonfb: Monitor 1 type CRT found
radeonfb: EDID probed
========================================
Display Information (EDID)
========================================
   EDID Version 1.3
   Manufacturer: MED Model: 4720 Serial#: 0
   Year: 2001 Week 44
   Display Characteristics:
      Analog Display Input: Input Voltage - 0.700V/0.300V
      Sync: Serration on 
      Max H-size in cm: 34
      Max V-size in cm: 27
      Gamma: 2.20
      DPMS: Active yes, Suspend yes, Standby yes
      RGB Color Display
      Chromaticity: RedX:   0.625 RedY:   0.340
                    GreenX: 0.280 GreenY: 0.595
                    BlueX:  0.155 BlueY:  0.070
                    WhiteX: 0.281 WhiteY: 0.311
      Default color format is primary
      First DETAILED Timing is preferred
      Display is GTF capable
   Standard Timings
      1280x1024@60Hz
   Supported VESA Modes
      720x400@70Hz
      640x480@60Hz
      640x480@67Hz
      640x480@72Hz
      640x480@75Hz
      800x600@56Hz
      800x600@60Hz
      800x600@72Hz
      800x600@75Hz
      832x624@75Hz
      1024x768@60Hz
      1024x768@70Hz
      1024x768@75Hz
      1280x1024@75Hz
      1152x870@75Hz
      Manufacturer's mask: 0
   Detailed Monitor Information
      135 MHz 1280 1296 1440 1688 1024 1025 1028 1066 +HSync +VSync

      Serial No     : 0
      Monitor Name  : MD 9463 AE
      HorizSync     : 24-80 KHz
      VertRefresh   : 56-75 Hz
      Max Pixelclock: 130 MHz
========================================
radeonfb: Monitor 2 type no found
radeonfb: ATI Radeon Yd  DDR SGRAM 128 MB
radeonfb_pci_register END
bound device '0000:01:00.0' to driver 'radeonfb'

--8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<--

and then

--8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<--

hStart = 664, hEnd = 760, hTotal = 800
vStart = 491, vEnd = 493, vTotal = 525
h_total_disp = 0x4f0063	   hsync_strt_wid = 0x8c02a2
v_total_disp = 0x1df020c	   vsync_strt_wid = 0x8201ea
pixclock = 39721
freq = 2517
post div = 0x8
fb_div = 0x59
ppll_div_3 = 0x30059
lvds_gen_cntl: 08000008
Console: switching to colour frame buffer device 80x30

--8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<--

Then, when changing to 1280x1024, with command

/usr/sbin/fbset  -depth 32 1280x1024-60

the actual console changes correctly, but when switching to other VCs,
the monitor again complains saying it gets bad frequencies: 103.1 kHz
horizontal and 197.8 Hz vertical.

If I blindly login, and run the appropriate fbset command, the
terminal works OK. I made this small script:

#!/bin/sh
stty cols 160 rows 64
/usr/sbin/fbset  -depth 32 1280x1024-60
consolechars -m iso15 -f iso15graf-16

and gave it a very short name. This way, once the terminal is set, I
can see what I type. I still have to logout and login again because
bash does not change its idea of the number of columns with
stty... So, quite uncomfortable but working ok. 

Obviously, if I were able to set the default mode to 1280x1024, things
would be sunny.
video=radeonfb:1280x1024-32@60 
and
video=radeonfb:mode:1280x1024-32@60 
seems not to produce any visible effect. What is the current proper
way to initialize radeonfb from LILO? 

And on a similar topic, could you write a couple of examples about how
to use the parameters included in radeon_base.c? I am thinking
especially of the "mirror" and "monitor_layout" parameters, that I
believe would allow me to use the two or three video outputs of the
card independently. I currently read

0 ATI Radeon Yd 

in /proc/fb. I should read two or three lines there, I believe...

Carlo

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido@fluido.as             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)
