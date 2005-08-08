Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbVHHVF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbVHHVF2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 17:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbVHHVF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 17:05:28 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:63759 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932229AbVHHVF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 17:05:28 -0400
Date: Mon, 8 Aug 2005 23:05:24 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: Pekka J Enberg <penberg@cs.Helsinki.FI>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, pmarques@grupopie.com
Subject: Re: [PATCH] kernel: use kcalloc instead kmalloc/memset
Message-ID: <20050808210524.GK4006@stusta.de>
References: <1123219747.20398.1.camel@localhost> <20050804223842.2b3abeee.akpm@osdl.org> <Pine.LNX.4.58.0508050925370.27151@sbz-30.cs.Helsinki.FI> <20050804233634.1406e92a.akpm@osdl.org> <Pine.LNX.4.58.0508050946070.27679@sbz-30.cs.Helsinki.FI> <20050806150940.GT4029@stusta.de> <s5hacjs68mu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hacjs68mu.wl%tiwai@suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 12:11:21PM +0200, Takashi Iwai wrote:
> At Sat, 6 Aug 2005 17:09:40 +0200,
> Adrian Bunk wrote:
> > 
> > 
> > Looking at how few is left from kcalloc, can't we make it a
> > "static inline" function in slab.h?
> > 
> > This would optimize nicely for all of the users where the first or even 
> > the first two parameters are constant at compile-time and shouldn't do 
> > much harm for the other users.
> > 
> > As a side effect, the difference between kcalloc(1, ...) and kzalloc() 
> > would become a coding style question without any effect on the generated 
> > code.
> 
> How about to use __builtin_constant_p() like kmalloc?
> The code readability would be worsen, though...

Where should this make any difference?

If the function is "static inline", gcc can e.g. always determine at 
compile-time that 1 >= 0 can never be false and therefore optimize it 
away.

> Takashi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

