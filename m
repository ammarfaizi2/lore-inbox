Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265604AbSJSOYk>; Sat, 19 Oct 2002 10:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265607AbSJSOYk>; Sat, 19 Oct 2002 10:24:40 -0400
Received: from gate.perex.cz ([194.212.165.105]:18447 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S265604AbSJSOYj>;
	Sat, 19 Oct 2002 10:24:39 -0400
Date: Sat, 19 Oct 2002 16:30:29 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Jan Dittmer <jan@jandittmer.de>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: Call Trace from snd_emu10k1
In-Reply-To: <200210191346.22181.jan@jandittmer.de>
Message-ID: <Pine.LNX.4.33.0210191629530.1058-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Oct 2002, Jan Dittmer wrote:

> Hello!
> 
> Got a couple of these with 2.5.44, while playing with mplayer with ac3 
> passthrough (on the sb live).
> Let me know if I can provide you with anything else helpful. Perhaps I should 
> add, that the system isn't hanging, halting or anything else. Sound is 
> flawless (at least with mplayer).
> 
> jan
> 
> Complete system info at http://lx.sfhq.hn.org/
> 
> Debug: sleeping function called from illegal context at mm/slab.c:1374
> Call Trace:
>  [<c0118d34>] __might_sleep+0x54/0x60
>  [<c01359ae>] kmalloc+0x4e/0x120
>  [<e0900910>] snd_emu10k1_fx8010_playback_irq+0x0/0x10 [snd-emu10k1]
>  [<e09007bc>] snd_emu10k1_fx8010_register_irq_handler+0x6c/0x110 [snd-emu10k1]

This patch will help you:

--- emufx.c     11 Oct 2002 13:29:36 -0000      1.23
+++ emufx.c     19 Oct 2002 14:29:43 -0000
@@ -413,7 +413,7 @@

        snd_runtime_check(emu, return -EINVAL);
        snd_runtime_check(handler, return -EINVAL);
-       irq = kmalloc(sizeof(*irq), GFP_KERNEL);
+       irq = kmalloc(sizeof(*irq), GFP_ATOMIC);
        if (irq == NULL)
                return -ENOMEM;
        irq->handler = handler;


						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

