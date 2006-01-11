Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWAKWWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWAKWWF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 17:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbWAKWWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 17:22:05 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:35335 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932288AbWAKWWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 17:22:04 -0500
Date: Wed, 11 Jan 2006 23:22:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dominik Karall <dominik.karall@gmx.net>, mchehab@brturbo.com.br
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Giacomo A. Catenazzi" <cate@debian.org>,
       "David S. Miller" <davem@davemloft.net>, video4linux-list@redhat.com
Subject: 2.6.15-mm3, current -git: drivers/media/video/ compile errors
Message-ID: <20060111222202.GG29663@stusta.de>
References: <20060111042135.24faf878.akpm@osdl.org> <200601111721.23598.dominik.karall@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601111721.23598.dominik.karall@gmx.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 05:21:23PM +0100, Dominik Karall wrote:
> 
> hi!
> it doesn't compile here.
> 
>   CC      drivers/media/video/tveeprom.o
>   LD      drivers/media/video/built-in.o
> drivers/media/video/tuner.o:(.bss+0x0): multiple definition of `debug'
> drivers/media/video/msp3400.o:(.bss+0xc): first defined here
> make[3]: *** [drivers/media/video/built-in.o] Fehler 1
>...

I'm getting even one more error:

<--  snip  -->

...
drivers/media/video/tuner.o:(.bss+0x0): multiple definition of `debug'
drivers/media/video/msp3400.o:(.bss+0xc): first defined here
drivers/media/video/cx25840/built-in.o:(.bss+0x0): multiple definition of `debug'
drivers/media/video/msp3400.o:(.bss+0xc): first defined here
make[3]: *** [drivers/media/video/built-in.o] Error 1

<--  snip  -->

There's sometime a need for variables being global being visible in 
all objects of a module.

That's OK.

But they should never have generic names like "debug" or "once" (the 
latter and some similar ones don't seem to cause compile errors since 
they are currently used only once, but they are equally wrong.

> greets,
> dominik

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

