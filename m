Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315182AbSE2MGC>; Wed, 29 May 2002 08:06:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315191AbSE2MGB>; Wed, 29 May 2002 08:06:01 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:6532 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S315182AbSE2MGA>;
	Wed, 29 May 2002 08:06:00 -0400
Date: Wed, 29 May 2002 14:05:15 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Neale Banks <neale@lowendale.com.au>, linux-kernel@vger.kernel.org
Subject: Re: odd timer bug, similar to VIA 686a symptoms
Message-ID: <20020529140515.A8522@ucw.cz>
In-Reply-To: <Pine.LNX.4.05.10205291912340.2523-100000@marina.lowendale.com.au> <1022676387.4124.162.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2002 at 01:46:27PM +0100, Alan Cox wrote:
> On Wed, 2002-05-29 at 10:25, Neale Banks wrote:
> >> May 28 11:19:54 gull kernel: timer.c: VIA bug check triggered. Value read 65500 [0xffdc], re-read 65485 [0xffcd]
> > May 28 11:19:55 gull kernel: timer.c: VIA bug check triggered. Value read 65500 [0xffdc], re-read 65486 [0xffce]
> > May 28 11:19:56 gull kernel: timer.c: VIA bug check triggered. Value read 65500 [0xffdc], re-read 65486 [0xffce]
> > May 28 11:19:57 gull kernel: timer.c: VIA bug check triggered. Value read 65499 [0xffdb], re-read 65484 [0xffcc]
> > May 28 11:19:58 gull kernel: timer.c: VIA bug check triggered. Value read 65497 [0xffd9], re-read 65483 [0xffcb]
> > 
> > Anyone got any good theories what's going on here, given that this is a
> > ~1995 vintage laptop with a Pentium-120 (which I'm assured doesn't have a
> > VIA 686a ;-)?
> 
> Neptune chipsets at least had latching bugs on timer reads. What chipset
> is the laptop ?

This is unlikely to be the latching bug - note the values are near to
65535 - that means the timer is reprogrammed to count from 0xffff down
instead from LATCH. That is because of the suspend I presume. What's
weird is that the VIA fix doesn't program it to the correct value, or
perhaps is that missing from the patch?

-- 
Vojtech Pavlik
SuSE Labs
