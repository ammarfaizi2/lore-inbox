Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131944AbQLVOVi>; Fri, 22 Dec 2000 09:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131964AbQLVOV2>; Fri, 22 Dec 2000 09:21:28 -0500
Received: from d185fcbd7.rochester.rr.com ([24.95.203.215]:25615 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S131944AbQLVOVK>; Fri, 22 Dec 2000 09:21:10 -0500
Date: Fri, 22 Dec 2000 08:49:09 -0500
From: Chris Mason <mason@suse.com>
To: Alexander Viro <viro@math.psu.edu>
cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Russell Cattelan <cattelan@thebarn.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
Message-ID: <232360000.977492949@coffee>
In-Reply-To: <Pine.GSO.4.21.0012212048210.5877-100000@weyl.math.psu.edu>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, December 21, 2000 20:54:09 -0500 Alexander Viro <viro@math.psu.edu> wrote:

> 
> 
> On Thu, 21 Dec 2000, Chris Mason wrote:
> 
>> Obvious bug, block_write_full_page zeros out the bits past the end of 
>> file every time.  This should not be needed for normal file writes.
> 
> Unfortunately, it _is_ needed for pageout path. mmap() the last page
> of file. Dirty the data past the EOF (MMU will not catch that access).
> Let the pageout send the page to disk. You don't want to have the data
> past EOF end up on the backstore.
> 

Sorry, I wasn't very clear.  I'd like to find a way to just do the memset in the one case it is needed (a real writepage), and not do it when we are using writepage just to flush dirty buffers.  I don't see how to do it though, without making a new flush operation.  That would also solve my concerns about the change in writepage semantics (even though every FS I could find in the kernel tree was using block_write_full_page). 

thanks,
Chris


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
