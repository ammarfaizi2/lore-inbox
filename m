Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264425AbRFIRZY>; Sat, 9 Jun 2001 13:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264423AbRFIRZO>; Sat, 9 Jun 2001 13:25:14 -0400
Received: from erasmus.off.net ([64.39.30.25]:17680 "HELO erasmus.off.net")
	by vger.kernel.org with SMTP id <S264416AbRFIRZB>;
	Sat, 9 Jun 2001 13:25:01 -0400
Date: Sat, 9 Jun 2001 13:25:01 -0400
From: Zach Brown <zab@zabbo.net>
To: Lukas Schroeder <lukas@edeal.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] ess maestro, support for hardware volume control
Message-ID: <20010609132501.C20514@erasmus.off.net>
In-Reply-To: <20010609190917.A10629@kosmo.edeal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010609190917.A10629@kosmo.edeal.de>; from lukas@edeal.de on Sat, Jun 09, 2001 at 07:09:17PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> this patch applies to (at least) 2.4.3 up to and including 2.4.6-pre2.
> It enables the hardware volume control feature of the maestro.

cool.  I had support for this in the mega-patch I posted long ago, but
I never seperated and submitted those changes 'cause I'm a moron.

> By giving hwv=0 to insmod one can explicitly disable it. Setting

can we have a better name like 'hwvol_enable'?

> +		set_mixer(c, 0, val);

careful.  you just used the indirect ac97 registers without holding the
card's lock..  if another processor does a mixer ioctl while this is
happening you'll get weird behaviour.

it looks like you should just be able to spin_{,un}lock(card->lock)
around that call, but the maestro locking is so friggin' twisty.. this
gets even more exciting when the driver uses ac97_codec, which the
mega-patch also had in it.

Fix the locking (and the obscure parameter name? :)) and it looks
fine.. good work.

-- 
 zach
