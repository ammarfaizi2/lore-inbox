Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313747AbSDZJRp>; Fri, 26 Apr 2002 05:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313751AbSDZJRo>; Fri, 26 Apr 2002 05:17:44 -0400
Received: from gate.perex.cz ([194.212.165.105]:54536 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S313747AbSDZJRn>;
	Fri, 26 Apr 2002 05:17:43 -0400
Date: Fri, 26 Apr 2002 11:17:23 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Jurriaan on Alpha <thunder7@xs4all.nl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: compiling cmipci in 2.5.10 on Alpha doesn't work
In-Reply-To: <20020426130514.A20345@jurassic.park.msu.ru>
Message-ID: <Pine.LNX.4.33.0204261113230.487-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Apr 2002, Ivan Kokshaysky wrote:

> On Fri, Apr 26, 2002 at 09:44:16AM +0200, Jurriaan on Alpha wrote:
> > -#if defined(__i386__) || defined(__ppc__)
> > +#if defined(__i386__) || defined(__ppc__) || defined(__alpha__)
> >  /*
> >   * Here a dirty hack for 2.4 kernels.. See kernel/memory.c.
> >   */
> 
> No, alpha doesn't need any kind of "dirty hacks". :-)
> We only need to get <linux/pci.h> included properly.

The real fix is to add '#include <linux/pci.h>' line to all necessary 
source files (sound/pci/cmipci.c in this example). Not all source files 
need pci.h for compilation.

						Jaroslav

> --- 2.5.10/include/sound/driver.h	Mon Mar 18 23:37:12 2002
> +++ linux/include/sound/driver.h	Tue Mar 26 23:47:32 2002
> @@ -50,12 +50,12 @@
>   */
>  
>  #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 4, 0)
> +#include <linux/pci.h>
>  #if defined(__i386__) || defined(__ppc__)
>  /*
>   * Here a dirty hack for 2.4 kernels.. See kernel/memory.c.
>   */
>  #define HACK_PCI_ALLOC_CONSISTENT
> -#include <linux/pci.h>
>  void *snd_pci_hack_alloc_consistent(struct pci_dev *hwdev, size_t size,
>  				    dma_addr_t *dma_handle);
>  #undef pci_alloc_consistent

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

