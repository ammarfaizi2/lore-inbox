Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263977AbSLJQfT>; Tue, 10 Dec 2002 11:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264638AbSLJQfT>; Tue, 10 Dec 2002 11:35:19 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:52231 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S263977AbSLJQfR>; Tue, 10 Dec 2002 11:35:17 -0500
Subject: Re: [BUG]: agpgart for i810 chipsets broken in 2.5.51
From: Antonino Daplas <adaplas@pol.net>
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021210172320.A4586@suse.de>
References: <1039522886.1041.17.camel@localhost.localdomain>
	<20021210131143.GA26361@suse.de>
	<1039538881.2025.2.camel@localhost.localdomain>
	<20021210140301.GC26361@suse.de>
	<1039547210.1071.26.camel@localhost.localdomain> 
	<20021210172320.A4586@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1039548861.1086.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Dec 2002 00:36:47 +0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-10 at 21:23, Dave Jones wrote:
> On Wed, Dec 11, 2002 at 12:08:22AM +0500, Antonino Daplas wrote:
>  > Tried it with framebuffer console off, same results. Moved agp before vt
>  > in char/Makefile, same. Even manually calling agp_init() doesn't work
>  > because what's really needed is agp_intel_init(). 
>  > 
>  > Anyway, I guess I'll stick to what I'm doing right now, periodically do
>  > an inter_module_get("drm_agp") until it becomes available.
> 
> That's really quite icky. Even putting an..
> 
> #ifdef CONFIG_FRAMEBUFFER_I810
>     dev = pci_find_blah..
>     agp_intel_init(dev);
> #endif
> 
> before console_init() call in init/main.c seems cleaner than that imo,
> (and this is still quite gross).
> 
That's fine by me.  It's basically what I'm doing in 2.4, except that I
call it directly from the driver.  I'm just not in the habit of touching
other people's code.  

agp_intel_init() will be called twice though, first by i810fb, then the
usual inits, so a flag has to be set once the function is called.

If it's okay with you, I'll do it that way (and save me some 100 lines
of code in the process :-), and submit a patch.

Tony 


