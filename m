Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbVBGOaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVBGOaL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 09:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbVBGO2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 09:28:48 -0500
Received: from [195.23.16.24] ([195.23.16.24]:50054 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261432AbVBGO1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 09:27:40 -0500
Message-ID: <42077AC4.5030103@grupopie.com>
Date: Mon, 07 Feb 2005 14:27:16 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam Sulmicki <adam@cfar.umd.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>,
       Jon Smirl <jonsmirl@gmail.com>, ncunningham@linuxmail.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Li-Ta Lo <ollie@lanl.gov>
Subject: Re: [RFC] Reliable video POSTing on resume
References: <e796392205020221387d4d8562@mail.gmail.com>  <420217DB.709@gmx.net> <4202A972.1070003@gmx.net>  <20050203225410.GB1110@elf.ucw.cz>  <1107474198.5727.9.camel@desktop.cunninghams> <4202DF7B.2000506@gmx.net>  <1107485504.5727.35.camel@desktop.cunninghams>  <9e4733910502032318460f2c0c@mail.gmail.com>  <20050204074454.GB1086@elf.ucw.cz>  <9e473391050204093837bc50d3@mail.gmail.com>  <20050205093550.GC1158@elf.ucw.cz> <1107695583.14847.167.camel@localhost.localdomain> <Pine.BSF.4.62.0502062107000.26868@www.missl.cs.umd.edu>
In-Reply-To: <Pine.BSF.4.62.0502062107000.26868@www.missl.cs.umd.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Sulmicki wrote:
> 
> hi all,
>     I would like point to work done by Li-Ta Lo.
> 
>     It allows you to completely initalize the VGA BIOS w/out using
>     PC BIOS at all.
> 
>     http://www.clustermatic.org/pipermail/linuxbios/2005-January/010236.html 
> 
>     unforunatelly the information the web is somewhat sparse, but
>     you can get more info by following the archive of the
>     thread (which head I listed above) and perhaps by posting to
>     linuxbios mailing list (Ollie, is somewhat buy those days with his
>     new baby).

I did some work on reducing the core x86 emulation code (and have my 
name mentioned in that thread for it). The code size went from 59kB to 
38kB. This does not include emulation of BIOS functions or hardware 
(like the standard PC timer).

It seems to me that x86 emulation in the kernel is the way to go because:

1 - it's portable. Can run on any architecture.

2 - runs in a controled environment. Every memory / io access is 
controlled by the emulator. We don't just "jump" into obscure BIOS code 
and hope everything goes well.

3 - it's always there and can be executed at *any* time: booting, 
returning from suspend, etc. Also it would allow the VESA framebuffer 
driver to change graphics mode at any time (for instance).

I still don't have hard numbers from the work Li-Ta Lo is doing (I'm 
CC'ing him on this thread to see if he can shed some light here), but I 
guess that you could have the complete emulator for about 50kB of code.

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
