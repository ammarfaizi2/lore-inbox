Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268218AbUJDPij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268218AbUJDPij (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 11:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268214AbUJDPij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 11:38:39 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:17932 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S268218AbUJDPfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 11:35:52 -0400
Date: Mon, 4 Oct 2004 17:35:16 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc3-mm2: error: `u64' used prior to declaration
Message-ID: <20041004153515.GB12736@stusta.de>
References: <416160FE.2090107@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416160FE.2090107@eyal.emu.id.au>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2004 at 12:41:02AM +1000, Eyal Lebedinsky wrote:

>   CC [M]  drivers/media/dvb/bt8xx/dvb-bt8xx.o
> In file included from drivers/media/dvb/bt8xx/dvb-bt8xx.c:22:
> include/asm/bitops.h:543: error: parse error before "rol64"
>...

The first error is the most interesting one.

> include/asm/types.h: At top level:
> include/asm/types.h:50: error: `u64' used prior to declaration
> make[4]: *** [drivers/media/dvb/bt8xx/dvb-bt8xx.o] Error 1
>...
> 
> I just added
> 	#include <asm/types.h>
> to the top of
> 	include/asm/bitops.h
> and the build finished
>...

The real problem seem to be files including asm/bitops.h instead of 
linux/bitops.h .

@Andrew:
Would you accept a patch that changes all #include <asm/bitops.h> to
#include <linux/bitops.h> ?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

