Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131633AbRAERxU>; Fri, 5 Jan 2001 12:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131389AbRAERxL>; Fri, 5 Jan 2001 12:53:11 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:60431 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129859AbRAERwd>; Fri, 5 Jan 2001 12:52:33 -0500
Date: Fri, 05 Jan 2001 12:52:25 -0500
From: Chris Mason <mason@suse.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
Message-ID: <778660000.978717145@tiny>
In-Reply-To: <Pine.LNX.4.21.0101051318190.2745-100000@freak.distro.conectiva>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, January 05, 2001 01:43:07 PM -0200 Marcelo Tosatti
<marcelo@conectiva.com.br> wrote:

> 
> On Fri, 5 Jan 2001, Chris Mason wrote:
> 
>> 
>> Here's the latest version of the patch, against 2.4.0.  The
>> biggest open issues are what to do with bdflush, since
>> page_launder could do everything bdflush does.  
> 
> I think we want to remove flush_dirty_buffers() from bdflush. 
> 

I think you're right.  Now that bdflush calls page_launder with GFP_KERNEL,
the flush_dirty_buffers call isn't needed there.  I think the current
bdflush (with or without the flush_dirty_buffers call) will be more
aggressive at freeing buffer cache pages from the inactive_dirty list, and
it will be interesting to see how it performs.  I think it will be better,
but the blocksize < pagesize case might screw us up.

> While we are trying to be smart and do write clustering at the ->writepage
> operation, flush_dirty_buffers() is "dumb" and will interfere with the
> write clustering. 
> 
Only for the buffer cache pages.  For actual file data, flush_dirty_buffers
is calling the writepage func, and we should still be able to cluster it.

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
