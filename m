Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265123AbSJPPxF>; Wed, 16 Oct 2002 11:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265133AbSJPPxF>; Wed, 16 Oct 2002 11:53:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53260 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265123AbSJPPxE>;
	Wed, 16 Oct 2002 11:53:04 -0400
Message-ID: <3DAD8CC9.9020302@pobox.com>
Date: Wed, 16 Oct 2002 11:59:05 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
CC: Linux Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>
Subject: Re: [PATCH] Device-mapper submission 6/7
References: <20021015175858.GA28170@fib011235813.fsnet.co.uk> <3DAC5B47.7020206@pobox.com> <20021015214420.GA28738@fib011235813.fsnet.co.uk> <3DAD75AE.7010405@pobox.com> <20021016152047.GA11422@fib011235813.fsnet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Thornber wrote:
> On Wed, Oct 16, 2002 at 10:20:30AM -0400, Jeff Garzik wrote:
> 
>>AFAIK Linus and Al Viro (and myself <g>) have always considered ioctls 
>>an ugly -ism that should have never made it into Unix.
> 
> 
> I'm not going to argue with you there.
> 
> 
>>ioctl(2) is a pain for people like David Miller who must maintain
>>32<->64 bit ioctl translation layers for their architecture.
> 
> 
> I know, the patch already includes ioctl32.c support for parisc,
> sparc64, s390x, ppc64 and mips64.

that's fine, but my point still stands -- _because_ you had to do it, it 
is more argument that the ioctls are just the wrong thing to do.


>>We now have libfs.c in 2.5.x that makes ramfs-based filesystems even 
>>more tiny, too.  With the added flexibility of an fs -- it makes the 
>>userland tools much more simple and sane -- and the pain of ioctls, it 
>>seems a clear choice for new interfaces.
> 
> 
> Yes, I was looking at libfs this morning and think it would remove a
> lot of the code from our old fs interface.  Is this going to be
> backported to 2.4 so that we can move to an fs interface there too ?

I think viro has mentioned doing something along these lines.  Even if 
current ramfs users in 2.4.x aren't changed, libfs.c can be added to 2.4.

But we are not talking about 2.4.x for the current context, which is 
submission to Linus for 2.5.  For 2.5.x's purposes, your libfs needs are 
met.

2.4.x and device mapper are at the moment a vendor issue.


> The driver has been designed to support different user interfaces, and
> userland is isolated by way of the little libdevmapper library.  So
> writing another another interface will be comparitively simple.  We
> will do this.  However, I want this to be a seperate piece of work
> from the current dm, I see no reason to stall inclusion of dm for
> this.


minus the submission of the ioctl layer, sure.

This is a _new_ addition, so from our perspective we want to get it 
right(tm) and change things now.  I know this differs from your 
perspective, but that's really a different context and [bluntly] doesn't 
matter.

Adding ioctls now and then removing them later is a software engineering 
no-no.  Save everyone lots of headache and ditch them now.

	Jeff



