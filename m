Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbUA0NT3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 08:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263598AbUA0NT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 08:19:29 -0500
Received: from 62-43-5-49.user.ono.com ([62.43.5.49]:61103 "EHLO
	mortadelo.pirispons.net") by vger.kernel.org with ESMTP
	id S263584AbUA0NT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 08:19:27 -0500
Date: Tue, 27 Jan 2004 14:19:22 +0100
From: Kiko Piris <kernel@pirispons.net>
To: Xan <DXpublica@telefonica.net>
Cc: Zack Winkles <winkie@linuxfromscratch.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.1] fbdev console: can't load vga=791 and yes vga=ask!
Message-ID: <20040127131922.GA20659@pirispons.net>
Mail-Followup-To: Xan <DXpublica@telefonica.net>,
	Zack Winkles <winkie@linuxfromscratch.org>,
	linux-kernel@vger.kernel.org
References: <200401270153.12568.DXpublica@telefonica.net> <20040127040640.GA31326@theorem093.dyndns.org> <200401271324.33883.DXpublica@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401271324.33883.DXpublica@telefonica.net>
User-Agent: Mutt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2004 at 13:24, Xan wrote:

> Sorry. My graphics cards is ATI Radeon 9200.

Same graphics card here [1]. _Almost_ same problem:

I booted 2.6.1 with vga=795. It booted fine.

In 2.6.2-rc[12] I get a blank screen booting with that vga parameter.

With 2.6.1 if I tried to use radeonfb, system just booted with a vga
console and no fbdevice was available. If I try to use radeonfb in
2.6.2-rc[12] it only works with 640x480 resolution (any other resolution
results in an unsupported frequency on my monitor, system boots fine,
tough).

_Plus_, if I try to change the resolution (with fbset) on my radeonfb
console, it changes; but when I switch to another tty, the monitor gets
an unsupported frequency again and the only way to restore the image is
to blindly set the resolution again to 640x480 with fbset.

Relevant part of config follws:

$ cat /boot/config-2.6.2-rc2 | grep ^CONFIG | egrep -i "fb|radeon|console"
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_DRM_RADEON=m
CONFIG_FB=y
CONFIG_FB_VESA=y
CONFIG_FB_RADEON=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y

This output is exactly the same for 2.6.1, 2.6.2-rc1 and 2.6.2-rc2.

Please, let me know if I can provide any additional information.

Thanks in advance.


[1]
# lspci -s 01:00.1 -v
01:00.1 Display controller: ATI Technologies Inc: Unknown device 5d44 (rev 01)
        Subsystem: Unknown device 18bc:0171
        Flags: bus master, 66Mhz, medium devsel, latency 32
        Memory at d8000000 (32-bit, prefetchable) [size=128M]
        Memory at e5010000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: [50] Power Management version 2

-- 
Kiko
