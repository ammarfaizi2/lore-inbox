Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264037AbSIVKn7>; Sun, 22 Sep 2002 06:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264040AbSIVKn7>; Sun, 22 Sep 2002 06:43:59 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:46089 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S264037AbSIVKn5>;
	Sun, 22 Sep 2002 06:43:57 -0400
Date: Sun, 22 Sep 2002 12:48:54 +0200
From: Willy Tarreau <willy@w.ods.org>
To: walairat kladmuk <praduddao@hotmail.com>
Cc: linux-kernel@vger.kernel.org, dominicscaife@yahoo.com
Subject: Re: Kernel Issues
Message-ID: <20020922104854.GB13899@alpha.home.local>
References: <F138D7O5CkJNQNXSqVd00002250@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F138D7O5CkJNQNXSqVd00002250@hotmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2002 at 09:42:21AM +0000, walairat kladmuk wrote:

a few questions :
 - are you sure your CPU isn't overclocked (should be about 1.3 Ghz) ?
 - are you sure your RAM doesn't have defects (try memtest) ?
 - what are the kernel versions shipped with those distros ?
 - perhaps your bios setup has ECC ram enabled or some other bad settings ?

> HD:
> Seagate 40MB

I suppose it's 40 GB instead.

> In my exploring of the installation via the rescue mode, I noticed the 
> Config file in boot and was wondering how this is used?

it's used when you want to recompile your kernel. Copy it as
/usr/src/linux/.config, start "make oldconfig" to see if options have changed
between it and the kernel you try to compile, then "make menuconfig" and
disable unwanted options (perhaps machine check exception). Then
"make clean && make dep && make bzImage modules", and try to boot on the new
bzImage (arch/i386/boot/bzImage).

> The third party kernel modules that are asked for when installing might 
> also be worth a try... advice here appreciated.

it seems as your kernel hangs very early, too early to even load a module.
 
> My gut feeling is that given the error message the boot fails when looking 
> for an ISApnp card... my motherboard is very new 
> (http://www.octek.com.hk/products/ATI/ati13xp-mse.htm) and doesn't have an 
> ISA slot.

try passing "noisapnp" in this case. But you don't need ISA slots to have
onboard ISA chips anyway.
 
> D Scaife
> dominicscaife@yahoo.com (yahoo only sends html style mail which list sees 
> as spam hence the reason this comes from elsewhere)

I also have a yahoo account without this problem because I've disabled
HTML mails.
 
> p.s. Also played with the System.map and tried deleting all those lines 
> beginning with isapnp... no luck... these are shots in the dark :)ut 

System.map is used by insmod, ksymoops and other tools which need to know
the address of certain kernel symbols. That's unrelated to your problem.
Your problem comes from the kernel image itself. At this stage, it cannot
read any file. BTW, have you tried with the kernel used by the install to boot ?

> feeling is that given the error message the boot fails when looking for an 
> ISApnp card... my motherboard is very new (see profile) and doesn't have an 
> ISA slot.

Your motherboard isn't unique ; these days, it's very hard to find a
motherboard providing at least one ISA slot.
 
hoping this helps,
Willy

