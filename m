Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129485AbRACTkY>; Wed, 3 Jan 2001 14:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129511AbRACTkO>; Wed, 3 Jan 2001 14:40:14 -0500
Received: from d185fcbd7.rochester.rr.com ([24.95.203.215]:18701 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129485AbRACTkJ>; Wed, 3 Jan 2001 14:40:09 -0500
Date: Wed, 03 Jan 2001 14:09:30 -0500
From: Chris Mason <mason@suse.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alexander Viro <viro@math.psu.edu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] filemap_fdatasync & related changes
Message-ID: <466640000.978548970@tiny>
In-Reply-To: <Pine.LNX.4.10.10101031027090.1896-100000@penguin.transmeta.com>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, January 03, 2001 10:28:05 AM -0800 Linus Torvalds
<torvalds@transmeta.com> wrote:
 
> On Wed, 3 Jan 2001, Chris Mason wrote:
>> 
>> Just noticed the filemap_fdatasync code doesn't check the return value
>> from writepage.  Linus, would you take a patch that redirtied the page,
>> puts it back onto the dirty list (at the tail), and unlocks the page
>> when writepage returns 1?
> 
> I don't see how that would help. It's just asking for endless loops.
> 
Yes, we would be explictly saying it is an error to always return 1.

The problem with [mf]sync is that we really want to write the page before
returning back to the application.  So, skipping dirty pages that need to
hit the disk is just as big an error.  Since the FS can't know the context
of when writepage is called, it would be obligated to never return 1 when
the page has data that needs to hit disk. 

Is there an easier/better way to tell writepage callers to retry the page
write later?

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
