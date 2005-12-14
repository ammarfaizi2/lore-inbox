Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965104AbVLNXnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965104AbVLNXnO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 18:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965106AbVLNXnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 18:43:13 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1296 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965107AbVLNXnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 18:43:11 -0500
Date: Thu, 15 Dec 2005 00:43:10 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [2.6 patch] offer CC_OPTIMIZE_FOR_SIZE only if EXPERIMENTAL
Message-ID: <20051214234310.GK23349@stusta.de>
References: <20051214191006.GC23349@stusta.de> <20051214140531.7614152d.akpm@osdl.org> <20051214221304.GE23349@stusta.de> <Pine.LNX.4.64.0512141429030.3292@g5.osdl.org> <20051214224406.GI23349@stusta.de> <Pine.LNX.4.64.0512141528140.3292@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512141528140.3292@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 03:32:28PM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 14 Dec 2005, Adrian Bunk wrote:
> > 
> > My patch has the advantage that it doesn't allow the broken 
> > CC_OPTIMIZE_FOR_SIZE=y setting on ARM if !EXPERIMENTAL.
> 
> That isn't how it was before either. 
> 
> Before, it _asked_ you if EMBEDDED was set, and "y" was just the default 
> (but you could select "n" if you wanted to). I don't think it's 
> necessarily wrong to allow a -O2 ARM or H8300 kernel, although apparently 
> there are compilers that are broken that way too..
> 
> So my patch should give the old behaviour for the EMBEDDED platforms, and 
> _allow_ it for non-embedded unless SPARC64 is set, or EXPERIMENTAL isn't 
> set.
>...

No, your patch allows ARM users to set CC_OPTIMIZE_FOR_SIZE=n no matter 
whether they have any options set.

Before, ARM users had to set EMBEDDED=y, and with my patch they would 
have to set EXPERIMENTAL=y for getting this broken configuration.


config CC_OPTIMIZE_FOR_SIZE
	bool "Optimize for size (Look out for broken compilers!)"
	default y
	depends on ARM || H8300 || EXPERIMENTAL


does allow CC_OPTIMIZE_FOR_SIZE=n if ARM=y and EXPERIMENTAL=n
(which was reported as being broken).


config CC_OPTIMIZE_FOR_SIZE
	bool "Optimize for size (EXPERIMENTAL)" if EXPERIMENTAL
	default y if ARM || H8300

does not allow CC_OPTIMIZE_FOR_SIZE=n if ARM=y and EXPERIMENTAL=n.

> 		Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

