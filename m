Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131618AbQLVPlB>; Fri, 22 Dec 2000 10:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131994AbQLVPkw>; Fri, 22 Dec 2000 10:40:52 -0500
Received: from d185fcbd7.rochester.rr.com ([24.95.203.215]:17168 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S131618AbQLVPke>; Fri, 22 Dec 2000 10:40:34 -0500
Date: Fri, 22 Dec 2000 10:07:46 -0500
From: Chris Mason <mason@suse.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andreas Dilger <adilger@turbolinux.com>
cc: "Stephen C. Tweedie" <sct@redhat.com>, Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        Russell Cattelan <cattelan@thebarn.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
Message-ID: <26240000.977497666@coffee>
In-Reply-To: <Pine.LNX.4.21.0012212229190.2603-100000@freak.distro.conectiva>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, December 21, 2000 22:38:04 -0200 Marcelo Tosatti
<marcelo@conectiva.com.br> wrote:

>> Marcelo Tosatti writes:
>> > It seems your code has a problem with bh flush time.
>> > 
>> > In flush_dirty_buffers(), a buffer may (if being called from kupdate)
>> > only be written in case its old enough. (bh->b_flushtime)
>> > 
>> > If the flush happens for an anonymous buffer, you'll end up writing all
>> > buffers which are sitting on the same page (with
>> > block_write_anon_page), but these other buffers are not necessarily
>> > old enough to be flushed.
>> 

A quick benchmark shows there's room for improvement here.  I'll play
around with a version of block_write_anon_page that tries to be more
selective when flushing things out.

-chris
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
