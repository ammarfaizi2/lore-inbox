Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318789AbSHBLnv>; Fri, 2 Aug 2002 07:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318790AbSHBLnu>; Fri, 2 Aug 2002 07:43:50 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:65415 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318789AbSHBLnu>;
	Fri, 2 Aug 2002 07:43:50 -0400
Date: Fri, 2 Aug 2002 13:47:14 +0200
From: Jens Axboe <axboe@suse.de>
To: Stephen Lord <lord@sgi.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcin Dalecki <dalecki@evision.ag>
Subject: Re: A new ide warning message
Message-ID: <20020802114713.GD1055@suse.de>
References: <1028288066.1123.5.camel@laptop.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1028288066.1123.5.camel@laptop.americas.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02 2002, Stephen Lord wrote:
> 
> In 2.5.30 I started getting these warning messages out ide during
> the mount of an XFS filesystem:
> 
> ide-dma: received 1 phys segments, build 2
> 
> Can anyone translate that into English please.

Well I added that message when switching to the 2.5 style request
mapping functions, and I think the message is perfectly clear :-). Never
the less, it means that a segment that came into the ide layer with an
advertised size of 1 segment was returned from blk_rq_map_sg() as having
_two_. This can be a problem with dynamically allocated sg table (not
that ide uses those, but still).

It's a bug and usually a critical one when this happens. I'd be inclined
to think that Adam's changes in this path are to blame for this error.

Oh, and I'd be _really_ careful if you have trusted data on that drive
(surely not when running 2.5 ide on it :-)

-- 
Jens Axboe

