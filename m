Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268427AbRHGPT3>; Tue, 7 Aug 2001 11:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268206AbRHGPTT>; Tue, 7 Aug 2001 11:19:19 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:40196
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S268427AbRHGPTH>; Tue, 7 Aug 2001 11:19:07 -0400
Date: Tue, 07 Aug 2001 11:19:13 -0400
From: Chris Mason <mason@suse.com>
To: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org
cc: linux-mm@kvack.org
Subject: Re: [RFC] using writepage to start io
Message-ID: <75850000.997197553@tiny>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday, August 06, 2001 11:18:26 PM +0200 Daniel Phillips
<phillips@bonn-fries.net> wrote:

>> Grin, we're talking in circles.  My point is that by having two
>> threads, bdflush is allowed to skip over older buffers in favor of
>> younger ones because somebody else is responsible for writing the
>> older ones out.
> 
> Yes, and you can't imagine an algorithm that could do that with *one* 
> thread?

Imagine one?  Yes.  We're mixing a bunch of issues, so I'll list the 3
different cases again.  memory pressure, write throttling, age limiting.
Pretending that a single thread could get enough context information about
which of the 3 (perhaps more than one) it is currently facing, it can make
the right decisions.

The problem with that right now is that a single thread can't keep up (with
one case, let alone all 3) as the number of devices increases.  We can more
or less just replay the entire l-k discussion(s) on threading models here.

In my mind, in order for a single thread to get the job done, it can't end
up waiting on a device while there are still buffers ready for writeout to
idle devices.

As for a generic mechanism to schedule all FS writeback, I've been trying
to use writepage ;-)  The bad part here it makes the async issues even
bigger, since the flushing thread ends up calling into the FS (who knows
what that might lead to).

-chris

