Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbVLUShW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbVLUShW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 13:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbVLUShW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 13:37:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50136 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964796AbVLUShT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 13:37:19 -0500
Date: Wed, 21 Dec 2005 10:32:41 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Takashi Iwai <tiwai@suse.de>
cc: James Courtier-Dutton <James@superbug.co.uk>, Adrian Bunk <bunk@stusta.de>,
       Sergey Vlasov <vsu@altlinux.ru>, Ricardo Cerqueira <v4l@cerqueira.org>,
       mchehab@brturbo.com.br,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
Subject: Re: [Alsa-devel] 2.6.15-rc6: boot failure in saa7134-alsa.c
In-Reply-To: <s5hpsnqzf86.wl%tiwai@suse.de>
Message-ID: <Pine.LNX.4.64.0512211026190.4827@g5.osdl.org>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
 <20051220131810.GB6789@stusta.de> <20051220155216.GA19797@master.mivlgu.local>
 <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org> <20051220191412.GA4578@stusta.de>
 <Pine.LNX.4.64.0512201156250.4827@g5.osdl.org> <43A86B20.1090104@superbug.co.uk>
 <Pine.LNX.4.64.0512201248481.4827@g5.osdl.org> <s5hpsnqzf86.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Dec 2005, Takashi Iwai wrote:
>
> (And, interestingly, fs_initcall() is rarely used in the whole fs/
>  codes!  "grep -r fs_initcall linux/fs" hits only one file.)

Yes. That thing was probably mis-named. It's much more commonly used for a 
"helper subsystem", ie things like pcmcia (that want PCI to be fully 
initialized and probed, but want to run before the actual device drivers 
start probing).

> So, a "safe" solution for the time being appears to be either
> - to look through the whole codes and adjust *_initcall() levels,
> - to force to build saa7134-alsa as a module, or
> - to move saa7134-alsa.c to sound/ directory.

Well, you dropped the easiest: make saa7134 just use "late_initcall()".

It's not "correct", but it's certainly no less correct than just forcing a 
driver to be moved for link order reasons.

		Linus
