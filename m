Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264861AbTGCCkL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 22:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264929AbTGCCkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 22:40:10 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:57072 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264861AbTGCCkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 22:40:03 -0400
Date: Thu, 3 Jul 2003 04:53:43 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Adam Belay <ambx1@neo.rr.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, perex@suse.cz,
       alsa-devel@alsa-project.org
Subject: Re: 2.5.73: ALSA ISA pnp_init_resource_table compile errors
Message-ID: <20030703025343.GC282@fs.tum.de>
References: <Pine.LNX.4.44.0306221150440.17823-100000@old-penguin.transmeta.com> <20030622234447.GB3710@fs.tum.de> <20030623000808.GA14945@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030623000808.GA14945@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 23, 2003 at 12:08:08AM +0000, Adam Belay wrote:
> On Mon, Jun 23, 2003 at 01:44:47AM +0200, Adrian Bunk wrote:
> > On Sun, Jun 22, 2003 at 11:53:14AM -0700, Linus Torvalds wrote:
> > >...
> > > Summary of changes from v2.5.72 to v2.5.73
> > > ============================================
> > >...
> > > Adam Belay:
> > >   o [PNP] Resource Management Cleanups and Updates
> > >...
> > 
> > This patch removed pnp_init_resource_table, but several drivers under 
> > sound/isa/ still use it, resulting in compile errors like the following:
> > 
> > <--  snip  -->
> > 
> > ...
> >   CC      sound/isa/ad1816a/ad1816a.o
> > sound/isa/ad1816a/ad1816a.c: In function `snd_card_ad1816a_pnp':
> > sound/isa/ad1816a/ad1816a.c:143: warning: implicit declaration of 
> > function `pnp_init_resource_table'
> > ...
> >   LD      .tmp_vmlinux1
> > sound/built-in.o(.text+0x349c7): In function `snd_card_ad1816a_pnp':
> > : undefined reference to `pnp_init_resource_table'
> > sound/built-in.o(.text+0x34ad3): In function `snd_card_ad1816a_pnp':
> > : undefined reference to `pnp_init_resource_table'
> > make: *** [.tmp_vmlinux1] Error 1
> > 
> > <--  snip  -->
> > 
> > 
> > cu
> > Adrian
> > 
> 
> The patch below will correct this.

I don't know whether it's related, but with 2.5.73 + your patch and 
2.5.74 my soundcard stopped working (driver compiled statically into 
the kernel, no options given).

>From dmesg:

2.5.74:

<--  snip  -->

Advanced Linux Sound Architecture DriverVersion 0.9.4 (Mon Jun 09 12:01:18 2003 UTC).
specify port
pnp: the driver 'ad1816a' has been registered
pnp: match found with the PnP device '01:01.00'and the driver 'ad1816a'
pnp: match found with the PnP device '01:01.01'and the driver 'ad1816a'
ad1816a: AUDIO the requested resources areinvalid, using auto config
pnp: Unable to assign resources to device 01:01.00
ALSA device list:
  No soundcards found.

<--  snip  -->


2.5.72 (soundcard works):


<--  snip  -->

Advanced Linux Sound Architecture DriverVersion 0.9.4 (Mon Jun 09 12:01:18 2003 UTC).
specify port
pnp: the driver 'ad1816a' has been registered
pnp: match found with the PnP device '01:01.00'and the driver 'ad1816a'Jul  3 04:37:42 r063144 kernel: pnp: match found with the PnP device '01:01.01'and the driver 'ad1816a'
pnp: res: the device '01:01.00' has beenactivated.
pnp: res: the device '01:01.01' has beenactivated.
ALSA device list:
  #0: ADI SoundPort AD1816A soundcard, SS at0x530, irq 5, dma 1&3

<--  snip  -->


> Thanks,
> Adam
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

