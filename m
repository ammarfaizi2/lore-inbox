Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131564AbQL1SwN>; Thu, 28 Dec 2000 13:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131562AbQL1SwE>; Thu, 28 Dec 2000 13:52:04 -0500
Received: from d185fcbd7.rochester.rr.com ([24.95.203.215]:3343 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S131560AbQL1Svy>; Thu, 28 Dec 2000 13:51:54 -0500
Date: Thu, 28 Dec 2000 13:18:34 -0500
From: Chris Mason <mason@suse.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Daniel Phillips <phillips@innominate.de>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: innd mmap bug in 2.4.0-test12
Message-ID: <372790000.978027514@coffee>
In-Reply-To: <Pine.LNX.4.21.0012281551030.14052-100000@duckman.distro.conectiva>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, December 28, 2000 15:51:24 -0200 Rik van Riel
<riel@conectiva.com.br> wrote:

> On Thu, 28 Dec 2000, Chris Mason wrote:
> 
>> I think a dirty page without a writepage func seems a bit
>> broken.  How about we give ramfs a writepage func that just
>> returns 1.  That way nobody does any special if
>> (ramfs_page(page)) kinds of tests...
> 
> This will lead to the ramfs pages staying on the inactive_dirty
> list forever, deadlocking the system.
> 


This wouldn't be the first time this week I've read this part of
page_launder wrong, but I don't see a difference between a NULL writepage
func, and a writepage func that returns 1.  I read the code like this:

if(PageDirty(page)) {
...
	if (!writepage)
		goto page_active ;
...
	result = writepage(page)
	if (result != 1)
		continue ;
	SetPageDirty(page);
	goto page_active ;
}

-chris
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
