Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269297AbUINS7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269297AbUINS7K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 14:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269199AbUINS6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 14:58:09 -0400
Received: from s0003.shadowconnect.net ([213.239.201.226]:58528 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S269366AbUINSzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 14:55:44 -0400
Message-ID: <41473F00.50109@shadowconnect.com>
Date: Tue, 14 Sep 2004 20:57:04 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I2O Updates + Questions
References: <1095174189.16988.10.camel@localhost.localdomain>
In-Reply-To: <1095174189.16988.10.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Alan Cox wrote:

> Markus, the new I2O stuff mostly looks nice. I found a few bits that
> seem wrong and some of my old cleanup bits still needed
> The attached patch files 
> - Fix misformed error messages in i2o_block

Okay...

> - Add recieve_to_virt and send_to_virt to clean up remaining
>   virt_to_* usage. (I've tweaked them to reflect the i2o_dma
>   objects) so hopefully I got it right
> - Post an 8 byte startup message area. Some Promises scribble on the
>   wrong dword. Also catch this
> - Fix several cases where messages got written to I/O space without
>   i2o_raw_writel
> - Fix a case where we skipped dpt controllers on quiesce and didnt
>   skip them on enable
> - Add some bits to try and get promise behaving again
> - Cleaned up the probe loop
> - Removed the remainder of i2o_retry and used the trick I was using
>   in my test code from back whenever- on congestion report BUS_BUSY
>   and leave it to the scsi layer

Ohohhh... i2o_core.c shouldn't be there anymore... I've split up 
i2o_core.c in own files e. g. iop.c, pci.c, ...

Probably i've made a mistake with the patch i've submitted...

Will try to get it removed...

> Looking at the code the event stuff seems totally broken in the new code
> both in core and the commented out i2o_block code (which now leaks

The I2O Block driver doesn't use the event notifaction anymore, instead 
it uses the probe and remove functions to add or remove disks...

> memory). Also i2o_scsi error path does a readl on msg->body[3] which is
> wrong as msg->body[3] is in kernel space and its contents are an I2O
> side message value so should get fed to i2o_send_to_virt().

The msg points to the outbound queue of the controller, don't i need a 
readl there?

> Other question is message size - right now it uses the 2.4 message size
> which is twice what all the vendors recommend as working best (and
> doesn't work at all on AMI)

The message size from the outbound queue of the I2O controller?

Yep, the dpt_i2o driver even set it to 17 instead of 128 :-)

Sorry for the mistake with the i2o_core.c.

Thanks for taking time to look at the I2O driver!


Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com
