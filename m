Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261868AbSJ2OQH>; Tue, 29 Oct 2002 09:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261875AbSJ2OQH>; Tue, 29 Oct 2002 09:16:07 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:14537 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261868AbSJ2OQG>;
	Tue, 29 Oct 2002 09:16:06 -0500
Date: Tue, 29 Oct 2002 09:22:27 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: christophe.varoqui@free.fr
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC]partitions through device-mapper
In-Reply-To: <1035898775.3dbe8f97d1a3f@imp.free.fr>
Message-ID: <Pine.GSO.4.21.0210290916360.9171-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 29 Oct 2002 christophe.varoqui@free.fr wrote:

> Hello, 
>  
> now that the device mapper is merged into mainline, I would like to open a 
> discussion on the possible in-kernel partition handling clean-up. 
>  
> In-kernel partition handling covers : 
> o parsing of the on-disk partition tables 
> o partition block devices creation / structs 
>  
> Along with initramfs will come the possibility to rip off the partition tables 
> parsing from the kernel : a userspace parser like partx (part of util-linux 
> toolset) can teach the kernel the partition layout. 
>  
> As driverfs provides elegantly block device add/remove events to hotplug, calls 
> to partx can be wrapped into the block.agent 
>  
> The device-mapper merging could enable the ripping of all kernel partition 
> understanding by creating linear device-maps over partitions. 
>  
> As a proof of concept, I've mutated partx to create those mappings. This tool 
> is available for testing and commenting at : 
> http://dsit.free.fr/dmpartx.tar.bz2 
>  
> This tool cannot damage your data : BLKPG_DEL_PARTITION and  
> BLKPG_ADD_PARTITION ioctls are removed from the source. 
>  
> I would like to receive feedback over the following points : 
>  
> * Is this proposal completely out of the point ? Have I overlooked some 
> important implementation details ? 

a) devmapper is merged, but it sure as hell is not mandatory

b) relying on the hotplug working right means living dangerously.  Right
now that code is brittle in the best case.

c) all existing races in overlapping attach/detach (and $DEITY witness,
there's a plenty) immediately become much wider [OK, that's part of
(b), actully]

IOW, right now the thing is nowhere near being ready for such use.

