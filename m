Return-Path: <linux-kernel-owner+willy=40w.ods.org-S320168AbUKBFGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S320168AbUKBFGF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 00:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S324196AbUKAWg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 17:36:59 -0500
Received: from witte.sonytel.be ([80.88.33.193]:12260 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S312571AbUKAUVv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 15:21:51 -0500
Date: Mon, 1 Nov 2004 21:21:43 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 504] m68k: smp_lock.h: Avoid recursive include
In-Reply-To: <Pine.LNX.4.58.0410311612140.17101@ppc970.osdl.org>
Message-ID: <Pine.GSO.4.61.0411012117330.8299@waterleaf.sonytel.be>
References: <200410311003.i9VA3d14009637@anakin.of.borg>
 <Pine.LNX.4.58.0410311612140.17101@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Oct 2004, Linus Torvalds wrote:
> Not only is that include not recursive, but it immediately breaks any SMP 

It's not immediately recursive, but <linux/sched.h> includes about everything
and the kitchen sink, causing fatal problems on m68k since 2.6.9*...

> compile because that header file _needs_ the definition of "task_struct".

Sorry, forgot about SMP.

So we have to move the definition of "task_struct" to <linux/task_struct.h>
first, to avoid include hell. Cfr. what Roman Zippel is working on.

> I applied it without realizing it, but I'll undo it and I hope you fix 
> your broken tree so that I don't ever have to see this broken patch 
> again..

Don't worry, it has been moved to my POSTPONED queue :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
