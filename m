Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129519AbRBIPcz>; Fri, 9 Feb 2001 10:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129982AbRBIPcf>; Fri, 9 Feb 2001 10:32:35 -0500
Received: from cmn2.cmn.net ([206.168.145.10]:9052 "EHLO cmn2.cmn.net")
	by vger.kernel.org with ESMTP id <S129519AbRBIPc1>;
	Fri, 9 Feb 2001 10:32:27 -0500
Message-ID: <3A840D82.10507@valinux.com>
Date: Fri, 09 Feb 2001 08:32:18 -0700
From: Jeff Hartmann <jhartmann@valinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.12-20smp i686; en-US; 0.7) Gecko/20010126
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Stodden <stodden@in.tum.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: paging question
In-Reply-To: <87elx81omm.fsf@bitch.localnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Stodden wrote:

> hi.
> 
> i desperately hope this is not too stupid.
> 
> i'm trying to write a driver which depends on giving pci devices
> access to somewhat larger amounts of pysical memory. let's say, a
> megabyte of contiguous ram.

Your unlikely to get 1 MB of contigous ram unless you grab it very early 
in the boot process.  This means your driver needs to be built into the 
kernel, it can't be a module.

> 
> 
> is it possible to resize such an area later on? i mean: is there some
> mechanism available in the kernel to enlarge such a region even if the
> area beyond it is already in use?

No.

> 
> 
> i understand that this is pretty impossible if some entity depends on
> correct physical locations of the pages in question. but couldn't for
> example userland memory be copied elsewhere and its new location
> simply remapped?

If we had reverse page tables we could perhaps do this sort of 
remapping.  Currently there is no way to detrimine which physical page 
maps to which userland page without scanning every processes page 
tables.  There is also the possibility that the memory is used by the 
kernel, in which case your basically out of luck.

-Jeff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
