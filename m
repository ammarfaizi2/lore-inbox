Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbUDAI31 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 03:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbUDAI31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 03:29:27 -0500
Received: from gprs213-219.eurotel.cz ([160.218.213.219]:45184 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262454AbUDAI3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 03:29:17 -0500
Date: Thu, 1 Apr 2004 10:29:05 +0200
From: Pavel Machek <pavel@suse.cz>
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@suse.cz, Tjeerd.Mulder@fujitsu-siemens.com,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: via82xx cmd line parsing is evil [was Re: Sound on newer arima notebook...]
Message-ID: <20040401082905.GE224@elf.ucw.cz>
References: <20040331145206.GA384@elf.ucw.cz> <s5h7jx1xdel.wl@alsa2.suse.de> <20040401080954.GA464@elf.ucw.cz> <s5hr7v8w1gr.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hr7v8w1gr.wl@alsa2.suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > via82xx command line parsing code is *evil*. It has completely
> > different parameters as a module / in kernel, and in-kernel parameters
> > shift according to the joystick support! (which is config_time option). Ouch.
> 
> yep, i know it - it annoys me too...
> 
> > Is there some easy way to convert MODULE_PARM with an array to some
> > more modern interface?
> 
> there is a patch pending in my tree to allow empty boot options, such
> as
> 	snd-via82xx=,,,,,2
> but it doesn't improve so much.
> 
> perhaps the better way would be like
> 
> 	snd-via82xx=enable:1,ac97_quirk:4
> 
> ??
> 
> in this way, it's hard to keep the compatibility with old boot
> parameters, but i don't think no one will complain if they see it
> nicer.

Its so broken that we do not want compatibility, I believe. Having to
use snd-via82xx=,,,,,2 normally, but add one "," if joystick is
configured in is evil.

snd-via82xx=enable:1 syntax is ugly, too, and we have better syntax
already. via82xx.enable=1 via82xx.ac97_quirk=2 should be possible with
new param handling code. I'm just not sure how it is supposed to work
with arrays:

static char *psmouse_proto;
static unsigned int psmouse_max_proto = -1U;
module_param_named(proto, psmouse_proto, charp, 0);
MODULE_PARM_DESC(proto, "Highest protocol extension to probe (bare,
imps, exps). Useful for KVM switches.");

...automatically produces "proto" param for module and "psmouse.proto"
param for kernel.

Something similar should be the way to go.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
