Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313480AbSDQKLl>; Wed, 17 Apr 2002 06:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313483AbSDQKLk>; Wed, 17 Apr 2002 06:11:40 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:10512 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S313480AbSDQKLj>;
	Wed, 17 Apr 2002 06:11:39 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: David Lang <david.lang@digitalinsight.com>
Date: Wed, 17 Apr 2002 12:10:49 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] 2.5.8 IDE 36
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@redhat.com>, vojtech@suse.cz,
        rgooch@ras.ucalgary.ca, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <29D25120801@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Apr 02 at 2:39, David Lang wrote:
> On Wed, 17 Apr 2002, Martin Dalecki wrote:
> 
> > > Now, the problem of dealing with DMA along with the swapping is
> > > something scary. I beleive the sanest solution that won't please
> > > affected people is to _not_ support DMA on these broken HW ;)
> >
> > No: the sane sollution would be to not support swapping disks between
> > those systems and other systems.
> 
> in this case please send me a system compatable with my tivo so that I can
> hack on it since you are telling me I'm not going to be able to swap disks
> between it and any sane system.
> 
> doing without DMA is very reasonable and not a significant problem (yes it
> slows me down if I am duplicating drives, but if I am mounting the drive
> so that I can go in and vi the startup files the speed difference doesn't
> matter)

I believe that if you'll create patch which will not byteswap data in
place, and which will not slow system down, he'll accept it.

As there are only three places where bswap should be checked
(taskfile_input_data, taskfile_output_data, enabling DMA),
it is trivial - just fork ata_{input,output}_data, and use insw_swapw/
outsw_swapw in new variant. It will work long as driver properly 
diferentiates that taskfile_*_data is for data read to/from disk plates, 
while ata_*_data is for data produced by disk itself (identify & co.),
and without speed difference, as PCI/VLB/ISA/disk/whatever is limiting 
factor for speed of ata_*_data function.
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
