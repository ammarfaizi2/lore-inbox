Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129790AbRAEVlE>; Fri, 5 Jan 2001 16:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129933AbRAEVky>; Fri, 5 Jan 2001 16:40:54 -0500
Received: from tamqfl1-ar1-128-154.dsl.gtei.net ([4.33.128.154]:3065 "EHLO
	linus.southpark") by vger.kernel.org with ESMTP id <S129790AbRAEVku>;
	Fri, 5 Jan 2001 16:40:50 -0500
Message-ID: <3A563F5A.9B50B2B3@leoninedev.com>
Date: Fri, 05 Jan 2001 16:40:42 -0500
From: Bryan Mayland <bmayland@leoninedev.com>
Organization: Leonine Development, Inc.
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Gerd Knorr <kraxel@bytesex.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VESA framebuffer w/ MTRR locks 2.4.0 on init
In-Reply-To: <3A55FAC9.9EB4C967@leoninedev.com> <E14Ea7x-00081J-00@the-village.bc.nu> <20010105183344.A2445@goldbach.in-berlin.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr wrote:

> Well, vesafb really depends on what the vesa bios says...

    Exactly my problem.  In my laptop, I have a NeoMagic 2160 which does not have use
the last 64k of video for sound buffer like the NeoMagic 256es do yet it still
reports that the memory is not video memory.  Both XFree86 and SVGALib hard code the
amout of available video memory based on the PCI id of the neomagic device, which
tells me that there might not be a way to detect it properly.  What I'm suggesting is
that we "Avoid the probe!" (which is fun to say), and add a way for the user to
override the amount of memory detected by the VESA int 0x10 call.  There is only
about 10 lines of code requited to make the change, and it can't break anything if
you don't turn it on.

    I wish there was a way to detect that the code wrapped memory before the hardware
did, but that would be un-possible to probe (AFAIK).  You can detect that ywrap isn't
working properly by writing a magic number to offset 0, and attempt to read if from
offset [memsize], and see if you get the same value back.  This doesn't fix the
problem, it just assertains if it is working properly or not.

> That's why it has all may-have-problems features turned off by default:
> no ywrap, no mtrr.  At least it was this way last time I touched it.

    I was pretty suprised ywrap worked at all on my system.  The speed increased over
"redraw" is quite dramatic.

    So what do you say.  Can we use my patch to allow the user to override the VESA
detected memory size... or does anyone else have a better plan?

Bry

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
