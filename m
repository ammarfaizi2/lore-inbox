Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030372AbWFJIWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030372AbWFJIWZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 04:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030377AbWFJIWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 04:22:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:14218 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030372AbWFJIWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 04:22:25 -0400
X-Flags: 0001
Date: Sat, 10 Jun 2006 10:22:23 +0200
Message-ID: <20060610082223.321730@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       alsa-devel@lists.sourceforge.net
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Subject: Re: Re: RFC: dma_mmap_coherent() for powerpc/ppc architecture and
 ALSA?
To: Lee Revell <rlrevell@joe-job.com>, benh@kernel.crashing.org
X-Authenticated: #6097454
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -------- Original-Nachricht --------
> Datum: Fri, 09 Jun 2006 20:46:32 -0400
> Von: Lee Revell <rlrevell@joe-job.com>
> An: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Betreff: Re: RFC: dma_mmap_coherent() for powerpc/ppc architecture and 
> ALSA?
> 
> On Sat, 2006-06-10 at 10:34 +1000, Benjamin Herrenschmidt wrote:
> > > This leads me to the question, if there are any plans to include the 
> > > dma_mmap_coherent() function (for powerpc/ppc and/or any other
> > > platform) in one of the next kernel versions and if an adapation of
> > > the ALSA drivers is planned. Or is there a simple way (hack) to fix
> > > this problem?
> > 
> > You are welcome to do a patch implementing this :)
> 
> Please cc: alsa-devel when you do so.

:)

Well, implementing the dma_mmap_coherent() function isn't the problem, because it is already implemented for the ARM architecture. But as far as I understand this would require a rewrite of all the ALSA drivers (or at least a rewrite of the ALSA's DMA helper functions).

Original mail included for alsa-devel mailing list:

> I'm trying to adapt Linux for the AmigaOne, which is a G3/G4 PPC desktop 
> system with a non cache coherent northbridge (MAI ArticiaS), a VIA82C686B 
> southbridge and the U-boot firmware. Due to the cache coherency problem I 
> compiled in the CONFIG_NOT_COHERENT_CACHE option
> (arch/ppc/kernel/dma-mapping.c) in the AmigaOne Linux kernel.

> While that fixes the DMA data corruption problem, it causes a kernel oops 
> or a complete system lookup after starting sound playback. With kernel
> versions =<2.6.14 the oops messages refered to a BUG() entry in
> mm/rmap.c. Therefore I tried out a newer kernel (2.6.16.15), where the
> oops refers to the ALSA function snd_pcm_mmap_data_nopage() implemented
> in pcm_native.c.

> Well, after searching a while in some old linux kernel threads, I found
> this thread here:
> http://www.thisishull.net/showthread.php?t=22080&page=3&pp=10

> Based on the information in this thread, I came to the conclusion that
> ALSA simply won't work on non cache coherent architectures (except ARM),
> because the generic DMA API was never expanded to support the
> functionality required by ALSA (namely mapping dma pages into user space > with dma_mmap_coherent()).

> This leads me to the question, if there are any plans to include the
> dma_mmap_coherent() function (for powerpc/ppc and/or any other platform)
> in one of the next kernel versions and if an adapation of the ALSA
> drivers is planned. Or is there a simple way (hack) to fix this problem?

Gerhard

-- 


Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
