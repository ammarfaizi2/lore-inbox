Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132101AbRDAIvW>; Sun, 1 Apr 2001 04:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132077AbRDAIvL>; Sun, 1 Apr 2001 04:51:11 -0400
Received: from smtp9.xs4all.nl ([194.109.127.135]:3267 "EHLO smtp9.xs4all.nl")
	by vger.kernel.org with ESMTP id <S132056AbRDAIu7>;
	Sun, 1 Apr 2001 04:50:59 -0400
From: thunder7@xs4all.nl
Date: Sun, 1 Apr 2001 10:55:39 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: [lkml]Re: Matrox G400 Dualhead
Message-ID: <20010401105539.A892@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
In-Reply-To: <20010331174638.16806.qmail@venus.postmark.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010331174638.16806.qmail@venus.postmark.net>; from jbk@postmark.net on Sat, Mar 31, 2001 at 05:46:38PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 31, 2001 at 05:46:38PM +0000, J Brook wrote:
> > I have a similar problem with my G450, booting into the framebuffer,
> > then loading xdm and working in X, and then switching back to the 
> > console. I may have another detail to add in that when I switch back
> > to the console from X, my monitor blanks and displays the warning 
> > that the frequencies are out of range.
> 
>  I think I have a work around. Boot up 2.4.3 with the framebuffer
> enabled as normal. Log in as root and use the fbset program to change
> the settings for all the framebuffers.
> eg.
> 
> fbset -a 1024x768-70
> 
> or whatever works for you. fbset has its own man page.
> 
> This makes everything hunky-dory for me, in that after running fbset
> I
> can go in and out of X without ever losing the video signal.
> 
Well, that certainly doesn't work for me (2.4.2-ac28, G400):

fbset -i:

mode "1600x1200-80"
    # D: 205.846 MHz, H: 99.347 kHz, V: 79.989 Hz
    geometry 1600 1200 1600 5241 16
    timings 4858 272 48 32 5 152 5
    accel true
    rgba 5/11,6/5,5/0,0/0
endmode

Frame buffer device information:
    Name        : MATROX
    Address     : 0xd4000000
    Size        : 16773120
    Type        : PACKED PIXELS
    Visual      : TRUECOLOR
    XPanStep    : 8
    YPanStep    : 1
    YWrapStep   : 0
    LineLength  : 3200
    MMIO Address: 0xd6000000
    MMIO Size   : 16384
    Accelerator : Matrox G400

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 03) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G400 32Mb SGRAM
	Flags: bus master, medium devsel, latency 32, IRQ 10
	Memory at d4000000 (32-bit, prefetchable) [size=32M]
	Memory at d6000000 (32-bit, non-prefetchable) [size=16K]
	Memory at d7000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: <available only to root>

If I use X on an accelerated, normal Matrox screen, my monitor complains
on exit:

fH 49.4 KHz, fV 39.8 Hz

(and it doesn't sync at 40 Hz vertical refresh :-( ).

This is _half_ of the normal 80 Hz. Using fbset -a "1600x1200-80" before
X, of after X, doesn't do anything. Does anybody know what to hack out
in X to get it to _not_ reset my G400 to some unusable state? 3.3.6 was
didn't do this. I can use the framebuffer-screen just fine, but I miss
the DGA extension.

Thanks,
Jurriaan
-- 
BOFH excuse #329:

Server depressed, needs Prozak
GNU/Linux 2.4.2-ac28 SMP/ReiserFS 2x1743 bogomips load av: 0.20 0.05 0.01
