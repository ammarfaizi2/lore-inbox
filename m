Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932590AbVI3TVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590AbVI3TVa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 15:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932588AbVI3TV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 15:21:29 -0400
Received: from magic.adaptec.com ([216.52.22.17]:46775 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932587AbVI3TV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 15:21:28 -0400
Message-ID: <433D9035.6000504@adaptec.com>
Date: Fri, 30 Sep 2005 15:21:25 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: andrew.patterson@hp.com
CC: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>, dougg@torque.net,
       Linus Torvalds <torvalds@osdl.org>, Luben Tuikov <ltuikov@yahoo.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01A9FA11@otce2k03.adaptec.com> <1128105594.10079.109.camel@bluto.andrew>
In-Reply-To: <1128105594.10079.109.camel@bluto.andrew>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Sep 2005 19:21:25.0138 (UTC) FILETIME=[2612B720:01C5C5F4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/30/05 14:39, Andrew Patterson wrote:
> 
> SDI is supposed to be a cross-platform spec, so mandating sysfs would
> not work.

True, sysfs is a Linux only thing.

But you can write a user space library which uses sysfs or whatever
_that_ OS uses to represent an SDI spec-ed out picture.

So a user space program would call (uniformly across all OSs)
a libsdi library which will use whatever OS dependent way there is
to get the information (be it sysfs or ioctl).

> I suggested to the author to use a library like HPAAPI (used
> by Fibre channel), so you could hide OS implementation details.  I am in
> fact working on such a beasty (http://libsdi.berlios.de).  He thinks
> that library solutions tend to not work, because the library version is
> never in synch with the standard/LLDD's. Given Linux vendor lead-times,
> he does have a valid point.

Yes, but it would be the best of all the current ways there are
to do it.

> Note that a sysfs implementation has problems.  Binary attributes are
> discouraged/not-allowed.

I've never heard that.  Is this similar to the argument
"The sysfs tree would be too deep?"

> There is no atomic request/response operations

For a reason: let user space do it, there is plenty of ways to
do it, some assisted by the kernel.

> buffers limited to page size, etc.

"You have an attribute larger than 4k?  What is it?"

As to SMP response/request is more than 4K/8K?  The largest
I'm aware of is 64 bytes.

> Other alternatives are
> configfs, SG_IO, and the above mentioned character device.  None are a

Again, char devices for controlling are discouraged.  There are not enough
around and it is old technology.

> complete replacement for the transactional nature of IOCTL's.  A group

Here:

/* User space lock */

fd = open(smp_portal, ...);
write(fd, smp_req, smp_req_size);
read(fd, smp_resp, smp_resp_size);
close(fd);

/* User space unlock */

	Luben
