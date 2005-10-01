Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbVJAKtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbVJAKtW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 06:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbVJAKtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 06:49:21 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:64228 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750791AbVJAKtV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 06:49:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=VsujfXLZlxirwY0JABqCOLqS+vaBmNE/RO+AUtg8CSIrxgltiOipGnrnDvXF8npdQnH4ScmfRWhBmjlMvPZgc7EgKOr51Ci+6Rx4Aku6nlzMnnedR63z9CO8Kjs4/X8HWCmKFlyT6jyloXsCcsnYIBQxZR7aAA3cMcRBIvT4FFY=
Message-ID: <433E69A4.5050502@gmail.com>
Date: Sat, 01 Oct 2005 18:49:08 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Giuseppe Bilotta <bilotta78@hotpop.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Blanky rivafb vs snowy nvidiafb with 2.6.12
References: <1hcq27fp0wwd6.1xosn5xgejhhn$.dlg@40tude.net> <433B049B.1090502@gmail.com> <1gie1vr78iijd$.qcvoypipyouu.dlg@40tude.net> <433BE0D1.1070501@gmail.com> <dsq9rvr3xni3.1py6wljnelhp0.dlg@40tude.net> <433C52F0.6000401@gmail.com> <1hk58zmy4sz0x.kyzvnh8u4ia2.dlg@40tude.net> <433E2387.2090608@gmail.com> <15vft1mw0n773.w7bplfheyl29.dlg@40tude.net>
In-Reply-To: <15vft1mw0n773.w7bplfheyl29.dlg@40tude.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuseppe Bilotta wrote:
> On Sat, 01 Oct 2005 13:49:59 +0800, Antonino A. Daplas wrote:
> 
>> Looks like the nv driver just ignored the EDID and used one of
>> its built-in VESA modes.  If you notice, X's EDID ouput is the same
>> as nvidiafb's. But the resulting timings are different.
>>
>> In contrast, nvidiafb will attempt to use the EDID, and only as a last
>> resort, use one of the timings in the global mode database.
> 
> I see. And when EDID is enabled for the module, it won't let me touch
> those timings at all.

Yes. But if the EDID block specified a usable hsync and vsync range, the
timings can be customized.  In your case it does not.

> Maybe a "noddc" or "noedid" module option for 
> when EDID support is compiled in and one wants to work without it?

It is a good idea.  Especially since I've already encountered a lot of
crappy EDID blocks.

> 
>>> D'oh. D'oh. D'oh.
>>>
>>> I *really* need someone to repeatedly and savagely hit me on the head
>>> with a gigantic, purple-and-yellow CLUEBAT. *sigh*
>>>
>>> Somehow, I just assumed that modprobing for the framebuffer driver
>>> just loaded everything. But fbcon was *not* automatically load.
>>> Indeed, modprobing for fbcon allows me to load nvidiafb OR rivafb
>>> without any more screen garbling/blanking problems!
>> :-) Yes, many have been burned by this assumption.  If you do want
>> 2.4 behavior, you can compile fbcon statically, nvidiafb as a module.
>> Doing modprobe nvidiafb will automatically give you a framebuffer
>> console.
> 
> Yes, after I got the idea that came as an obvious conclusion ... maybe
> this should be a FAQ? Documented in the help for fbmod?
> 

I documented it in feature-list-2.6.txt, but it is still in the -mm tree.

>>> Notice how rivafb can't read the EDID from DDC/I2C -- and remark that
>>> I also have problems reading the EDID with get-edid. Also interesting
>> read-edid though uses the Video BIOS to grab the EDID.  So even your
>> card's BIOS is having problems doing i2c/ddc.
> 
> Yep, and as I already said it's a known problem with my configuration
> (it's not clear whether the problem is the video card, with the
> montitor, or somewhere inbetween).
> 
>>> is that rivafb won't let me get to 16 bit depth or higher. By
>> Hmm, I'll check on that again.
> 
> That'd be nice.
> 
>> Oh well, I think rivafb and nvidiafb have different i2c timeouts.  I believe
>> the timeouts in nvidiafb are more correct.
> 
> Given that nvidiafb manages to read the edid and rivafb doesn't, I
> would say so too :) maybe get-edid needs fixes in that direction too?

get-edid is meant to be a generic reader, that's why it uses the BIOS.
nvidiafb uses i2c/ddc and the method is different from manufacturer to 
manufacturer, chipset to chipset.

> 
> Anyway, it looks like I won't have problems using nvidiafb at 16 bits
> depth without EDID for the moment ... can I still use X.org's nv at 24
> bits at the same time? Can they cooperate on the framebuffer? IIRC

Yes, you can have nvidiafb and nv with differing visuals. This should
not be a problem.

> there was an option to let nv use the Linux-managed framebuffer ...
> 
> Oh yes:
> """
> 	Option		"UseFBDev"		"true" 
> """

The "UseFBDev" option was meant to restore the framebuffer console when
switching from X to vt. This option is unnecessary in 2.6 kernels. The
console layer now detects an X<->console switch, so it can properly
inform fbcon and the drivers that it needs to restore the state, or not
touch the hardware when X owns the vt.

> 
> Will this create problems when the FBDev is at a different bitdepth?

It will only slow down the console switch.  But it's preferrable to set
it to false.

> WIll this slow down either of the sides?
> 

It should not.

Tony
