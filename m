Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbVI2Mjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbVI2Mjf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 08:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbVI2Mje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 08:39:34 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:65226 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751112AbVI2Mje (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 08:39:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Qd6T5HM2LiCoZrga18FkZykdNhphRGPXwGI6dqKCGBrOTRMVsyMYGbQQwk+EBPar7L1iCVCieUZ012aEJAuXjKE6YKIEGIT3ap7aJlhmovfG+ajwbVyZ0Mg8WbzH/UOVF2bZ+m6HAOC58xip7mTKnKM+1V40bBr8m/ElZdF13a4=
Message-ID: <433BE076.50404@gmail.com>
Date: Thu, 29 Sep 2005 20:39:18 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Giuseppe Bilotta <bilotta78@hotpop.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Blanky rivafb vs snowy nvidiafb with 2.6.12
References: <1hcq27fp0wwd6.1xosn5xgejhhn$.dlg@40tude.net> <433B049B.1090502@gmail.com> <1gie1vr78iijd$.qcvoypipyouu.dlg@40tude.net>
In-Reply-To: <1gie1vr78iijd$.qcvoypipyouu.dlg@40tude.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuseppe Bilotta wrote:
> On Thu, 29 Sep 2005 05:01:15 +0800, Antonino A. Daplas wrote:
> 
>> Giuseppe Bilotta wrote:
>>> Hello all,
>>>
>>> * I have thus tried the new nvidiafb driver, which seems to work ok,
>>> except for the minor detail that the display is extremely snowy.
>>> Attempts to change the timing options with fbset fail: fbset seems to
>>> accept the settings, no error message is given, but nothing is
>>> changed. The X nv driver select the correct timings, so I tried
>>> modeline2fb to make fbset use those, but still nothing changes.
>>>
>> What's the dmesg output?
> 
> """
> nvidiafb: nVidia device/chipset 10DE0112
> nvidiafb: nVidia Corporation NV11 [GeForce2 Go]
> nvidiafb: EDID found from BUS2
> nvidiafb: CRTC 1 is currently programmed for DFP
> nvidiafb: Using DFP on CRTC 1
> Panel size is 1600 x 1200
> nvidiafb: MTRR set to ON
> Console: switching to colour frame buffer device 200x75
> nvidiafb: PCI nVidia NV11 framebuffer (32MB @ 0xE0000000) 
> """
> 
> (do you need more?)
> 
>>  What's fbset -i output?
> 
> Right after modprobing nvidiafb:
> 
> """
> mode "1600x1200-61"
>     # D: 160.000 MHz, H: 75.758 kHz, V: 60.606 Hz
>     geometry 1600 1200 1600 20889 8
>     timings 6250 256 64 46 1 192 3
>     accel true
>     rgba 8/0,8/0,8/0,0/0
> endmode
> 
> Frame buffer device information:
>     Name        : NV11
>     Address     : 0xe0000000
>     Size        : 33554432
>     Type        : PACKED PIXELS
>     Visual      : PSEUDOCOLOR
>     XPanStep    : 8
>     YPanStep    : 1
>     YWrapStep   : 0
>     LineLength  : 1600
>     MMIO Address: 0xfc000000
>     MMIO Size   : 16777216
>     Accelerator : Unknown (43)  
> """
> 
> After trying fbset "1600x1200":
> 
> """
> mode "1600x1200-61"
>     # D: 160.000 MHz, H: 75.758 kHz, V: 60.606 Hz
>     geometry 1600 1200 1920 17408 8
>     timings 6250 256 64 46 1 192 3
>     accel true
>     rgba 8/0,8/0,8/0,0/0
> endmode
> 
> Frame buffer device information:
>     Name        : NV11
>     Address     : 0xe0000000
>     Size        : 33554432
>     Type        : PACKED PIXELS
>     Visual      : PSEUDOCOLOR
>     XPanStep    : 8
>     YPanStep    : 1
>     YWrapStep   : 0
>     LineLength  : 1920
>     MMIO Address: 0xfc000000
>     MMIO Size   : 16777216
>     Accelerator : Unknown (43)  
> """
> 
> The "1600x1200" mode is:
> 
> """
> mode "1600x1200"
>   geometry   1600 1200   1920 17467   8
>   timings    6172   304 64   46 1   192 3
>   hsync high
>   vsync high
> endmode 
> """
> 
> So as you can see the problem is that the timings are NOT set by
> fbset. No error messages or anything.
> 
>> Can you try doing fbset -accel false and see if it makes a difference?
> 
> Nope, same thing. Also with modprobe nvidiafb noaccel=1.
> 

