Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131231AbQLVO2K>; Fri, 22 Dec 2000 09:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131424AbQLVO2B>; Fri, 22 Dec 2000 09:28:01 -0500
Received: from d185fcbd7.rochester.rr.com ([24.95.203.215]:29199 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S131231AbQLVO1z>; Fri, 22 Dec 2000 09:27:55 -0500
Date: Fri, 22 Dec 2000 08:56:16 -0500
From: Chris Mason <mason@suse.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andreas Dilger <adilger@turbolinux.com>
cc: "Stephen C. Tweedie" <sct@redhat.com>, Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        Russell Cattelan <cattelan@thebarn.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
Message-ID: <243950000.977493376@coffee>
In-Reply-To: <Pine.LNX.4.21.0012212229190.2603-100000@freak.distro.conectiva>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, December 21, 2000 22:38:04 -0200 Marcelo Tosatti <marcelo@conectiva.com.br> wrote:

> 
> On Thu, 21 Dec 2000, Andreas Dilger wrote:
> 
>> Marcelo Tosatti writes:
>> > It seems your code has a problem with bh flush time.
>> > 
>> > In flush_dirty_buffers(), a buffer may (if being called from kupdate) only
>> > be written in case its old enough. (bh->b_flushtime)
>> > 
>> > If the flush happens for an anonymous buffer, you'll end up writing all
>> > buffers which are sitting on the same page (with block_write_anon_page),
>> > but these other buffers are not necessarily old enough to be flushed.
>> 
>> This isn't really a "problem" however.  The page is the _maximum_ age of
>> the buffer before it needs to be written.  If we can efficiently write it
>> out with another buffer 
> 
> 
>> (essentially for free if they are on the same spot on disk)
> 
> Are you sure this is true for buffer pages in most cases? 
> 
> 

It's a good point.  block_write_anon_page could be changed to just write the oldest buffer and redirty the page (if the buffers are far apart).  If memory is tight, and we *really* need the page back, it will be flushed by try_to_free_buffers.

It seems a bit nasty to me though...writepage should write the page.

-chris



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
