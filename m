Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWDSIdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWDSIdq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 04:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWDSIdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 04:33:45 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:14862 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750779AbWDSIdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 04:33:45 -0400
Date: Wed, 19 Apr 2006 10:33:44 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: markus.lidel@shadowconnect.com, linux-kernel@vger.kernel.org,
       Patrick McHardy <kaber@trash.net>, davem@davemloft.net
Subject: Re: [2.6 patch] drivers/message/i2o/iop.c: static inline functions mustn't be exported
Message-ID: <20060419083344.GA25047@stusta.de>
References: <20060418150615.GH11582@stusta.de> <20060418230600.4bccd221.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060418230600.4bccd221.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2006 at 11:06:00PM -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > static inline functions mustn't be exported.
> > 
> 
> Actually, exports of static inlines work OK.  The compiler will emit an
> out-of-line copy to satisfy EXPORT_SYMBOL's reference and the module
> namespace is separate from the compiler&linker's namespace.
> 
> Of course, things will screw up when we're using the compiler&linker
> namespace (ie: the driver is statically linked).
>...

It even works with statically linked drivers.
It does work unless CONFIG_MODULES=n.

But this doesn't mean it's OK - exporting static code is wrong.

BTW:
It seems Patrick's recently merged patch to let the compiler help us 
find such bugs (a1a8feed1743ec8d2af1dafa7c5321679f0a3e4f) isn't working.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

