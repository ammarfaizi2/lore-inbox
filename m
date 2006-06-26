Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWFZQph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWFZQph (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWFZQph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:45:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:65458 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750789AbWFZQph (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:45:37 -0400
From: Andi Kleen <ak@suse.de>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: Alsa update in mainline broke ATI-IXP sound driver II
Date: Mon, 26 Jun 2006 18:45:32 +0200
User-Agent: KMail/1.9.3
Cc: perex@suse.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <200606252139.36002.ak@suse.de> <s5hpsgw9qgz.wl%tiwai@suse.de>
In-Reply-To: <s5hpsgw9qgz.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606261845.32450.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 June 2006 12:11, Takashi Iwai wrote:
> At Sun, 25 Jun 2006 21:39:35 +0200,
> Andi Kleen wrote:
> > 
> > 
> > Since I updated an ATI x86-64 box to 2.6.17-git6 sound doesn't work anymore.
> > 
> > I just get
> > 
> > ALSA lib confmisc.c:672:(snd_func_card_driver) cannot find card '0'
> > ALSA lib conf.c:3493:(_snd_config_evaluate) function snd_func_card_driver returned error: No such device
> (snip) 
> > User land is from SUSE 10.0
> 
> First check /proc/asound/cards after loading snd-atiixp.  If the ATI
> IXP entry appears, the device was initialized and set up.  If not,
> something wrong in the driver initialization.
> 
> Then check whether /dev/snd/controlC0 exists.  If not, it's likely a
> udev thingy.  Possibly upgrading udev package might help...

First /proc/asound appeared now - in the first try the modules weren't correctly loaded.
The card is shown there

 0 [IXP            ]: ATIIXP - ATI IXP
                      ATI IXP rev 0 with ALC658D at 0xfe029000, irq 217


I added some instrumentation to the driver now and the probe function seems
to run completely - at least it hits its return 0.

The device file is also still there so I don't think udev is to blame.

-Andi

