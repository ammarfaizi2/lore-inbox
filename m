Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbVLTS6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbVLTS6Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 13:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbVLTS6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 13:58:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:65412 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750766AbVLTS6P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 13:58:15 -0500
Date: Tue, 20 Dec 2005 10:57:49 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>, Ricardo Cerqueira <v4l@cerqueira.org>,
       mchehab@brturbo.com.br,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org,
       Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [Alsa-devel] 2.6.15-rc6: boot failure in saa7134-alsa.c
In-Reply-To: <20051220183455.GC19797@master.mivlgu.local>
Message-ID: <Pine.LNX.4.64.0512201056060.4827@g5.osdl.org>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
 <20051220131810.GB6789@stusta.de> <20051220155216.GA19797@master.mivlgu.local>
 <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org> <20051220183455.GC19797@master.mivlgu.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sergey points out (but only to me) that sound/core/sound.c probably needs 
the same thing.

Sound people, can you pls check the dependencies? Are there any other 
"sound core" initialization that needs to happen early?

		Linus

On Tue, 20 Dec 2005, Sergey Vlasov wrote:

> On Tue, Dec 20, 2005 at 10:24:55AM -0800, Linus Torvalds wrote:
> > 
> > 
> > On Tue, 20 Dec 2005, Sergey Vlasov wrote:
> > > 
> > > saa7134-alsa is trying to initialize before the ALSA core has initialized.
> > > Probably no one has tested CONFIG_VIDEO_SAA7134=y.
> > 
> > Adrian, does it work if you change the "module_init()" in 
> > sound/sound_core.c into a "fs_initcall()"?
> 
> And in sound/core/sound.c (ALSA causes the problem here, not OSS).
> 
> > That should make sure that the sound core gets to initialize before normal 
> > drivers do.
> 
