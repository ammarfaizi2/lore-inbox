Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316106AbSHBPxq>; Fri, 2 Aug 2002 11:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316113AbSHBPxi>; Fri, 2 Aug 2002 11:53:38 -0400
Received: from mta06bw.bigpond.com ([139.134.6.96]:61146 "EHLO
	mta06bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S316106AbSHBPx1>; Fri, 2 Aug 2002 11:53:27 -0400
Message-ID: <3D4AACDA.2010902@snapgear.com>
Date: Sat, 03 Aug 2002 02:01:30 +1000
From: gerg <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.0.0) Gecko/20020530
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: linux-2.5.30uc0 MMU-less patches
References: <3D4A27FE.8030801@snapgear.com> <3007.1028299196@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

David Woodhouse wrote:
> gerg@snapgear.com said:
> 
>> I have coded a generic MTD map driver to replace the old crufty
>>blkmem driver. The blkmem driver will be going away in future patches.

Did you have a look at uclinux.c, that is the one I was referring
to here?


> --- linux-2.5.30/drivers/mtd/maps/snapgear-uc.c	Thu Jan  1 10:00:00 1970
> +++ linux-2.5.30uc0/drivers/mtd/maps/snapgear-uc.c	Mon Jul 15 21:29:25 2002
> +#ifdef CONFIG_NFTL
> +#include <linux/mtd/nftl.h>
> +#endif
> 
> You shouldn't need that.

There is one board setup supported by this that uses DiskOnChip
(the CONFIG_SH_SECUREEDGE5410 define). But your probably right,
it wouldn't need nftl.h.


> +int flash_eraseconfig(void)
> +{
> 
> This will cause an oops if it gets woken by a signal -- you leave and the 
> the 'struct erase_info' on your stack frame, which you passed to the 
> asynchronous erase call, goes bye bye.

OK, I'll get that fixed.


> +		ROOT_DEV = MKDEV(NFTL_MAJOR, 1);
> 
> Oh, I see -- if we fail to find a file system we recognise on the NOR 
> flash, try booting from DiskOnChip. Does this really live here?

Well, it actually support for a completely different board - it
doesn't have NOR flash at all.

This code supports a wide variety of boards, with mixtures of
NOR flash and/or DiskOnChip.


> --- linux-2.5.30/drivers/mtd/mtdblock.c	Fri Aug  2 15:15:41 2002
> +++ linux-2.5.30uc0/drivers/mtd/mtdblock.c	Fri Aug  2 16:00:13 2002
> -		if (req->flags & REQ_CMD)
> +		if (! (req->flags & REQ_CMD))
> 
> Yes.
> 
> +#ifdef MAGIC_ROM_PTR
> +static int
> +mtdblock_romptr(kdev_t dev, struct vm_area_struct * vma)
> 
> No, although the fix I'm happy with is going to take a while to get 
> implemented so maybe in the short term. This is likely to get rejected on 
> other grounds anyway; perhaps separate it and don't submit it for inclusion 
> just now?

Sounds good to me. The most important is the uclinux.c support.
Since that means I can get rid of the blkmem driver all together
from the uClinux patches.

Thanks
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.snapgear.com

