Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292850AbSB0Tgd>; Wed, 27 Feb 2002 14:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292913AbSB0TgN>; Wed, 27 Feb 2002 14:36:13 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:48529 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S292912AbSB0Tfr>; Wed, 27 Feb 2002 14:35:47 -0500
Date: Wed, 27 Feb 2002 12:49:31 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org, Daniel Phillips <phillips@bonn-fries.net>
Cc: jmerkey@timpanogas.org
Subject: Re: 3Ware Hard Bus Hang 2.4.18 > 220 MB/S
Message-ID: <20020227124931.A32078@vger.timpanogas.org>
In-Reply-To: <20020227102545.B31524@vger.timpanogas.org> <20020227104825.P12832@lynx.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020227104825.P12832@lynx.adilger.int>; from adilger@clusterfs.com on Wed, Feb 27, 2002 at 10:48:25AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 10:48:25AM -0700, Andreas Dilger wrote:
> On Feb 27, 2002  10:25 -0700, Jeff V. Merkey wrote:
> > Running 4 3Ware 7810 Adapters with the updated 48 bit LBA firmware
> > for the 78110, and attached to 8 Maxtor 160 GB hard disks on each card
> > (32 drives total) striping Raid 0m across 5.6 terabytes of disk, I am
> > seeing about 216-224 MB/S total throughput on writes to local 
> > arrays on 2.4.18.  
> 
> Have you done any kind of variations on this configuration to see when
> or where the maximum throughput happens?  Daniel and I were speculating
> about where the 3ware limits are.  Specs say 100MB/s per adapter (for
> both 6000 and 7000 series), you would probably hit max bandwidth with
> 2 adapters.  The drives themselves are not a limiting factor, unless
> you are down to striping across only 2 drives instead of all 8.  I take
> it you are using the hardware RAID instead of software MD RAID?

Single adapter can push 130 MB/S with 8 drives striped at RAID 0 
(hardware RAID not software).  With 2 adapters with 8 drives, the 
max rate of 216 MB/S is achieved.  Adding additional adapters 
on the same PCI bus hits the wall at 238+- MB/S.  I have not tried 
putting the two other 3Ware's on the 66 Mhz bus, but in theory, this
would result in 350 MB/S total throughput from what I am seeing
with the Gigabit ethernet adapter.

> 
> > The system is also running an Intel Gigabit Ethernet Card at 
> > 116-122 MB/S with full network traffic and writing this traffic to 
> > the 3Ware arrays.  All this hardware is running on a Serverworks 
> > HE chipset with a SuperMicro motherboard and dual 933 Mhz PIII
> > processors.
> 
> Does this board have multiple PCI busses?  Is the GigE card on a
> different bus than the 3ware cards?

The Gigabit adapter is running on the 66 Mhz bus.  When combined with 
SCI I am able to push 238 MB/S through the SCI to the 3Ware adapters
and out to disk.  At present, I have modified the SCI drivers and I am 
DMA'ing directly into Linus buffer cache from the SCI disk data.  

Very very fast.  The 3Ware adapters are barfing when the BH count 
gets too high.  I have no idea why.

Jeff


> 
> Cheers, Andreas
> --
> Andreas Dilger
> http://sourceforge.net/projects/ext2resize/
> http://www-mddsp.enel.ucalgary.ca/People/adilger/
