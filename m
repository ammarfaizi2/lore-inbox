Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261563AbSJMRgK>; Sun, 13 Oct 2002 13:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261568AbSJMRgJ>; Sun, 13 Oct 2002 13:36:09 -0400
Received: from [203.117.131.12] ([203.117.131.12]:9133 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S261563AbSJMRgH>; Sun, 13 Oct 2002 13:36:07 -0400
Message-ID: <3DA9B05F.8000600@metaparadigm.com>
Date: Mon, 14 Oct 2002 01:41:51 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
Cc: Christoph Hellwig <hch@infradead.org>,
       Mark Peloquin <markpeloquin@hotmail.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: Linux v2.5.42
References: <Pine.GSO.4.21.0210131243480.9247-100000@steklov.math.psu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/02 01:10, Alexander Viro wrote:
> 
> On Mon, 14 Oct 2002, Michael Clark wrote:
> 
> 
>>Some of us have large arrays and SANs where the absence a volume
>>manager is a big thing. I'm glad to see the distros picking it up
>>- i guess they have customers who need this sort of stuff.
>>
>>How about feedback from other kernel developers on EVMS. Does anyone
>>think 'its good enough for inclusion now as long as a few cleanups
>>are done after the freeze'?
> 
> 	Mostly those who won't have to clean up the mess afterwards.
> For the record, my vote is "not ready".
> 
> 	There are good chunks, no arguments about that.  However, IMNSHO
> we will be better off if we gradually pick the pieces that make sense
> and integrate them into the system.  As it is, wholesale merge would cost
> us too much half a year down the road.

I guess it boils down to differentiation between architectural flaws
and more trivial code cleanup. I guess the thing that drew me to Christoph's
particular criticism was whether or not it is a flaw or a feature for
remapping layers to just be remapping layers and not also block devices.

If it is the concensus that remapping layers should also be block devices
then i concede. Although clearly there needs to be a little more reason
than having a device node to do an ioctl on.

> 	I have seen major subsystem rewrites.  I have done several myself.
> I have also done more than a bit of wading through "yet another drivers".
> EVMS in its current state shows a lot of signs promising very painful
> work on cleanups and intergration.  "Few cleanups after the freeze" doesn't
> come anywhere near the impression I'm getting from it and I would bet a lot
> on that particular impression.

Okay. It's just not clear which criticism are of the trival post merge
code cleanup kind, which are true architectural problems, and which are
singly held opinions on architectural requirements.

Can we have some concensus on whether intermediate remapping layers also need
to be exposed as block devices as this requiement would have a large impact
on the code.

 From the discussion so far:

Pros
* Simplify ioctl routing to plugins

Cons
* Chew up a minor
* Get a block device we don't need or want (ie. we can still easily
   directly access the underlying physical block devices)
* loose purely logical remapping abstraction in plugins
* Complicate mapping of request queues to devices (ie. shouldn't only
   the top level volume device and the underlying physical devices need
   request queues)

~mc

