Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264976AbSJPOPB>; Wed, 16 Oct 2002 10:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264989AbSJPOPB>; Wed, 16 Oct 2002 10:15:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57355 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264976AbSJPOO7>;
	Wed, 16 Oct 2002 10:14:59 -0400
Message-ID: <3DAD75AE.7010405@pobox.com>
Date: Wed, 16 Oct 2002 10:20:30 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
CC: Linux Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>
Subject: Re: [PATCH] Device-mapper submission 6/7
References: <20021015175858.GA28170@fib011235813.fsnet.co.uk> <3DAC5B47.7020206@pobox.com> <20021015214420.GA28738@fib011235813.fsnet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Thornber wrote:
> On Tue, Oct 15, 2002 at 02:15:35PM -0400, Jeff Garzik wrote:
> 
>>>[Device mapper]
>>>Provide a traditional ioctl based interface to control device-mapper
>>
>>>from userland.
>>
>>
>>If you're adding a new interface, there should be no need to add new
>>ioctls and all that they entail.  Just control via a ramfs-based fs...
> 
> 
> We originally did have a fs based interface written by Steve
> Whitehouse.  However at the time (about a year ago) it wasn't obvious
> that everyone would think it a good idea.  Also the code was
> significantly larger than the ioctl interface.  I would be more than
> happy to do away with the ioctl stuff if people are now in full
> agreement that an fs interface is the way to go.


Which people didn't like it?  ;-)

AFAIK Linus and Al Viro (and myself <g>) have always considered ioctls 
an ugly -ism that should have never made it into Unix.  Over and above 
the Unix/VFS design problems with ioctl(2), ioctl(2) is a pain for 
people like David Miller who must maintain 32<->64 bit ioctl translation 
layers for their architecture.  ia64 and x64-64 must do this too.  Each 
ioctl you add is an additional headache for them.

We now have libfs.c in 2.5.x that makes ramfs-based filesystems even 
more tiny, too.  With the added flexibility of an fs -- it makes the 
userland tools much more simple and sane -- and the pain of ioctls, it 
seems a clear choice for new interfaces.

	Jeff



