Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbVI2LqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbVI2LqE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 07:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbVI2LqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 07:46:04 -0400
Received: from main.gmane.org ([80.91.229.2]:29312 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750933AbVI2LqC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 07:46:02 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: Blanky rivafb vs snowy nvidiafb with 2.6.12
Date: Thu, 29 Sep 2005 13:41:46 +0200
Message-ID: <1gie1vr78iijd$.qcvoypipyouu.dlg@40tude.net>
References: <1hcq27fp0wwd6.1xosn5xgejhhn$.dlg@40tude.net> <433B049B.1090502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-ull-99-118.44-151.net24.it
User-Agent: 40tude_Dialog/2.0.15.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2005 05:01:15 +0800, Antonino A. Daplas wrote:

> Giuseppe Bilotta wrote:
>> Hello all,
>> 
> 
>> * I have thus tried the new nvidiafb driver, which seems to work ok,
>> except for the minor detail that the display is extremely snowy.
>> Attempts to change the timing options with fbset fail: fbset seems to
>> accept the settings, no error message is given, but nothing is
>> changed. The X nv driver select the correct timings, so I tried
>> modeline2fb to make fbset use those, but still nothing changes.
>> 
> 
> What's the dmesg output?

"""
nvidiafb: nVidia device/chipset 10DE0112
nvidiafb: nVidia Corporation NV11 [GeForce2 Go]
nvidiafb: EDID found from BUS2
nvidiafb: CRTC 1 is currently programmed for DFP
nvidiafb: Using DFP on CRTC 1
Panel size is 1600 x 1200
nvidiafb: MTRR set to ON
Console: switching to colour frame buffer device 200x75
nvidiafb: PCI nVidia NV11 framebuffer (32MB @ 0xE0000000) 
"""

(do you need more?)

>  What's fbset -i output?

Right after modprobing nvidiafb:

"""
mode "1600x1200-61"
    # D: 160.000 MHz, H: 75.758 kHz, V: 60.606 Hz
    geometry 1600 1200 1600 20889 8
    timings 6250 256 64 46 1 192 3
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
    LineLength  : 1600
    MMIO Address: 0xfc000000
    MMIO Size   : 16777216
    Accelerator : Unknown (43)  
"""

After trying fbset "1600x1200":

"""
mode "1600x1200-61"
    # D: 160.000 MHz, H: 75.758 kHz, V: 60.606 Hz
    geometry 1600 1200 1920 17408 8
    timings 6250 256 64 46 1 192 3
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

The "1600x1200" mode is:

"""
mode "1600x1200"
  geometry   1600 1200   1920 17467   8
  timings    6172   304 64   46 1   192 3
  hsync high
  vsync high
endmode 
"""

So as you can see the problem is that the timings are NOT set by
fbset. No error messages or anything.

> Can you try doing fbset -accel false and see if it makes a difference?

Nope, same thing. Also with modprobe nvidiafb noaccel=1.

-- 
Giuseppe "Oblomov" Bilotta

"I weep for our generation" -- Charlie Brown

