Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275374AbTHGO74 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 10:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275343AbTHGO6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 10:58:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31159 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S275360AbTHGO4v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 10:56:51 -0400
Message-ID: <3F3268A7.6090901@pobox.com>
Date: Thu, 07 Aug 2003 10:56:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Proper block queue reference counting
References: <200308070909.h7799QHg022029@hera.kernel.org> <3F3263FC.5030100@pobox.com> <20030807145027.GI2886@suse.de>
In-Reply-To: <20030807145027.GI2886@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> blk_cleanup_queue() still does that, as does blk_put_queue() (same deal,
> each drop a reference, last reference frees the queue).
> 
> This first patch is just the frame work, the only thing that's
> referenced counted right now is that the returned object has one
> reference and when the driver cleans the queue it drops the reference
> causing it to be freed. Next step is making sure others that hold a
> reference to the queue also grab a reference to it, using
> blk_get_queue(). That's stuff like bdev_get_queue(), for instance.

Groovy, thanks for explaining.


>>2) the blk_init_queue really should change names, IMO.  The other 
>>subsystems in the kernel tend to use a "foo_alloc" or "alloc_foo" 
>>pattern when creating new objects.  blk_alloc_queue, or simply blk_alloc?
> 
> 
> blk_alloc_queue() would be fine. However, it's hard to screw the usage
> up since it returns a queue, so... And people with out-of-tree drivers
> that need to be converted need only look at the blk_init_queue()
> changes, easy to grep for.

OTOH, blk_init_queue is changing quite radically, and people converting 
drivers will have to change that area of code _anyway_, so why not 
change the name too?  :)  It might create more confusion than it solves, 
to have the same function radically changing its behavior.  So I 
respectfully disagree :)

(this is a minor point, anyway.  I'm happy about the patch as a whole)

	Jeff


