Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270965AbTGPSoc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 14:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271053AbTGPSnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 14:43:16 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:16787 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S270965AbTGPSll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 14:41:41 -0400
Date: Wed, 16 Jul 2003 20:56:19 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jens Axboe <axboe@suse.de>, Dave Jones <davej@codemonkey.org.uk>,
       vojtech@suse.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PS2 mouse going nuts during cdparanoia session.
Message-ID: <20030716185619.GD20241@ucw.cz>
References: <20030716165701.GA21896@suse.de> <20030716170352.GJ833@suse.de> <1058375425.6600.42.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058375425.6600.42.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 06:10:33PM +0100, Alan Cox wrote:
> On Mer, 2003-07-16 at 18:03, Jens Axboe wrote:
> > > The IDE CD drive is using DMA, and interrupts are unmasked.
> > > according to the logs, its happened 32 times since I last
> 
> > Yes. You can try and make the situation a little better by unmasking
> > interrupts with -u1. Or you can try and use a ripper that actually uses
> 
> He already is 
> 
> > SG_IO, that way you can use dma (and zero copy) for the rips. That will
> > be lots more smooth.
> 
> So why isnt this occuring on 2.4 .. thats the important question here is
> this a logging thing, a new input layer bug, an ide bug or what ?

This is basically because the check for lost bytes wasn't present in
2.4. Now that it is there, it works well with real lost bytes, but will
fire also in case when the mouse interrupt was delayed for more than
half a second, or if indeed a mouse interrupt gets lost. The 2.5 kernel
by default programs the mouse to high speed reporting (up to 200 updates
per second). This may, possibly make the problem show up easier. There
might be real lost bytes on some machines, too. This can be checked by
defining DEBUG in i8042.c

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
