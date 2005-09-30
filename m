Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbVI3Izy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbVI3Izy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 04:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbVI3Izy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 04:55:54 -0400
Received: from main.gmane.org ([80.91.229.2]:50592 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964887AbVI3Izx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 04:55:53 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: Blanky rivafb vs snowy nvidiafb with 2.6.12
Date: Fri, 30 Sep 2005 10:53:24 +0200
Message-ID: <1hk58zmy4sz0x.kyzvnh8u4ia2.dlg@40tude.net>
References: <1hcq27fp0wwd6.1xosn5xgejhhn$.dlg@40tude.net> <433B049B.1090502@gmail.com> <1gie1vr78iijd$.qcvoypipyouu.dlg@40tude.net> <433BE0D1.1070501@gmail.com> <dsq9rvr3xni3.1py6wljnelhp0.dlg@40tude.net> <433C52F0.6000401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-84-220-50-150.cust-adsl.tiscali.it
User-Agent: 40tude_Dialog/2.0.15.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2005 04:47:44 +0800, Antonino A. Daplas wrote:

> Giuseppe Bilotta wrote:
>> On Thu, 29 Sep 2005 20:40:49 +0800, Antonino A. Daplas wrote:
>> 
>>> Giuseppe Bilotta wrote:
>>>> On Thu, 29 Sep 2005 05:01:15 +0800, Antonino A. Daplas wrote:
>>>>
>>>>> Giuseppe Bilotta wrote:
>>>> So as you can see the problem is that the timings are NOT set by
>>>> fbset. No error messages or anything.
>>> Sorry about the blank reply, hit send accidentally.
>>>
>>> Probably, the EDID block is incomplete, so nvidiafb is refusing
>>> custom modes.  You can change the #undef DEBUG to #define DEBUG
>>> in drivers/video/fbmon.c to see verbose output of the EDID block in
>>> dmesg.
>> 
>> Here you are:
>> 
>> """
>> nvidiafb: nVidia device/chipset 10DE0112
>> nvidiafb: nVidia Corporation NV11 [GeForce2 Go]
>> nvidiafb: EDID found from BUS2
>> ========================================
>> Display Information (EDID)
>> ========================================
>>    EDID Version 1.3
>>    Manufacturer: SHP
>>    Model: 138e
>>    Serial#: 0
>>    Year: 1990 Week 0
>>    Display Characteristics:
>>       Monitor Operating Limits:    Supported VESA Modes
>>       Manufacturer's mask: 0
>>    Standard Timings
>>       1600x1200@60Hz
>>    Detailed Timings
>>       160 MHz 1600 1664 1856 2112 1200 1201 1204 1250 -HSync -VSync
>> 
>> Extrapolated
>>            H: 75-75KHz V: 60-60Hz DCLK: 162MHz
>>       Digital Display Input
>>       Sync: 
>>       Max H-size in cm: 30
>>       Max V-size in cm: 23
>>       Gamma: 2.20
>>       DPMS: Active no, Suspend yes, Standby yes
>>       RGB Color Display
>>       Chroma
>>          RedX:     0.599 RedY:     0.335
>>          GreenX:   0.313 GreenY:   0.552
>>          BlueX:    0.150 BlueY:    0.145
>>          WhiteX:   0.313 WhiteY:   0.328
>>       First DETAILED Timing is preferred
>>    Supported VESA Modes
>>       Manufacturer's mask: 0
>>    Standard Timings
>>       1600x1200@60Hz
>>    Detailed Timings
>>       160 MHz 1600 1664 1856 2112 1200 1201 1204 1250 -HSync -VSync
>> 
>> ========================================
>> nvidiafb: CRTC 1 is currently programmed for DFP
>> nvidiafb: Using DFP on CRTC 1
>> Panel size is 1600 x 1200
>> nvidiafb: MTRR set to ON
>> nvidiafb: PCI nVidia NV11 framebuffer (32MB @ 0xE0000000) 
>> """
> 
> The EDID supports only one mode, and no min/max vsync and hsync,
> so using other custom modes will not be supported.

Exactly as you predicted.

What I don't understand, however, is why nvidiafb and xorg's nv give
different results. Remember, xorg ends up using

(**) NV(0): *Default mode "1600x1200": 162.0 MHz, 75.0 kHz, 60.0 Hz

(II) NV(0): Modeline "1600x1200"  162.00  1600 1664 1856 2160  1200
1201 1204 1250 +hsync +vsync 

xorg DDC repports the following:

"""
(II) NV(0): I2C bus "DDC" initialized.
(II) NV(0): Probing for EDID on I2C bus A...
(II) NV(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) NV(0): I2C device "DDC:ddc2" removed.
(II) NV(0):   ... none found
(II) NV(0): Probing for EDID on I2C bus B...
(II) NV(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) NV(0): I2C device "DDC:ddc2" removed.
(--) NV(0): DDC detected a DFP:
(II) NV(0): Manufacturer: SHP  Model: 138e  Serial#: 0
(II) NV(0): Year: 1990  Week: 0
(II) NV(0): EDID Version: 1.3
(II) NV(0): Digital Display Input
(II) NV(0): Max H-Image Size [cm]: horiz.: 30  vert.: 23
(II) NV(0): Gamma: 2.20
(II) NV(0): DPMS capabilities: StandBy Suspend; RGB/Color Display
(II) NV(0): First detailed timing is preferred mode
(II) NV(0): redX: 0.599 redY: 0.335   greenX: 0.312 greenY: 0.552
(II) NV(0): blueX: 0.150 blueY: 0.145   whiteX: 0.312 whiteY: 0.328
(II) NV(0): Manufacturer's mask: 0
(II) NV(0): Supported Future Video Modes:
(II) NV(0): #0: hsize: 1600  vsize 1200  refresh: 60  vid: 16553
(II) NV(0): Supported additional Video Mode:
(II) NV(0): clock: 160.0 MHz   Image Size:  304 x 228 mm
(II) NV(0): h_active: 1600  h_sync: 1664  h_sync_end 1856 h_blank_end
2112 h_border: 0
(II) NV(0): v_active: 1200  v_sync: 1201  v_sync_end 1204 v_blanking:
1250 v_border: 0
(--) NV(0): CRTC 1 is currently programmed for DFP
(II) NV(0): Using DFP on CRTC 1
(--) NV(0): Panel size is 1600 x 1200
(--) NV(0): VideoRAM: 32768 kBytes 
"""

and my Modelines go simply like this:
"""
	SubSection "Display"
		Depth		1
		Modes		"1600x1200" "1024x768" "800x600" "640x480"
	EndSubSection 
"""
(for Depth = 1, 4, 8, 15, 16, 24, the latter being the default)


>>> Then, can you recompile without the DDC/I2C support, and boot with:
>>>
>>> video=nvidiafb:1600x1200-60, then play with fbset later on.
>> 
>> Remember I'm using nvidiafb as a module, it's not compiled in. So what
>> I do is
>> 
>> modprobe nvidiafb
>> 
>> Is there a way to specifiy resolution when loading nvidiafb this way?
> 
> Not currently, but you can add this at the end of drivers/video/nvidia/nvidia.c:
> 
> module_param(mode_option, charp, 0);
> MODULE_PARM_DESC(mode_option, "Specify initial video mode");
> 
> Then load nvidiafb like this:
> 
> modprobe nvidiafb mode_option=1600x1200

Nice one, I'll give it a shot.

> Yes, unfortunately, nvidiafb's hardware initialization routine
> may disrupt the hardware state, so you need something that will
> use the framebuffer, such as fbcon.

D'oh. D'oh. D'oh.

I *really* need someone to repeatedly and savagely hit me on the head
with a gigantic, purple-and-yellow CLUEBAT. *sigh*

Somehow, I just assumed that modprobing for the framebuffer driver
just loaded everything. But fbcon was *not* automatically load.
Indeed, modprobing for fbcon allows me to load nvidiafb OR rivafb
without any more screen garbling/blanking problems!

This allowed me to test the rivafb driver.

Some interesting results: rivafb reports this:

"""
rivafb: nVidia device/chipset 10DE0112
rivafb: nVidia Corporation NV11 [GeForce2 Go]
rivafb: On a laptop.  Assuming Digital Flat Panel
rivafb: Detected CRTC controller 1 being used
rivafb: RIVA MTRR set to ON
rivafb: could not retrieve EDID from DDC/I2C
rivafb: setting virtual Y resolution to 52428
Console: switching to colour frame buffer device 80x30
rivafb: PCI nVidia NV11 framebuffer ver 0.9.5b (32MB @ 0xE0000000)
rivafb: mode 1600x1200x16 rejected...resolution too high to fit into
video memory! 
"""

Notice how rivafb can't read the EDID from DDC/I2C -- and remark that
I also have problems reading the EDID with get-edid. Also interesting
is that rivafb won't let me get to 16 bit depth or higher. By
constrast, nvidiafb will get me even up to 32 bit depth.

Now, when not using DCC with nvidiafb, I get no flickering up to 16
bits. I do get very slight snow at 24 or 32 bits. This *might* be
solvable with that git patch you mentioned.

>> BTW, I think that having it in module form may be part of the problem:
>> even the old rivafb acted differently when in module form (as I
>> mentioned in my original post)
> 
> Yes, that in itself is weird.

A posteriori, it's not weird at all :) It's just that with fbcon
modular as well, it has to be loaded manually. However, this set-up
uses different screen resolutions for each tty.

> However, if fbcon is also loaded, and you have a garbled screen after
> fbset, then it is a bug.

No bug there, it seems :)

