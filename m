Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313479AbSDQKWT>; Wed, 17 Apr 2002 06:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313483AbSDQKWS>; Wed, 17 Apr 2002 06:22:18 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:40085 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S313479AbSDQKWR>; Wed, 17 Apr 2002 06:22:17 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@redhat.com>, vojtech@suse.cz,
        rgooch@ras.ucalgary.ca, linux-kernel@vger.kernel.org
Date: Wed, 17 Apr 2002 03:20:23 -0700 (PDT)
Subject: Re: [PATCH] 2.5.8 IDE 36
In-Reply-To: <29D25120801@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.44.0204170311350.389-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My understanding of the old code was that it worked in PIO mode, but was
unsafe to use with DMA. I don't think anyone asking to have it upgraded to
work in DMA mode (not that anyone would object to that if it happened),
just don't remove the working PIO mode byteswap capability without some
thought as to how to achieve the same result.

also if another way becomes available to do the same job (i.e. loopback
with partition support) that will also solve my problem and I won't care
if direct byteswap support is removed.

what I do object to is the statement that "the sane solution would be to
not support swapping disks between these systems and other systems"

declaring that the capability that is currently in place and in use by
people should be eliminated with no replacement is wrong.

David Lang

On Wed, 17 Apr 2002, Petr Vandrovec wrote:

> On 17 Apr 02 at 2:39, David Lang wrote:
> > On Wed, 17 Apr 2002, Martin Dalecki wrote:
> >
> > > > Now, the problem of dealing with DMA along with the swapping is
> > > > something scary. I beleive the sanest solution that won't please
> > > > affected people is to _not_ support DMA on these broken HW ;)
> > >
> > > No: the sane sollution would be to not support swapping disks between
> > > those systems and other systems.
> >
> > in this case please send me a system compatable with my tivo so that I can
> > hack on it since you are telling me I'm not going to be able to swap disks
> > between it and any sane system.
> >
> > doing without DMA is very reasonable and not a significant problem (yes it
> > slows me down if I am duplicating drives, but if I am mounting the drive
> > so that I can go in and vi the startup files the speed difference doesn't
> > matter)
>
> I believe that if you'll create patch which will not byteswap data in
> place, and which will not slow system down, he'll accept it.
>
> As there are only three places where bswap should be checked
> (taskfile_input_data, taskfile_output_data, enabling DMA),
> it is trivial - just fork ata_{input,output}_data, and use insw_swapw/
> outsw_swapw in new variant. It will work long as driver properly
> diferentiates that taskfile_*_data is for data read to/from disk plates,
> while ata_*_data is for data produced by disk itself (identify & co.),
> and without speed difference, as PCI/VLB/ISA/disk/whatever is limiting
> factor for speed of ata_*_data function.
>                                                 Petr Vandrovec
>                                                 vandrove@vc.cvut.cz
>
>
