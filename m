Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbVI2PtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbVI2PtH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 11:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbVI2PtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 11:49:06 -0400
Received: from main.gmane.org ([80.91.229.2]:2536 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932172AbVI2PtE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 11:49:04 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: Blanky rivafb vs snowy nvidiafb with 2.6.12
Date: Thu, 29 Sep 2005 17:43:22 +0200
Message-ID: <dsq9rvr3xni3.1py6wljnelhp0.dlg@40tude.net>
References: <1hcq27fp0wwd6.1xosn5xgejhhn$.dlg@40tude.net> <433B049B.1090502@gmail.com> <1gie1vr78iijd$.qcvoypipyouu.dlg@40tude.net> <433BE0D1.1070501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-ull-99-118.44-151.net24.it
User-Agent: 40tude_Dialog/2.0.15.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2005 20:40:49 +0800, Antonino A. Daplas wrote:

> Giuseppe Bilotta wrote:
>> On Thu, 29 Sep 2005 05:01:15 +0800, Antonino A. Daplas wrote:
>> 
>>> Giuseppe Bilotta wrote:
>> 
>> So as you can see the problem is that the timings are NOT set by
>> fbset. No error messages or anything.
> 
> Sorry about the blank reply, hit send accidentally.
> 
> Probably, the EDID block is incomplete, so nvidiafb is refusing
> custom modes.  You can change the #undef DEBUG to #define DEBUG
> in drivers/video/fbmon.c to see verbose output of the EDID block in
> dmesg.

Here you are:

"""
nvidiafb: nVidia device/chipset 10DE0112
nvidiafb: nVidia Corporation NV11 [GeForce2 Go]
nvidiafb: EDID found from BUS2
========================================
Display Information (EDID)
========================================
   EDID Version 1.3
   Manufacturer: SHP
   Model: 138e
   Serial#: 0
   Year: 1990 Week 0
   Display Characteristics:
      Monitor Operating Limits:    Supported VESA Modes
      Manufacturer's mask: 0
   Standard Timings
      1600x1200@60Hz
   Detailed Timings
      160 MHz 1600 1664 1856 2112 1200 1201 1204 1250 -HSync -VSync

Extrapolated
           H: 75-75KHz V: 60-60Hz DCLK: 162MHz
      Digital Display Input
      Sync: 
      Max H-size in cm: 30
      Max V-size in cm: 23
      Gamma: 2.20
      DPMS: Active no, Suspend yes, Standby yes
      RGB Color Display
      Chroma
         RedX:     0.599 RedY:     0.335
         GreenX:   0.313 GreenY:   0.552
         BlueX:    0.150 BlueY:    0.145
         WhiteX:   0.313 WhiteY:   0.328
      First DETAILED Timing is preferred
   Supported VESA Modes
      Manufacturer's mask: 0
   Standard Timings
      1600x1200@60Hz
   Detailed Timings
      160 MHz 1600 1664 1856 2112 1200 1201 1204 1250 -HSync -VSync

========================================
nvidiafb: CRTC 1 is currently programmed for DFP
nvidiafb: Using DFP on CRTC 1
Panel size is 1600 x 1200
nvidiafb: MTRR set to ON
nvidiafb: PCI nVidia NV11 framebuffer (32MB @ 0xE0000000) 
"""

> Then, can you recompile without the DDC/I2C support, and boot with:
> 
> video=nvidiafb:1600x1200-60, then play with fbset later on.

Remember I'm using nvidiafb as a module, it's not compiled in. So what
I do is

modprobe nvidiafb

Is there a way to specifiy resolution when loading nvidiafb this way?
Presently, when compiling without DDC support, I get this:

"""
mode "640x480-60"
    # D: 25.176 MHz, H: 31.469 kHz, V: 59.942 Hz
    geometry 640 480 640 32767 8
    timings 39721 40 24 32 11 96 2
    accel true
    rgba 8/0,8/0,8/0,0/0
endmode

Frame buffer device information:
    Name        : NV11
    Address     : 0xe0000000
    Size        : 33554432
    Type        : PACKED PIXELS
    Visual      : PSEUDOCOLOR
    XPanStep    : 8
    YPanStep    : 1
    YWrapStep   : 0
    LineLength  : 0
    MMIO Address: 0xfc000000
    MMIO Size   : 16777216
    Accelerator : Unknown (43)  
"""

and then, after fbset "1600x1200"

"""
mode "1600x1200-60"
    # D: 162.022 MHz, H: 75.010 kHz, V: 60.008 Hz
    geometry 1600 1200 1920 17408 8
    timings 6172 304 64 46 1 192 3
    hsync high
    vsync high
    accel true
    rgba 8/0,8/0,8/0,0/0
endmode

Frame buffer device information:
    Name        : NV11
    Address     : 0xe0000000
    Size        : 33554432
    Type        : PACKED PIXELS
    Visual      : PSEUDOCOLOR
    XPanStep    : 8
    YPanStep    : 1
    YWrapStep   : 0
    LineLength  : 1920
    MMIO Address: 0xfc000000
    MMIO Size   : 16777216
    Accelerator : Unknown (43)  
"""

but a borked screen (see further down)

BTW, I think that having it in module form may be part of the problem:
even the old rivafb acted differently when in module form (as I
mentioned in my original post)

BTW #2: There are two interesting differences between the
(modularized) nvidiafb in Debian and the one from my kernel:

1. Debian's nvidiafb resets the console font to 200x75 on load, while
the one from my kernel doesn't

2. If I try to change resolution or color depth when using my kernel,
the screen gets garbled, and there is no way to restore it.

> If possible, you can also get the latest git snapshot then boot with:
> 
> video=nvidiafb:1600x1200MR
> 
> Note the appended MR - it's CVT with reduced blanking - which is
> for LCD displays especially those manufactured by Dell since they
> are the proponents of CVT.

I'm afraid this will have to wait.

And while we're talking about Dell: my configuration (GeForce2 Go on
Dell Inspiron 8200 with UXGA monitor 15" at 1600x1200) is known to be
borky even with nVidia's own driver for Windows XP --not all versions
work correctly.

-- 
Giuseppe "Oblomov" Bilotta

[W]hat country can preserve its liberties, if its rulers are not
warned from time to time that [the] people preserve the spirit of
resistance? Let them take arms...The tree of liberty must be
refreshed from time to time, with the blood of patriots and
tyrants.
	-- Thomas Jefferson, letter to Col. William S. Smith, 1787

