Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292015AbSBAU4Y>; Fri, 1 Feb 2002 15:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292001AbSBAU4Q>; Fri, 1 Feb 2002 15:56:16 -0500
Received: from adsl-63-197-0-76.dsl.snfc21.pacbell.net ([63.197.0.76]:15887
	"HELO www.pmonta.com") by vger.kernel.org with SMTP
	id <S292015AbSBAU4H>; Fri, 1 Feb 2002 15:56:07 -0500
From: Peter Monta <pmonta@pmonta.com>
To: garzik@havoc.gtf.org
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020201153346.B2497@havoc.gtf.org> (message from Jeff Garzik on
	Fri, 1 Feb 2002 15:33:46 -0500)
Subject: Re: Continuing /dev/random problems with 2.4
In-Reply-To: <20020201031744.A32127@asooo.flowerfire.com> <1012582401.813.1.camel@phantasy> <a3enf3$93p$1@cesium.transmeta.com> <20020201202334.72F921C5@www.pmonta.com> <20020201153346.B2497@havoc.gtf.org>
Message-Id: <20020201205605.ED5111C5@www.pmonta.com>
Date: Fri,  1 Feb 2002 12:56:05 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Anything that is meant to be a server really pretty much needs an
> > > enthropy generator these days.
> > 
> > Many motherboards have on-board sound.  Why not turn the mic
> > gain all the way up and use the noise---surely there will be
> > a few bits' worth?
>
> Even if you think you have a good true source of random noise, you need
> to run good fitness tests on the data to ensure it's truly random.

Well, yes and no.  What you really need is a conservative estimate
of how much entropy is contained in n bits of input; a cryptographic
hash, such as MD5, will distill out the "truly random".  The comments
in drivers/char/random.c claim that the input hash is cryptographically
noncritical, but to be pedantic, maybe MD5 the audio noise before
writing to /dev/random.

Assuming the sound-card output looks like reasonable noise of
a few LSBs amplitude, a conservative estimate might be 0.1 bit
of entropy per sample.  This is 9600 bits of entropy per second
from a stereo card, more than enough.

A small daemon would wake up every so often, check if /dev/random
needs topped up, read some audio samples, MD5(), write(),
ioctl(# of claimed entropy bits).  I haven't seen the i810 RNG tools,
but I guess they do something similar.
