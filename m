Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318791AbSHBLtm>; Fri, 2 Aug 2002 07:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318796AbSHBLtm>; Fri, 2 Aug 2002 07:49:42 -0400
Received: from [195.63.194.11] ([195.63.194.11]:46086 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S318791AbSHBLtl>; Fri, 2 Aug 2002 07:49:41 -0400
Message-ID: <3D4A7178.7050307@evision.ag>
Date: Fri, 02 Aug 2002 13:48:08 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Stephen Lord <lord@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A new ide warning message
References: <1028288066.1123.5.camel@laptop.americas.sgi.com> <20020802114713.GD1055@suse.de>
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Jens Axboe napisa?:
> On Fri, Aug 02 2002, Stephen Lord wrote:
> 
>>In 2.5.30 I started getting these warning messages out ide during
>>the mount of an XFS filesystem:
>>
>>ide-dma: received 1 phys segments, build 2
>>
>>Can anyone translate that into English please.
> 
> 
> Well I added that message when switching to the 2.5 style request
> mapping functions, and I think the message is perfectly clear :-). Never
> the less, it means that a segment that came into the ide layer with an
> advertised size of 1 segment was returned from blk_rq_map_sg() as having
> _two_. This can be a problem with dynamically allocated sg table (not
> that ide uses those, but still).
> 
> It's a bug and usually a critical one when this happens. I'd be inclined
> to think that Adam's changes in this path are to blame for this error.

Carefull carefull. it can be that the generic BIO code doesn't honour
the limits Adam was setting properly. And it can be of course
as well the XFS doesn't cooperate properly with those limits as well,
since ther kernel appears to be patched to support them.

It would be helpfull as well to know on which brand of host controller 
chip this was found. In esp. trm290 maybe?
> 
> Oh, and I'd be _really_ careful if you have trusted data on that drive
> (surely not when running 2.5 ide on it :-)
> 


