Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756797AbWKVUEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756797AbWKVUEg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 15:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756799AbWKVUEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 15:04:36 -0500
Received: from smtp.osdl.org ([65.172.181.25]:62122 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1756797AbWKVUEf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 15:04:35 -0500
Date: Wed, 22 Nov 2006 12:04:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: wbrana@gmail.com
Cc: linux-kernel@vger.kernel.org, "Jaroslav Kysela" <perex@suse.cz>,
       "Takashi Iwai" <tiwai@suse.de>
Subject: Re: [PATCH] snd-hda-intel: fix insufficient memory
Message-Id: <20061122120422.7f1f96fe.akpm@osdl.org>
In-Reply-To: <a769871e0611220919q62ccdb5k5548062300e35376@mail.gmail.com>
References: <a769871e0611211233n20eb9d74j661cd73e9315fade@mail.gmail.com>
	<20061121224613.548207f9.akpm@osdl.org>
	<a769871e0611220919q62ccdb5k5548062300e35376@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2006 18:19:49 +0100
wbrana@gmail.com wrote:

> Module uses shorter buffer if memory isn't sufficient.
> It doesn't change size of allocated memory automatically.
> User has to change it with command like this:
> echo 256 > /proc/asound/card0/pcm0p/sub0/prealloc
> I can change it, but many regular users don't know it.
> This card is used in new PCs, which have at least 256 MB RAM.
> 256 kB shouldn't be too much. Whole block isn't used if it isn't needed.

That didn't answer my question.

> On 11/22/06, Andrew Morton <akpm@osdl.org> wrote:
> > On Tue, 21 Nov 2006 21:33:29 +0100
> > wbrana@gmail.com wrote:
> >
> > > Module allocates insufficient memory for multichannel and high quality
> > > audio (96 kHz, 24 bit)
> > > Patch for 2.6.19-* changes default/maximal size from 64/128 to 256/4096 kB.
> > >
> > > --- sound/pci/hda/hda_intel.c.orig      2006-09-29 13:40:36.000000000 +0200
> > > +++ sound/pci/hda/hda_intel.c   2006-11-05 16:45:13.000000000 +0100
> > > @@ -1270,5 +1270,5 @@
> > >         snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
> > >                                               snd_dma_pci_data(chip->pci),
> > > -                                             1024 * 64, 1024 * 128);
> > > +                                             1024 * 256, 1024 * 4096);
> > >         chip->pcm[pcm_dev] = pcm;
> > >         if (chip->pcm_devs < pcm_dev + 1)
> >
> > This was recently increased, but not by such a large amount:
> >
> >         snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
> >                                               snd_dma_pci_data(chip->pci),
> >                                               1024 * 64, 1024 * 1024);
> >
> > is that sufficient?
> >

Are the new settings of 64kb and 1MB sufficient?  If not, by how much must
they be increased, and why?

