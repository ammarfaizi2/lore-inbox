Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbUCROc2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 09:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262669AbUCROc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 09:32:28 -0500
Received: from fep04-mail.bloor.is.net.cable.rogers.com ([66.185.86.74]:12373
	"EHLO fep04-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S262673AbUCROcZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 09:32:25 -0500
Message-ID: <4059B2F7.6040808@cantecsystems.com>
Date: Thu, 18 Mar 2004 09:32:23 -0500
From: Dave Croal <dcroal@cantecsystems.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040312 Debian/1.6-3
X-Accept-Language: en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: alim15x3 later than 2.6.1 won't allow DMA to be turned
 on
References: <40590737.9060001@cantecsystems.com> <200403180345.42571.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200403180345.42571.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep04-mail.bloor.is.net.cable.rogers.com from [24.43.227.80] using ID <dcroal@rogers.com> at Thu, 18 Mar 2004 09:31:46 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Bartlomiej Zolnierkiewicz wrote:
> On Thursday 18 of March 2004 03:19, Dave Croal wrote:
> 
>>The alim15x3 module in kernels 2.6.3 and 2.6.4 does not allow me to turn
>>on DMA via hdparm:
>>
>>hdparm -d1 /dev/hda
>>HDIO_SET_DMA failed: Operation not permitted using_dma = 0 (off)
>>
>>dmesg |grep -i ali
>>ALI15X3: IDE controller at PCI slot 0000:00:0f.0
>>ALI15X3: chipset revision 32
>>ALI15X3: not 100% native mode: will probe irqs later
>>ALI15X3: port 0x01f0 already claimed by ide0
>>ALI15X3: port 0x0170 already claimed by ide1
>>ALI15X3: neither IDE port enabled (BIOS)
>>
>>---
>>
>>In kernel 2.6.1 it worked OK:
>>
>>hdparm -d1 /dev/hda
>>/dev/hda:
>>  setting using_dma to 1 (on)
>>  using_dma    =  1 (on)
>>
>>dmesg |grep -i ali
>>ALI15X3: IDE controller at PCI slot 0000:00:0f.0
>>ALI15X3: chipset revision 32
>>ALI15X3: not 100% native mode: will probe irqs later
>>     ide0: BM-DMA at 0x78c0-0x78c7, BIOS settings: hda:DMA, hdb:pio
>>     ide1: BM-DMA at 0x78c8-0x78cf, BIOS settings: hdc:DMA, hdd:pio
>>ide0: I/O resource 0x3F6-0x3F6 not free.
>>hda: ERROR, PORTS ALREADY IN USE
>>register_blkdev: cannot get major 3 for ide0
>>ide1: I/O resource 0x376-0x376 not free.
>>hdc: ERROR, PORTS ALREADY IN USE
>>register_blkdev: cannot get major 22 for ide1
>>Module alim15x3 cannot be unloaded due to unsafe usage in
>>include/linux/module.h:483
> 
> 
> These are errors - ide0 and ide1 are already used by generic IDE driver.
> It was fixed in 2.6.2 but side-effect of the fix is that you must make sure
> that ide_generic driver is not compiled in or loaded if it's modular.
> 
> Please make sure CONFIG_IDE_GENERIC is 'n' in your .config.
> 
> Regards,
> Bartlomiej
> 
> 

That worked, I am happily using DMA with alim15x3 on 2.6.4 now. Thank 
you for your help.

Dave Croal
