Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262850AbUFSTFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbUFSTFN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 15:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUFSTFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 15:05:13 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:22407 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S262850AbUFSTFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 15:05:05 -0400
Date: Sat, 19 Jun 2004 21:05:03 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: zdzichu@irc.pl
Cc: linux-kernel@vger.kernel.org
Subject: Re: Matroxfb in 2.6 still doesn't work in 2.6.7
Message-ID: <20040619190503.GB17053@vana.vc.cvut.cz>
References: <20040618211031.GA4048@irc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040618211031.GA4048@irc.pl>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2004 at 11:10:31PM +0200, Tomasz Torcz wrote:
> 
>  Hi,
> 
> I am constantly having problems with my G550 matrox card.
> I'm trying to get same video mode in framebuffer as in XFree.
> I'm using 1280x1024x16 in XFree but this mode in fb don't work.
> My LCD monitor turns black and slowly change into all white.
> There is some very bright white area in lower right corner of monitor.

When monitor goes into this mode? Immediately after kernel starts, or
after you start X? Picture you see happens with some (stupid) monitors
if there are missing sync pulses. Are you sure that you do not have any
fbset or stty commands in your startup scripts? What if you boot with init=/bin/bash?

> % dmesg | grep -i matrox
> Kernel command line: root=/dev/hda4 acpi=force ro video=matroxfb:1280x1024-16@60
> matroxfb: Matrox G550 detected
> matroxfb: MTRR's turned on
> matroxfb: 1280x1024x16bpp (virtual: 1280x6553)
> matroxfb: framebuffer at 0xE8000000, mapped to 0xd080b000, size 33554432
> fb0: MATROX frame buffer device
> [drm] Initialized mga 3.1.0 20021029 on minor 0: Matrox Graphics, Inc. MGA G550 AGP
> matroxfb_crtc2: secondary head of fb0 was registered as fb1
> 
>  It stopped working somewhere in 2.5.x series. It still doesn't
> work in
> Linux version 2.6.7 (zdzichu@mother) (gcc version 3.4.0) #1 Fri Jun 18 22:39:14 CEST 2004

It works for me, with CRT analog monitor... What if you boot with
video=matroxfb:outputs:010,1280x1024-16@60 (if you plugged your LCD to analog
output) or video=matroxfb:outputs:100,1280x1024-16@60 (if you plugged your LCD to
digital output with digital-analog connector convertor) ?

You can also try patching your kernel with 
http://platan.vc.cvut.cz/ftp/pub/linux/matrox-latest/matrox-2.6.7-rc2-c1818.gz. It
should help you if videomode is destroyed by your initscripts.
							Best regards,
								Petr Vandrovec

