Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263123AbTCLMlL>; Wed, 12 Mar 2003 07:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263163AbTCLMlK>; Wed, 12 Mar 2003 07:41:10 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:38922 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S263123AbTCLMlJ>; Wed, 12 Mar 2003 07:41:09 -0500
Message-Id: <200303121243.h2CChWu29693@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: adrian.golumbovici@t-online.de (Adrian Golumbovici),
       <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.4.21-pre5 crash at boot with 1GB memory, highmem 4GB  and vga=788 in lilo
Date: Wed, 12 Mar 2003 14:40:38 +0200
X-Mailer: KMail [version 1.3.2]
References: <001a01c2e757$a93acfd0$162ea8c0@ares>
In-Reply-To: <001a01c2e757$a93acfd0$162ea8c0@ares>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 March 2003 00:51, Adrian Golumbovici wrote:
> Motherboard: Asus A7V8X
> CPU: Athlon XP 2400+
> Memory: 2 modules DDR PC333 of 512MB each. (3.5 hours continuous
> memtest86 showed no error in any of them).

cpuburn sometimes uncover memory failures too (especially burnMMX).
But read on, this is most likely not the case for you.

> Graphics Card: Atlantis Sapphire Radeon 9700 Pro
>
> With just one module (same thing with either of them) works ok. As
> soon as I have 2nd module in it crashes at kernel boot (lilo menu
> comes on OK but after selecting kernel it freezes with capslock and
> scrolllock lights on and black screen). Highmem is set to 4G as the
> subject line says. Tried all possible settings as append boot
> parameter (noapic, noacpi, acpi=off, etc) and it worked only when
> vga=ask (I picked 2 values out of them in 2 tests i.e. 0 and 6 and it
> worked ok).

So it works with standard 80x25 text mode? ok...

AFAIK vesa mode 788=0x314 - 800x600 65k colors (5:6:5 r:g:b bits),
am I remembering right?

Did you try other framebuffer modes like 640x480 256 colors?
I suspect they will fail similarly, but worth testing that.

> Put the original settings back in lilo.conf and tried to
> play with the mem setting at boot. Lowest value at which still
> crashes is mem=888M, highest value at which it doesn't crash or give
> any segfault errors is 848M.

This is interesting. Where does your linear framebuffer memory start?
Post dmesg, /proc/iomem. You may do this from mem=848M boot first,
then from crashing one.

I suspect that kernel somehow overlayed RAM and video RAM ;)

> Everything in between these values
> doesn't crash, but gives a huge list of segfaults. It still boots,
> but most modules are down (cannot be loaded due to the huge list of
> segfaults) and is highly unstable.

You can try "mem=exactmap mem=640K@0 mem=nnnM@1M" to make kernel
avoid stomping into video memory.

It's a bug, we'll need to check why does that happen.

> Windows 2000 Pro as second OS with
> dualboot (I know... I know... I hate M$ products but I have to play
> some games which don't work under linux from time to time... :) )
> boots ok and starting a divx encoding with a cache in RAM set to
> 1024MB (to force it use all main RAM and see what happens) still
> didn't crash after 2 hours of encoding, while main unused RAM went
> down to 2.5MB of RAM (didn't go past that, but instead increased the
> swap only).

Let's debug it, and Linux will not crash too.
--
vda
