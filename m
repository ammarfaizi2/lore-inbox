Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271138AbUJVAc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271138AbUJVAc2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 20:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271148AbUJVAXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 20:23:17 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:60806 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S271138AbUJVAWl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 20:22:41 -0400
Message-ID: <41785258.6060709@rtr.ca>
Date: Thu, 21 Oct 2004 20:20:40 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.28-pre4-bk6] delkin_cb: new driver for Cardbus IDE
 CF adaptor
References: <41780393.3000606@rtr.ca>	 <58cb370e041021121317083a3a@mail.gmail.com>	 <1098394354.17096.174.camel@localhost.localdomain>	 <41783CDF.80007@rtr.ca> <58cb370e04102115572e992d75@mail.gmail.com>	 <41784F51.5000308@rtr.ca> <58cb370e04102117153a92725d@mail.gmail.com>
In-Reply-To: <58cb370e04102117153a92725d@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> wrt to 2.6.x version
..
> please use ide_std_init_ports()

Okay, will do.

>>+       rc = ide_register_hw(&hw, &hwif);
>>+       if (rc < 0)     /* ide_register_hw likes to be invoked twice (buggy) */
>>+               rc = ide_register_hw(&hw, &hwif);
> 
> is this needed in 2.6.x and if so why?

Not sure yet -- still testing, though I've already done an #if 0 on it.

>>+               drive->id->csfo = 0; /* workaround for idedisk_open bug */

Not there in the 2.6.xx version.

And in 2.4.xx.. why is idedisk_open() examining vendor-specific
fields of the IDENTIFY data, anyway?  Very very unsafe.
I put the above one-liner workaround (drive->id->csfo) into delkin_cb
to bypass the problems it creates for now, until idedisk_open gets fixed.

Normally I'd just send a patch to fix idedisk_open(), but since I don't
even understand what it is trying to do, it would be safer for whoever
put that code there to have a second look.  Especially since 2.4.xx
is supposed to be stable now -- if it ain't broke, don't break it.  :)

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
