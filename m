Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316860AbSHYAXl>; Sat, 24 Aug 2002 20:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316880AbSHYAXl>; Sat, 24 Aug 2002 20:23:41 -0400
Received: from p020.as-l031.contactel.cz ([212.65.234.212]:47233 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S316860AbSHYAXk>;
	Sat, 24 Aug 2002 20:23:40 -0400
Date: Sun, 25 Aug 2002 02:22:59 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: David Madore <david.madore@ens.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disabling frame buffer
Message-ID: <20020825002259.GD7501@ppc.vc.cvut.cz>
References: <20020824101743.A6260@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020824101743.A6260@clipper.ens.fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 24, 2002 at 10:17:43AM +0200, David Madore wrote:
> 
> and later it changes its mind,
> 
> radeonfb: ref_clk=2700, ref_div=12, xclk=16600 from BIOS
> Console: switching to colour frame buffer device 80x30
> radeonfb: ATI Radeon 7500 QW  DDR SGRAM 64 MB
> radeonfb: DVI port no monitor connected
> radeonfb: CRT port CRT monitor connected
> vga16fb: initializing
> vga16fb: mapped to 0xc00a0000
> fb1: VGA16 VGA frame buffer device

video=radeon:off to disable Radeon
video=vga16:off to disable VGA16
video=radeon:off video=vga16:off to get back text-based vgacon

But! if you have 'video=radeon:1024x768@60' in /etc/lilo.conf,
you are out of luck: 'video=radeon:off' will not work for you in
such configuration, because of kernel will see your
'video=radeon:XXX' from /etc/lilo.conf's append before 'video=radeon:off'
you typed interactively at LILO prompt. Maybe someone should
fix it, but it is not trivial...

> I know it's a bit silly to insist on getting a plain text mode, and
> even sillier not to want to just recompile, but I'd still appreciate
> some help here.

If you want text-based framebuffer, I still have vga16fb text mode
patch in my kernel tree:

mode "640x480-60"
    # D: 25.176 MHz, H: 31.469 kHz, V: 59.942 Hz
    geometry 640 480 640 6553 0
    timings 39721 48 16 33 10 96 2
    rgba 6/0,6/0,6/0,0/0
endmode

Frame buffer device information:
    Name        : VGA16 VGA
    Address     : 0xa0000
    Size        : 65536
    Type        : CGA/EGA/VGA Color text
    Visual      : PSEUDOCOLOR
    XPanStep    : 8
    YPanStep    : 1
    YWrapStep   : 0
    LineLength  : 160
    Accelerator : No
						Petr Vandrovec
						vandrove@vc.cvut.cz

