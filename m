Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbVKSCpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbVKSCpp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 21:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbVKSCpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 21:45:45 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:17353
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751339AbVKSCpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 21:45:44 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Fri, 18 Nov 2005 20:43:33 -0600
User-Agent: KMail/1.8
Cc: Adrian Bunk <bunk@stusta.de>, Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>,
       linux-kernel@vger.kernel.org
References: <1132020468.27215.25.camel@mindpipe> <200511181933.27320.rob@landley.net> <1132365780.6874.53.camel@mindpipe>
In-Reply-To: <1132365780.6874.53.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511182043.34655.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 November 2005 20:02, Lee Revell wrote:
> > Speaking of which: I've been playing with qemu recently, and the sound
> > card it emulates is a sound blaster 16.  Which only seems to have an OSS
> > driver, no ALSA...
> >
> > This is known?  If so I might take a whack at porting this if I get
> > really bored this weekend...
>
> There already is an ALSA driver, check out sound/isa/sb/sb16.c:

Ok, so where is the config option?

find . | xargs grep CONFIG_SND_SB16
./arch/i386/defconfig:# CONFIG_SND_SB16 is not set
./arch/ppc/configs/common_defconfig:# CONFIG_SND_SB16 is not set
./arch/ppc/configs/power3_defconfig:# CONFIG_SND_SB16 is not set
./include/sound/sb.h:   void *csp; /* used only when CONFIG_SND_SB16_CSP is 
set */
./sound/isa/sb/Makefile:obj-$(CONFIG_SND_SB16) += snd-sb16.o snd-sb16-dsp.o 
snd-sb-common.o
./sound/isa/sb/Makefile:ifeq ($(CONFIG_SND_SB16_CSP),y)
./sound/isa/sb/Makefile:  obj-$(CONFIG_SND_SB16) += snd-sb16-csp.o
./sound/isa/sb/sb16.c:#ifdef CONFIG_SND_SB16_CSP
./sound/isa/sb/sb16.c:#ifdef CONFIG_SND_SB16_CSP
./sound/isa/sb/sb16.c:#ifdef CONFIG_SND_SB16_CSP
./sound/isa/sb/sb16.c:#ifdef CONFIG_SND_SB16_CSP
./sound/isa/sb/sb16_main.c:#ifdef CONFIG_SND_SB16_CSP

It's in defconfig, source, and the makefile, but nowhere in Kconfig...

Rob
