Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288274AbSATLfy>; Sun, 20 Jan 2002 06:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288280AbSATLff>; Sun, 20 Jan 2002 06:35:35 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:11023 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S288274AbSATLfY>; Sun, 20 Jan 2002 06:35:24 -0500
Message-ID: <3C4AAA95.8040702@namesys.com>
Date: Sun, 20 Jan 2002 14:31:33 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Shawn <spstarr@sh0n.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <Pine.LNX.4.40.0201200359520.503-100000@coredump.sh0n.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In version 4 of reiserfs, our plan is to implement writepage such that 
it does not write the page but instead pressures the reiser4 cache and 
marks the page as recently accessed.  This is Linus's preferred method 
of doing that.

Personally, I think that makes writepage the wrong name for that 
function, but I must admit it gets the job done, and it leaves writepage 
as the right name for all filesystems that don't manage their own cache, 
which is most of them.

Hans

Shawn wrote:

>I've noticed that XFS's filesystem has a separate pagebuf_daemon to handle
>caching/buffering.
>
>Why not make a kernel page/caching daemon for other filesystems to use
>(kpagebufd) so that each filesystem can use a kernel daemon interface to
>handle buffering and caching.
>
>I found that XFS's buffering/caching significantly reduced I/O load on the
>system (with riel's rmap11b + rml's preempt patches and Andre's IDE
>patch).
>
>But I've not been able to acheive the same speed results with ReiserFS :-(
>
>Just as we have a filesystem (VFS) layer, why not have a buffering/caching
>layer for the filesystems to use inconjunction with the VM?
>
There is hostility to this from one of the VM maintainers.  He is 
concerned that separate caches were what they had before and they 
behaved badly.  I think that they simply coded them wrong the time 
before.  The time before, the pressure on the subcaches was uneven, with 
some caches only getting pressure if the other caches couldn't free 
anything, so of course it behaved badly.

>
>
>Comments, suggestions, flames welcome ;)
>
>Shawn.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>



