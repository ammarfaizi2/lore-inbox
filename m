Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264047AbTDJONE (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 10:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264048AbTDJONE (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 10:13:04 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:32743 "EHLO
	zion.wanadoo.fr") by vger.kernel.org with ESMTP id S264047AbTDJOND (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 10:13:03 -0400
Subject: Re: [PATCH] New radeonfb fork
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Daniele Venzano <webvenza@libero.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030410084650.GA728@renditai.milesteg.arr>
References: <1049642954.550.41.camel@zion.wanadoo.fr>
	 <20030410084650.GA728@renditai.milesteg.arr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049984776.555.90.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 10 Apr 2003 16:26:16 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-10 at 10:46, Daniele Venzano wrote:
> I tried your patch for Radeon framebuffer on kernel 2.4.21-pre7, it
> works better than before, but still I have some problems:
> 
> the cursor is visible only at 8 bit depth, with 16 or 32 bit it just
> disappears, and at 8 bit it is a big full scale rectangular cursor
> (no underline).

Known problem with fbdev's in 2.4. I have to find out if
that can be fixed easily, though implementing HW cursor would
cure it as well...

> I couldn't find a way to set the resolution at boot time (I use the
> driver compiled in), I tried the following, all being ignored:
> radeonfb:1024x768-8@60
> radeon:1024x768-8@60

That should work (the second one actually), I'll investigate why
it doesn't. What mode do you get instead ?

Make sure you used "video=", that is you should have on your kernel
command line video=radeon:1024x768-8@60

> I am using an ugly fbset in a random boot script, but it just changes the
> resolution for the first console. This is probably the biggest problem I
> saw until now...

Use fbset -a

> Finally dmesg says:
> 
> PCI: Found IRQ 11 for device 01:00.0
> radeonfb: ref_clk=2700, ref_div=12, xclk=20000 from BIOS
> Console: switching to colour frame buffer device 80x30
> radeonfb: ATI Radeon 9000 If DDR SGRAM 64 MB
> radeonfb: DVI port no monitor connected
> radeonfb: CRT port CRT monitor connected
>                    ^^^
> But I have an LCD on the CRT port, I saw some LCD support in radeonfb.c,
> but perhaps it was only on DVI port.

If it's connected to an analgog VGA output, it is considered as a CRT
and that's normal, there's nothing "smart" I can do about it. I could
probably figure out it's a flat panel from the EDID and default to a
better mode, but complete EDID & DDC management is something I don't
plan on implementing in 2.4 though I will do it in 2.5/2.6 as soon
as I get enough time.

Ben.

