Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262404AbSJVKig>; Tue, 22 Oct 2002 06:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262409AbSJVKig>; Tue, 22 Oct 2002 06:38:36 -0400
Received: from gate.perex.cz ([194.212.165.105]:53771 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S262404AbSJVKif>;
	Tue, 22 Oct 2002 06:38:35 -0400
Date: Tue, 22 Oct 2002 12:43:53 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Sam Ravnborg <sam@ravnborg.org>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: sound/core/wrappers.c __GENKSYMS__ usage
In-Reply-To: <20021021211120.A6964@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.33.0210221132400.521-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2002, Sam Ravnborg wrote:

> Hi Jaroslav
> 
> The usage of __GENKSYMS__ in sound/core/wrappers.c looks wrong.
> 
> >From the file:
> #include <linux/version.h>
> #include <linux/config.h>
> #ifdef ALSA_BUILD
> #if defined(CONFIG_MODVERSIONS) && !defined(__GENKSYMS__) && !defined(__DEPEND__)
> #define MODVERSIONS
> #include <linux/modversions.h>
> #include "sndversions.h"
> #endif
> #endif
> 
> So __GENKSYMS__ etc is used to protect against inclusion of modversions.h
> and sndversion.h.
> The latter is not present in my tree (2.5.44).
> __DEPEND__ is no longer used.
> 
> I do not see the purpose of this - please explain.

It's for compatibility with older kernels. We use same sources for 2.2 and 
2.4 kernels. Also notice that "problematic" #if is after ALSA_BUILD and 
it's not defined for Linux kernel (we use this definition internally for 
our build system).

Anyway, I'll move this code outside the kernel tree.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

