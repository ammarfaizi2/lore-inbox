Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262146AbVADUbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262146AbVADUbM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 15:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbVADU1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 15:27:51 -0500
Received: from gprs214-202.eurotel.cz ([160.218.214.202]:57829 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262100AbVADUZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 15:25:41 -0500
Date: Tue, 4 Jan 2005 21:22:45 +0100
From: Pavel Machek <pavel@suse.cz>
To: Takashi Iwai <tiwai@suse.de>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: Power management of old ISA devices (Re: mark older power managment as deprecated)
Message-ID: <20050104202245.GB7924@elf.ucw.cz>
References: <20050104124659.GA22256@elf.ucw.cz> <s5h3bxhgncy.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h3bxhgncy.wl@alsa2.suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > What about this patch? It marks old power managemnt as obsolete (and
> > also adds some sparse-style type checking; typedefs were already there
> > so why not use them?). I think it should go in, so that we can get a
> > rid of old power managment infrastructure post-2.6.11.
> 
> ALSA core part still includes pm_register/unregister() for old
> (non-PnP) ISA devices.
> 
> What is the proper way to register/unregister PM hooks for such
> devices?

How are PnP ISA devices handled?

Right solution for ISA devices is probably to create an ISA bus in
driver model, and hook such devices there....

Alternatively, you might just hang them onto platform bus, in similar
way i8042 uses...

Imagine this configuration:

cpu -- PCI #1 -- PCI to PCI bridge -- PCI #2 -- PCI to ISA bridge -- sound card #1 on 0x100
              \- PCI to PCI bridge -- PCI #3 -- PCI to ISA bridge -- sound card #2 on 0x100

...would you say that's supported? If yes you'd need to create ISA
buses and do it properly, otherwise hooking to platform bus is
probably acceptable.


								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
