Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268980AbRHFUMY>; Mon, 6 Aug 2001 16:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268981AbRHFUMO>; Mon, 6 Aug 2001 16:12:14 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:63246
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S268980AbRHFUL5>; Mon, 6 Aug 2001 16:11:57 -0400
Date: Mon, 06 Aug 2001 16:12:00 -0400
From: Chris Mason <mason@suse.com>
To: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org
cc: linux-mm@kvack.org
Subject: Re: [RFC] using writepage to start io
Message-ID: <755760000.997128720@tiny>
In-Reply-To: <0108062145120I.00294@starship>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday, August 06, 2001 09:45:12 PM +0200 Daniel Phillips
<phillips@bonn-fries.net> wrote:

>> Almost ;-) memory pressure doesn't need to care about how long a
>> buffer has been dirty, that's kupdate's job.  kupdate doesn't care if
>> the buffer it is writing is a good candidate for freeing, that's taken
>> care of elsewhere. The two never need to talk (aside from
>> optimizations).
> 
> My point is, they should talk, in fact they should be the same function. 
> It's never right for bdflush to submit younger buffers when there are 
> dirty buffers whose flush time has already passed.
> 

Grin, we're talking in circles.  My point is that by having two threads,
bdflush is allowed to skip over older buffers in favor of younger ones
because somebody else is responsible for writing the older ones out.

Take away the kupdate thread and bdflush must write the older buffer.  I
believe this limits optimizations, unless kswapd is changed to handle all
memory pressure flushes.

-chris




