Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965047AbVJURs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965047AbVJURs7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 13:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965045AbVJURs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 13:48:59 -0400
Received: from magic.adaptec.com ([216.52.22.17]:7402 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S965044AbVJURs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 13:48:58 -0400
Message-ID: <435929FD.4070304@adaptec.com>
Date: Fri, 21 Oct 2005 13:48:45 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: andrew.patterson@hp.com, Christoph Hellwig <hch@lst.de>,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
       linux-scsi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: ioctls, etc. (was Re: [PATCH 1/4] sas: add flag for locally attached
 PHYs)
References: <91888D455306F94EBD4D168954A9457C048F0E34@nacos172.co.lsil.com>	 <20051020160155.GA14296@lst.de> <4357CB03.4020400@adaptec.com>	 <20051020170330.GA16458@lst.de>  <4357F7DE.7050004@adaptec.com> <1129852879.30258.137.camel@bluto.andrew> <43583A53.2090904@pobox.com>
In-Reply-To: <43583A53.2090904@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Oct 2005 17:48:50.0044 (UTC) FILETIME=[B1A763C0:01C5D667]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/05 20:46, Jeff Garzik wrote:
> Consider what an ioctl is, overall:  a domain-specific "do this 
> operation" interface.  Which, further, is nothing but a wrapping of a 
> "send message" + "receive response" interface.  There are several ways 
> to do this in Linux:
> 
> * block driver.  a block driver is nothing but a message queue.  This is 

Not quite.  This maybe the way it operates, but it is called "block"
for a reason.

> why James has suggested implementing SMP as a block driver.  People get 
> stuck into thinking "block driver == block device", which is wrong.  The 
> Linux block layer is nothing but a message queueing interface.

Now, just because James suggested implementing the SMP service as a block
device you think this is the right thing to do?

How about this: Why not as a char device?

At least MS isn't suffering from the "no to specs" syndrome which
the Linux community seems to be suffering...

SMP as a Block device????

You need to see the history of SMP and its intended use.

> * netlink.  You connect to <an object> and send/receive messages.  Not 
> strictly limited to networking, as this is used in some areas of the 
> kernel now for generic event delivery.

This is very similar to the binary attr file "smp_portal" in
drivers/scsi/sas/sas_expander.c, bottom of file.

> * char driver.  Poor man's netlink.  Unless its done right, it suffers 
> from the same binary problems as ioctls.  I don't recommend this path.
> 
> * sysfs.  This has no inherent message/queue properties by itself, and 
> is less structured than blockdrvr or netlink, so dealing with more than 
> one outstanding operation at a time requires some coding.

Exactly! SMP. (binary attr file)

	Luben
-- 
http://linux.adaptec.com/sas/
http://www.adaptec.com/sas/
