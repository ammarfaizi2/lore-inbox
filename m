Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269411AbUINPXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269411AbUINPXF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 11:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269409AbUINPXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 11:23:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46294 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269405AbUINPSi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 11:18:38 -0400
Message-ID: <41470BBD.7060700@pobox.com>
Date: Tue, 14 Sep 2004 11:18:21 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Jens Axboe <axboe@suse.de>, "C.Y.M." <syphir@syphir.sytes.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Changes to ide-probe.c in 2.6.9-rc2 causing improper detection
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA9mKu6AlYok2efOpJ3sb3O+KAAAAQAAAAjtLAU+gqyUq8AePOBiNtXQEAAAAA@syphir.sytes.net>	 <20040914060628.GC2336@suse.de> <1095156346.16572.2.camel@localhost.localdomain>
In-Reply-To: <1095156346.16572.2.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Maw, 2004-09-14 at 07:06, Jens Axboe wrote:
> 
>>Alan, I bet there are a lot of these. Maybe we should consider letting
>>the user manually flag support for FLUSH_CACHE, at least it is in their
>>hands then.
> 
> 
> You are assuming the drive supports "FLUSH_CACHE" just because it
> doesn't error it. Thats a good way to have accidents. 
> 
> The patch I posted originally did turn wcache off for barrier if no
> flush cache support was present but had a small bug so that bit got
> dropped.


FWIW the libata test for checking whether it is OK to issue a flush is

         return ata_id_wcache_enabled(dev) ||
                ata_id_has_flush(dev) ||
                ata_id_has_flush_ext(dev);

and if it passes that test,

         if ((tf->flags & ATA_TFLAG_LBA48) &&
             (ata_id_has_flush_ext(qc->dev)))
                 tf->command = ATA_CMD_FLUSH_EXT;
         else
                 tf->command = ATA_CMD_FLUSH;

I wouldn't object to removing the "ata_id_wcache_enabled" test if people 
feel that it is unsafe.

	Jeff


