Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbVJAHI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbVJAHI6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 03:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbVJAHI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 03:08:58 -0400
Received: from main.gmane.org ([80.91.229.2]:13187 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750759AbVJAHI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 03:08:57 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: Blanky rivafb vs snowy nvidiafb with 2.6.12
Date: Sat, 1 Oct 2005 09:07:33 +0200
Message-ID: <15vft1mw0n773.w7bplfheyl29.dlg@40tude.net>
References: <1hcq27fp0wwd6.1xosn5xgejhhn$.dlg@40tude.net> <433B049B.1090502@gmail.com> <1gie1vr78iijd$.qcvoypipyouu.dlg@40tude.net> <433BE0D1.1070501@gmail.com> <dsq9rvr3xni3.1py6wljnelhp0.dlg@40tude.net> <433C52F0.6000401@gmail.com> <1hk58zmy4sz0x.kyzvnh8u4ia2.dlg@40tude.net> <433E2387.2090608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-84-220-49-122.cust-adsl.tiscali.it
User-Agent: 40tude_Dialog/2.0.15.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 01 Oct 2005 13:49:59 +0800, Antonino A. Daplas wrote:

> Looks like the nv driver just ignored the EDID and used one of
> its built-in VESA modes.  If you notice, X's EDID ouput is the same
> as nvidiafb's. But the resulting timings are different.
> 
> In contrast, nvidiafb will attempt to use the EDID, and only as a last
> resort, use one of the timings in the global mode database.

I see. And when EDID is enabled for the module, it won't let me touch
those timings at all. Maybe a "noddc" or "noedid" module option for
when EDID support is compiled in and one wants to work without it?

>> D'oh. D'oh. D'oh.
>> 
>> I *really* need someone to repeatedly and savagely hit me on the head
>> with a gigantic, purple-and-yellow CLUEBAT. *sigh*
>> 
>> Somehow, I just assumed that modprobing for the framebuffer driver
>> just loaded everything. But fbcon was *not* automatically load.
>> Indeed, modprobing for fbcon allows me to load nvidiafb OR rivafb
>> without any more screen garbling/blanking problems!
> 
> :-) Yes, many have been burned by this assumption.  If you do want
> 2.4 behavior, you can compile fbcon statically, nvidiafb as a module.
> Doing modprobe nvidiafb will automatically give you a framebuffer
> console.

Yes, after I got the idea that came as an obvious conclusion ... maybe
this should be a FAQ? Documented in the help for fbmod?

>> Notice how rivafb can't read the EDID from DDC/I2C -- and remark that
>> I also have problems reading the EDID with get-edid. Also interesting
> 
> read-edid though uses the Video BIOS to grab the EDID.  So even your
> card's BIOS is having problems doing i2c/ddc.

Yep, and as I already said it's a known problem with my configuration
(it's not clear whether the problem is the video card, with the
montitor, or somewhere inbetween).

>> is that rivafb won't let me get to 16 bit depth or higher. By
> 
> Hmm, I'll check on that again.

That'd be nice.

> Oh well, I think rivafb and nvidiafb have different i2c timeouts.  I believe
> the timeouts in nvidiafb are more correct.

Given that nvidiafb manages to read the edid and rivafb doesn't, I
would say so too :) maybe get-edid needs fixes in that direction too?

Anyway, it looks like I won't have problems using nvidiafb at 16 bits
depth without EDID for the moment ... can I still use X.org's nv at 24
bits at the same time? Can they cooperate on the framebuffer? IIRC
there was an option to let nv use the Linux-managed framebuffer ...

Oh yes:
"""
	Option		"UseFBDev"		"true" 
"""

Will this create problems when the FBDev is at a different bitdepth?
WIll this slow down either of the sides?

-- 
Giuseppe "Oblomov" Bilotta

"Da grande lotterò per la pace"
"A me me la compra il mio babbo"
(Altan)
("When I grow up, I will fight for peace"
 "I'll have my daddy buy it for me")

