Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270822AbTHFUMb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 16:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270861AbTHFUMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 16:12:30 -0400
Received: from paloma17.e0k.nbg-hannover.de ([62.181.130.17]:55807 "HELO
	paloma17.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id S270822AbTHFUMZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 16:12:25 -0400
From: Dieter =?utf-8?q?N=C3=BCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Michel =?utf-8?q?D=C3=A4nzer?= <michel@daenzer.net>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [Dri-devel] [trunk] Regression with latest 2.4.22-rc1 kernel (r200)
Date: Wed, 6 Aug 2003 22:12:06 +0200
User-Agent: KMail/1.5.3
Cc: DRI-Devel <dri-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org
References: <200308060725.56259.Dieter.Nuetzel@hamburg.de> <1060161135.32133.26.camel@thor.holligenstrasse29.lan>
In-Reply-To: <1060161135.32133.26.camel@thor.holligenstrasse29.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308062212.06561.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 6. August 2003 11:12 schrieb Michel Dänzer:
> On Wed, 2003-08-06 at 07:25, Dieter Nützel wrote:
> > The 2.4.22-rc1 radeon.o module is outdate of course.
> > But the DRI CVS radeon.o module wouldn't load any longer.
> >
> > Linux agpgart interface v0.99 (c) Jeff Hartmann
> > agpgart: Maximum main memory to use for agp memory: 941M
> > agpgart: Detected AMD 760MP chipset
> > agpgart: AGP aperture is 64M @ 0xe8000000
> >
> > SunWave1 /opt/Mesa# modprobe radeon
> > /lib/modules/2.4.22-rc1-rl/kernel/drivers/char/drm/radeon.o: unresolved
> > symbol flush_tlb_all
> > /lib/modules/2.4.22-rc1-rl/kernel/drivers/char/drm/radeon.o: insmod
> > /lib/modules/2.4.22-rc1-rl/kernel/drivers/char/drm/radeon.o failed
> > /lib/modules/2.4.22-rc1-rl/kernel/drivers/char/drm/radeon.o: insmod
> > radeon failed
>
> The kernel basically needs to export flush_tlb_all.
>
> However, it's probably not really needed for your hardware (it's only
> needed for AGP bridges which don't provide direct CPU access to the
> aperture), so if somebody knows a more sophisticated way to handle this,
> I'm all ears.

In which sections of "kernel/ksyms.c" do these two lines belong?

#include <asm/pgalloc.h>
EXPORT_SYMBOL(flush_tlb_all);

Works great.

Aug  6 18:01:10 SunWave1 kernel: Linux agpgart interface v0.99 (c) Jeff 
Hartmann
Aug  6 18:01:10 SunWave1 kernel: agpgart: Maximum main memory to use for agp 
memory: 941M
Aug  6 18:01:10 SunWave1 kernel: agpgart: Detected AMD 760MP chipset
Aug  6 18:01:10 SunWave1 kernel: agpgart: AGP aperture is 64M @ 0xe8000000

Aug  6 20:55:50 SunWave1 kernel: [drm] AGP 0.99 aperture @ 0xe8000000 64MB
Aug  6 20:55:50 SunWave1 kernel: [drm] Initialized radeon 1.9.0 20020828 on 
minor 0


Greetings,
	Dieter

