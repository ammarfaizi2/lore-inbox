Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132513AbQL3CF1>; Fri, 29 Dec 2000 21:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132603AbQL3CFR>; Fri, 29 Dec 2000 21:05:17 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:56072 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132513AbQL3CFH>; Fri, 29 Dec 2000 21:05:07 -0500
Subject: Re: [PATCH] i810 audio fixes for 2.4.0-test13-pre5
To: jim@federated.com (Jim Studt)
Date: Sat, 30 Dec 2000 01:36:22 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200012300045.SAA25016@core.federated.com> from "Jim Studt" at Dec 29, 2000 06:45:45 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14CAwa-00061q-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch addresses three problems in the i810-audio driver for
> 2.4.0-test13-pre5.  I will be happy to split it if someone doesn't like
> part of it.  (I see pre6 just popped out, there are no changes to this
> driver in pre6.)

> 1) "DMA overrun on send" - this contains a patch from Tjeerd Mulder that
>    prevents almost all of this.  I still get an occasional one during
>    heavy video activity, the driver was unusable before.  (This is a smaller 
>    patch than the previous flamed patch, it does no format conversion.)

Yeah I have Tjeerd's patches and no quibbles with them

> 3) Add a module parameter to supress powercycling the DACs on rate change -
>    This causes a big pop on the outputs at least for the CS4299 codec in
>    the emachines etower 700, probably others.  I honestly can't find a 
>    reason to power cycle the DACs.  There's nothing in the AC97 spec 
>    that suggests it should be done.  The code is common to OSS and ALSA.
>    I left the old behavior as the default.  Maybe later the default should
>    change if it turns out that everyone wants to force the parameter to 
>    zero.

What I would love someone to do (hint ;)) is to move the 

	set_dac_speed
	set_adc_speed
	powerup_amp
	powerdown_amp

type stuff into the ac97_codec - actually have a codec_ops in the AC97 
for each type.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
