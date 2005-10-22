Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965202AbVJVCz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965202AbVJVCz2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 22:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbVJVCz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 22:55:28 -0400
Received: from mail.dvmed.net ([216.237.124.58]:44217 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932137AbVJVCz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 22:55:27 -0400
Message-ID: <4359A9FE.4010503@pobox.com>
Date: Fri, 21 Oct 2005 22:54:54 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dougg@torque.net
CC: Matthew Wilcox <matthew@wil.cx>, Luben Tuikov <luben_tuikov@adaptec.com>,
       Christoph Hellwig <hch@lst.de>, andrew.patterson@hp.com,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>, jejb@steeleye.com,
       linux-scsi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: ioctls, etc. (was Re: [PATCH 1/4] sas: add flag for locally attached
 PHYs)
References: <91888D455306F94EBD4D168954A9457C048F0E34@nacos172.co.lsil.com> <20051020160155.GA14296@lst.de> <4357CB03.4020400@adaptec.com> <20051020170330.GA16458@lst.de> <4357F7DE.7050004@adaptec.com> <1129852879.30258.137.camel@bluto.andrew> <43583A53.2090904@pobox.com> <435929FD.4070304@adaptec.com> <20051021180455.GA6834@lst.de> <43592FA1.8000206@adaptec.com> <20051021182009.GA3364@parisc-linux.org> <4359A44B.3090804@torque.net>
In-Reply-To: <4359A44B.3090804@torque.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas Gilbert wrote:
> However, the block layer is used in the context of a
> block device (and in some cases a char device).
> If SAS domain discovery is done from the user space, and
> the root file system is the far side of a SAS expander,
> there are no suitable devices, just the SAS initiator
> (HBA) which currently we cannot address via the block layer.

Invalid example.  All of the methods listed -- request_queue, netlink, 
chrdev, sysfs, ioctl -- will work just fine when the root filesystem is 
on the far side of a SAS expander.  These are just methods of 
communication, nothing more.

In your example -- userspace discovery required before root filesystem 
can be found -- a program running from initrd/initramfs would create an 
SMP device node, open it, and then proceed with the discovery and 
configuration process, which in turn creates the device nodes necessary 
to mount the root filesystem.

A request_queue is just a queue.  You are in complete control of who are 
the producer(s) of requests, and who are consumer(s).

	Jeff



