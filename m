Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262528AbSLJQPj>; Tue, 10 Dec 2002 11:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262469AbSLJQPj>; Tue, 10 Dec 2002 11:15:39 -0500
Received: from ns.suse.de ([213.95.15.193]:19205 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262446AbSLJQPh>;
	Tue, 10 Dec 2002 11:15:37 -0500
Date: Tue, 10 Dec 2002 17:23:20 +0100
From: Dave Jones <davej@suse.de>
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG]: agpgart for i810 chipsets broken in 2.5.51
Message-ID: <20021210172320.A4586@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Antonino Daplas <adaplas@pol.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1039522886.1041.17.camel@localhost.localdomain> <20021210131143.GA26361@suse.de> <1039538881.2025.2.camel@localhost.localdomain> <20021210140301.GC26361@suse.de> <1039547210.1071.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1039547210.1071.26.camel@localhost.localdomain>; from adaplas@pol.net on Wed, Dec 11, 2002 at 12:08:22AM +0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2002 at 12:08:22AM +0500, Antonino Daplas wrote:
 > Tried it with framebuffer console off, same results. Moved agp before vt
 > in char/Makefile, same. Even manually calling agp_init() doesn't work
 > because what's really needed is agp_intel_init(). 
 > 
 > Anyway, I guess I'll stick to what I'm doing right now, periodically do
 > an inter_module_get("drm_agp") until it becomes available.

That's really quite icky. Even putting an..

#ifdef CONFIG_FRAMEBUFFER_I810
    dev = pci_find_blah..
    agp_intel_init(dev);
#endif

before console_init() call in init/main.c seems cleaner than that imo,
(and this is still quite gross).

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
