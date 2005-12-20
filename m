Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbVLTUCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbVLTUCx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 15:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbVLTUCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 15:02:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9877 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750869AbVLTUCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 15:02:52 -0500
Date: Tue, 20 Dec 2005 11:59:20 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Sergey Vlasov <vsu@altlinux.ru>, Ricardo Cerqueira <v4l@cerqueira.org>,
       mchehab@brturbo.com.br,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
Subject: Re: [Alsa-devel] 2.6.15-rc6: boot failure in saa7134-alsa.c
In-Reply-To: <20051220191412.GA4578@stusta.de>
Message-ID: <Pine.LNX.4.64.0512201156250.4827@g5.osdl.org>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
 <20051220131810.GB6789@stusta.de> <20051220155216.GA19797@master.mivlgu.local>
 <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org> <20051220191412.GA4578@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Dec 2005, Adrian Bunk wrote:
>
> > Adrian, does it work if you change the "module_init()" in 
> > sound/sound_core.c into a "fs_initcall()"?
> 
> No, this didn't work.
> 
> What did work was to leave sound/sound_core.c alone

Can you do try the other way again, with sound/core/sound.c fixed too?

A regular driver really _should_ use the regular "module_init()" sequence 
(it is indeed just a compatibility define for "driver_init()").

The "late_init()" stuff is meant for stuff that literally runs after 
everything else is up and running, it might want all drivers functional 
(now, nobody really cares about a sound driver, so in that sense it would 
be ok..)

	Thanks,

		Linus
