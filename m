Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754012AbWKGECX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754012AbWKGECX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 23:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754011AbWKGECX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 23:02:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42172 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1754007AbWKGECW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 23:02:22 -0500
Message-ID: <45500544.2040103@redhat.com>
Date: Mon, 06 Nov 2006 22:02:12 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (Macintosh/20060909)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>, Eric Sandeen <sandeen@redhat.com>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC/PATCH] - revert generic_fillattr stat->blksize to PAGE_CACHE_SIZE
References: <454FAE0A.3070409@redhat.com> <20061106230547.GA29711@infradead.org> <454FC20F.8040206@redhat.com> <20061107034344.GA23959@thunk.org>
In-Reply-To: <20061107034344.GA23959@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> On Mon, Nov 06, 2006 at 05:15:27PM -0600, Eric Sandeen wrote:
>> Christoph Hellwig wrote:
>>> On Mon, Nov 06, 2006 at 03:50:02PM -0600, Eric Sandeen wrote:
>>>> so I would propose the following patch to make PAGE_CACHE_SIZE the default (again), 
>>>> and let filesystems which need something -else- do that on their own.
>>> I agree with the conclusion, but the patch is incomplete.  You went down
>>> all the way to find out what the fileystems do in this messages, so add
>>> the hunks to override the defaults for non-standard filesystems to the
>>> patch aswell to restore the pre-inode diet state.
>> Well, agreed.  I put 80% or more back to pre-patch state, but not all.
>> :)  So it's less broken with my patch than without, so at least it's
>> moving forward.  So... Ted's patches get in w/o fixing up all the other
>> filesystems (left as an exercise to the patch reader) but mine can't? :)
> 
> Note that *I* wasn't the one who changed it from PAGE_CACHE_SIZE to (1
> << inode->i_blkbits).  This was done by Andrew.  (See below, from an
> e-mail dated September 19th).
> 
> Given that Steve French was cc'ed, I assume this was done as a hack to
> fix CIFS, but it was a bad idea; I agree that PAGE_CACHE_SIZE is a way
> better default than (1 << inode->i_blkbits).
> 
> As far as fixing all of the other filesystems, I did *try*; I know I
> screwed up with XFS, but that's because I still think the code is a
> screaming horror of indirections that make it impossible to understand
> what the heck is going on, and I guess I screwed up with CIFS.  Some
> of the changes away from "pre inode diet" state were deliberate,
> though, since some filesystems had very clearly broken "optimal I/O
> sizes" of 512, and one even had something incredibly bogus that was
> something like 96 bytes (!) if I remember correctly.

In that case can we just go with my original third-round patch to put it back to 
PAGE_SIZE, and let the other filesystems tidy up if necessary.  This -is- just 
supposed to be a hint...

Sorry Ted, "broken" was too strong a word...  I just read:

"Filesystems that want
to provide a per-inode st_blksize can do so by providing their own getattr
routine instead of using the generic_fillattr() function."

in the patch, and figured that you were leaving it up to the filesystems to 
re-evaluate whether they needed something other than a page size.  Which I'd be 
happy to do, too.  :)

-Eric

