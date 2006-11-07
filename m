Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753942AbWKGBjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753942AbWKGBjS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 20:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753853AbWKGBjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 20:39:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61636 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1753367AbWKGBjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 20:39:17 -0500
Message-ID: <454FE3BE.2040502@redhat.com>
Date: Mon, 06 Nov 2006 19:39:10 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (Macintosh/20060909)
MIME-Version: 1.0
To: Eric Sandeen <sandeen@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       Theodore Tso <tytso@mit.edu>
Subject: Re: [RFC/PATCH] - revert generic_fillattr stat->blksize to PAGE_CACHE_SIZE
References: <454FAE0A.3070409@redhat.com> <20061106230547.GA29711@infradead.org> <454FC20F.8040206@redhat.com> <20061107000840.GF6012@schatzie.adilger.int>
In-Reply-To: <20061107000840.GF6012@schatzie.adilger.int>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> On Nov 06, 2006  17:15 -0600, Eric Sandeen wrote:
>> Christoph Hellwig wrote:
>>> I agree with the conclusion, but the patch is incomplete.  You went down
>>> all the way to find out what the fileystems do in this messages, so add
>>> the hunks to override the defaults for non-standard filesystems to the
>>> patch aswell to restore the pre-inode diet state.
>> Well, agreed.  I put 80% or more back to pre-patch state, but not all.
>> :)  So it's less broken with my patch than without, so at least it's
>> moving forward.  So... Ted's patches get in w/o fixing up all the other
>> filesystems (left as an exercise to the patch reader) but mine can't? :)
> 
> Actually, rather than blindly revert to pre-patch behaviour it would be
> worthwhile to determine if PAGE_SIZE isn't the better value.  In some
> cases people don't understand that i_blksize is the "optimal IO size"
> and instead assume it is the filesystem blocksize.  I saw a few that were
> e.g. 512 and that can't be very useful.

I'm willing to either revert everyting to pre-inode-diet behavior, or leave it 
at the (newly re-proposed) page size default and let the other fs maintainers 
sort it out for their own codebase, but I don't pretend to know what is best 
for, say, qnx4 etc...  I'd be willing to cc: all maintainers asking them to take 
another long hard look at their code. :)

As we saw with cifs, these changes can have unintended consequences (not picking 
on cifs, it's just one that ran into issues with the broad-stroke change).

-Eric
