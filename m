Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317406AbSFMCVZ>; Wed, 12 Jun 2002 22:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317408AbSFMCVY>; Wed, 12 Jun 2002 22:21:24 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:2110 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317406AbSFMCVX>; Wed, 12 Jun 2002 22:21:23 -0400
Date: Thu, 13 Jun 2002 03:21:22 +0100
From: Anton Altaparmakov <aia21@mole.bio.cam.ac.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support
In-Reply-To: <3D07FFC6.6060004@zytor.com>
Message-ID: <Pine.SGI.4.33.0206130315110.4638397-100000@mole.bio.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2002, H. Peter Anvin wrote:
> Anton Altaparmakov wrote:
> >
> > allocate_compression_buffers() currently allocates all buffers up
> > smp_num_cpus which is fine without hotswap cpus. Once hotswap cpus path
> > goes in, then the allocation will be (pseudo code):
> >
> > 	for (i = 0; i < NR_CPUS; i++) {
> > 		if (cpu_possible(i)) {
> > 			ntfs_compression_buffer[i] = vmalloc();
> > 			// TODO handle errors
> > 		}
> > 	}
> >
> > That means in words that we allocate buffers only once and for all
> > existing cpu SOCKETS, i.e. including all potentially hotpluggable cpus
> > which are currently offline. - If someone invents hotpluggable cpu sockets
> > at some point then they should be burnt at the stake! (-;
>
> Note that with my code, you don't allocate any memory until you have
> actually seen a particular CPU being *used.*  All very simple...

I realise that and I am just saying that doing that is pointless as it
only introduces overhead at no gain at all. If you  use one cpu you are
going to use all of them. Snd if you have one compressed file, you are
going to have lots of them. Frankly, I don't care about hotplug cpus. If
someone has a hotplug capable motherboard which costs thousands (tens of
thousands?) of dollars without even starting on the cpus they are not
going to care if the kernel is wasting a few megabytes of ram here or
there... And if they do then they should buy more RAM obviously they can
afford it... What I am worried about is wasting ram on low end systems and
my approach is just as effective as yours except it incurs less overhead,
be it only by a few cycles...

Anton

ps. I am away to catch a plane in a few minutes so won't be replying for a
while...

