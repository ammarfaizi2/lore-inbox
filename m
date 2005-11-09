Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbVKIU4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbVKIU4U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 15:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbVKIU4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 15:56:20 -0500
Received: from pop.gmx.net ([213.165.64.20]:32730 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750990AbVKIU4T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 15:56:19 -0500
X-Authenticated: #20450766
Date: Wed, 9 Nov 2005 21:56:32 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: userspace block driver?
In-Reply-To: <4371A4ED.9020800@pobox.com>
Message-ID: <Pine.LNX.4.60.0511092130230.9330@poirot.grange>
References: <4371A4ED.9020800@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Nov 2005, Jeff Garzik wrote:

> 
> Has anybody put any thought towards how a userspace block driver would work?
> 
> Consider a block device implemented via an SSL network connection.  I don't
> want to put SSL in the kernel, which means the only other alternative is to
> pass data to/from a userspace daemon.
> 
> Anybody have any favorite methods?  [similar to] mmap'd packet socket? ramfs?

Heh, thanks, Jeff, for bringing this subject up again, hasn't been that 
long ago

http://marc.theaimsgroup.com/?l=linux-kernel&m=113140332009208&w=2

, which was indeed asked with nbd in mind. To remind you and others in

http://marc.theaimsgroup.com/?t=111524157800004&r=1&w=2
http://marc.theaimsgroup.com/?t=111706463800001&r=1&w=2

I played a bit with extending nbd to map block devices to the client 
system more transparently, which means, as James Bottomley explained, 
basically supporting REQ_BLOCK_PC requests. He also suggested not to use 
ioctls on both sides, which is where I stopped. I can understand how to 
avoid implementing ioctl in the nbd driver and intercepting REQ_BLOCK_PC 
requests instead, but on the server side? Assume you get the request 
object on the client, send it to the server, and then? Even if there 
existed a generic interface to block devices, allowing to inject requests 
directly from user space into block queue, wouldn't the same problems with 
endianness, 32/64 bit stay? The advantage, perhaps, would be that the 
request structure is standard, so, the conversion would be universal?

So, my problem is - how to send a generic request to a device (disk / 
cdrom / loop / sg / st / ...) from the user space? Hence my recent 
question...

Thanks
Guennadi
---
Guennadi Liakhovetski
