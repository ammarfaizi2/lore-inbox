Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262280AbUKQLmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbUKQLmo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 06:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbUKQLmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 06:42:44 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:52493 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262280AbUKQLmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 06:42:39 -0500
Date: Wed, 17 Nov 2004 12:37:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] DEBUG_BUGVERBOSE for i386 (fwd)
Message-ID: <20041117113755.GL4943@stusta.de>
References: <20041117043228.GH4943@stusta.de> <20041117003032.7fd91c47.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041117003032.7fd91c47.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 12:30:32AM -0800, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > The patch below implements CONFIG_DEBUG_BUGVERBOSE for i386 (more 
> >  exactly, it allows disabling the verbose BUG() reporting).
> > 
> > 
> >  Signed-off-by: Adrian Bunk <bunk@fs.tum.de>
> > 
> >  --- linux-2.6.9-rc1-mm1-full/lib/Kconfig.debug.old	2004-08-29 21:22:20.000000000 +0200
> >  +++ linux-2.6.9-rc1-mm1-full/lib/Kconfig.debug	2004-08-29 21:28:29.000000000 +0200
> >  @@ -61,7 +61,7 @@
> >   
> >   config DEBUG_BUGVERBOSE
> >   	bool "Verbose BUG() reporting (adds 70K)"
> >  -	depends on DEBUG_KERNEL && (ARM || ARM26 || M68K || SPARC32 || SPARC64)
> >  +	depends on DEBUG_KERNEL && (ARM || ARM26 || M68K || SPARC32 || SPARC64 || (X86 && !X86_64))
> 
> I think I'll stick an `&& EMBEDDED' in there to make it harder to disable
> BUG traces.  We really don't want to be screwing ourselves over by removing
> useful diagnostic info.

I simply did it as on other architectures.

Do you want the following?

config DEBUG_BUGVERBOSE
        bool "Verbose BUG() reporting (adds 70K)" if EMBEDDED
        depends on (DEBUG_KERNEL || EMBEDDED=n) && (ARM || ...)
	default y


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

