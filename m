Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131141AbQL1SSV>; Thu, 28 Dec 2000 13:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131183AbQL1SSL>; Thu, 28 Dec 2000 13:18:11 -0500
Received: from d185fcbd7.rochester.rr.com ([24.95.203.215]:57102 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S131141AbQL1SSF>; Thu, 28 Dec 2000 13:18:05 -0500
Date: Thu, 28 Dec 2000 12:44:14 -0500
From: Chris Mason <mason@suse.com>
To: Daniel Phillips <phillips@innominate.de>,
        Rik van Riel <riel@conectiva.com.br>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: innd mmap bug in 2.4.0-test12
Message-ID: <343080000.978025454@coffee>
In-Reply-To: <00122816191301.00966@gimli>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, December 28, 2000 16:15:48 +0100 Daniel Phillips
<phillips@innominate.de> wrote:

> On Thu, 28 Dec 2000, Rik van Riel wrote:
>> On Thu, 28 Dec 2000, Daniel Phillips wrote:
>> 
>> > It's logical that PageDirty should never be get for ramfs,
>> 
>> No. Not setting PageDirty will cause the system to move the
>> page to the inactive_clean list and happily reclaim your data.
>> 
>> We _have to_ use something like PageDirty for this, and
>> checking for the ->writepage method will even allow us to
>> do stuff like dynamically switching swapping support for
>> ramfs on/off (or other funny things).
> 
> You're suggesting using the absence of a method as a kind of flag, but
> the code is really too full of obscure stuff like that already.
> 
> How about taking an extra user on the ramfs pages instead.  It doesn't
> sound right to set PageDirty when you are not requesting IO.

I think a dirty page without a writepage func seems a bit broken.  How
about we give ramfs a writepage func that just returns 1.  That way nobody
does any special if (ramfs_page(page)) kinds of tests...

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