>>> If possible, you can also get the latest git snapshot then boot with:
>>>
>>> video=nvidiafb:1600x1200MR
>>>
>>> Note the appended MR - it's CVT with reduced blanking - which is
>>> for LCD displays especially those manufactured by Dell since they
>>> are the proponents of CVT.
>> 
>> I'm afraid this will have to wait.
> 
> That's okay.  I'm not expecting too much from this anyway. I was
> thinking that the snowy screen might be due to the mode maximizing
> the bandwidth of the DVI.  So a reduced-blanking calculation, which
> is not as bandwidth intensive, might be helpful.

Could be. Especially since I'm only getting very slight snow now, and
only with deep screens (24 or 32)

>> And while we're talking about Dell: my configuration (GeForce2 Go on
>> Dell Inspiron 8200 with UXGA monitor 15" at 1600x1200) is known to be
>> borky even with nVidia's own driver for Windows XP --not all versions
>> work correctly.
> 
> Hmm... But X's nv works, right?

Yes. The interesting thing now is that:

1. nv works, and gets the timing right from DDC
2. rivafb works, but can't read the EDID
3. nvidiafb can read the EDID, but it gets the timings wrong.

-- 
Giuseppe "Oblomov" Bilotta

"I'm never quite so stupid
 as when I'm being smart" --Linus van Pelt

