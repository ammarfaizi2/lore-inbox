Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129080AbRBOX6C>; Thu, 15 Feb 2001 18:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129104AbRBOX5w>; Thu, 15 Feb 2001 18:57:52 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:27916 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129080AbRBOX5u>;
	Thu, 15 Feb 2001 18:57:50 -0500
Date: Fri, 16 Feb 2001 00:57:42 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86 ptep_get_and_clear question
Message-ID: <20010216005742.B3207@pcep-jamie.cern.ch>
In-Reply-To: <3A8C254F.17334682@colorfullife.com> <200102151905.LAA62688@google.engr.sgi.com> <20010215201945.A2505@pcep-jamie.cern.ch> <96heaj$bvs$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <96heaj$bvs$1@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Feb 15, 2001 at 12:31:15PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> It _could_ be that the TLB data actually also contains the pointer to
> the place where it was fetched, and a "mark dirty" becomes
> 
> 	read *ptr locked
> 	val |= D
> 	write *ptr unlock

If you want to take it really far, it _could_ be that the TLB data
contains both the pointer and the original pte contents.  Then "mark
dirty" becomes

       val |= D
       write *ptr

> Now, I will agree that I suspect most x86 _implementations_ will not do
> this. TLB's are too timing-critical, and nobody tends to want to make
> them bigger than necessary - so saving off the source address is
> unlikely.

Then again, these hypothetical addresses etc. aren't part of the
associative lookup, so could be located in something like an ordinary
cache ram, with just an index in the TLB itself.

-- Jamie
