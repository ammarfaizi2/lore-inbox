Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285322AbRLFX5r>; Thu, 6 Dec 2001 18:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285325AbRLFX52>; Thu, 6 Dec 2001 18:57:28 -0500
Received: from mail1.amc.com.au ([203.15.175.2]:50436 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S285322AbRLFX5U>;
	Thu, 6 Dec 2001 18:57:20 -0500
Message-Id: <5.1.0.14.0.20011207103824.00a17ec0@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 07 Dec 2001 10:57:15 +1100
To: <linux-kernel@vger.kernel.org>
From: Stuart Young <sgy@amc.com.au>
Subject: Re: NVIDIA kernel module
Cc: Erik Elmore <lk@bigsexymo.com>, Michael Kummer <frost@packetst0rm.net>,
        Stefan Smietanowski <stesmi@stesmi.com>
In-Reply-To: <Pine.LNX.4.40.0112061618000.240-100000@warp4>
In-Reply-To: <3C0F8A5E.6060501@stesmi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:19 PM 6/12/01 +0100, Michael Kummer wrote:
>any1 got the NVIDIA module working when eg. the nvidia framebuffer code is
>enabled?

The RivaFB code and the Nvidia module stamp all over each other afaik. Have 
you tried this with their latest binary module (1.0-2313)? Least that now 
plays nicely with devfs. Only real way (afaik) is unload the RivaFB module 
when the Nvidia module is loaded, and vice versa.

Of course, this means that while X is running the consoles won't have 
FrameBuffer, but hey, them's the trade-offs. You can do this in 
modules.conf (modutils stuff) using the pre-install option.

eg:
  pre-install NVdriver rmmod rivafb

If the NVdriver module is unloaded when you quit X (depends if it was 
dynamically loaded by X, which "should" work if modutils isn't broken [not 
usual] and the appropriate stuff is placed there by the Nvidia install), 
you could use a modutils post-remove option.

eg:
  post-remove NVdriver modprobe rivafb

Of course, there is no guarantee that it will unload immediately (if at 
all), so you may lose the FrameBuffer till NVdriver is purged/removed. I 
have no idea if this would work, as I don't use the RivaFB module at all.

If I got this wrong, I'm sure Keith Owens will enlighten me (probably with 
a large clue stick - since it's in relation to one of his pet hates, 
Nvidia). *grin*

Stuart Young - sgy@amc.com.au
(aka Cefiar) - cefiar1@optushome.com.au

[All opinions expressed in the above message are my]
[own and not necessarily the views of my employer..]

