Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130471AbQLVUHR>; Fri, 22 Dec 2000 15:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131577AbQLVUHH>; Fri, 22 Dec 2000 15:07:07 -0500
Received: from d185fcbd7.rochester.rr.com ([24.95.203.215]:786 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S130471AbQLVUG7>; Fri, 22 Dec 2000 15:06:59 -0500
Date: Fri, 22 Dec 2000 14:35:33 -0500
From: Chris Mason <mason@suse.com>
To: Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
Message-ID: <16230000.977513733@coffee>
In-Reply-To: <3A438545.2D9998AE@innominate.de>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, December 22, 2000 17:45:57 +0100 Daniel Phillips
<phillips@innominate.de> wrote:

[ flushing a page at a time in bdflush ]

> Um.  Why cater to the uncommon case of 1K blocks?  Just let
> bdflush/kupdated deal with them in the normal way - it's pretty
> efficient.  Only try to do the clustering optimization when buffer size
> matches memory page size.
> 

This isn't really an attempt at a clustering optimization.  The problem at
hand is that buffer cache buffers can be on relatively random pages.  So, a
page might have buffers that are very far apart, where one needs flushing
and the other doesn't.

In the blocksize == page size case, this won't happen, and we don't lose
any speed over the existing code.  In the blocksize < pagesize case, my new
code is slower, so my goal is to fix just that problem.

Real write clustering would be a different issue entirely, and is worth
doing ;-)

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
