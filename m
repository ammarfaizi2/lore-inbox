Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289226AbSAVUYP>; Tue, 22 Jan 2002 15:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289241AbSAVUYF>; Tue, 22 Jan 2002 15:24:05 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:55303 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S289226AbSAVUXx>; Tue, 22 Jan 2002 15:23:53 -0500
Message-ID: <3C4DC966.8060004@namesys.com>
Date: Tue, 22 Jan 2002 23:19:50 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Andreas Dilger <adilger@turbolabs.com>, Chris Mason <mason@suse.com>,
        Rik van Riel <riel@conectiva.com.br>, Shawn Starr <spstarr@sh0n.net>,
        linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <Pine.LNX.4.33L.0201211153110.32617-100000@imladris.surriel.com> <3C4C20A2.9040009@namesys.com> <1780530000.1011633710@tiny> <3C4C5414.2090104@namesys.com> <1819870000.1011642257@tiny> <3C4C7D08.2020707@namesys.com> <1854570000.1011649986@tiny> <20020121230249.P4014@lynx.turbolabs.com> <3C4D4F5E.2000106@namesys.com> <3C4DB256.172F8D6A@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Hans Reiser wrote:
>
>>So is there a consensus view that we need 2 calls, one to write a
>>particular page, and one to exert memory pressure, and the call to write
>>a particular page should only be used when we really need to write that
>>particular page?
>>
>
>Note that writepage() doesn't get used much.  Most VM-initiated
>filesystem writeback activity is via try_to_release_page(), which
>has somewhat more vague and flexible semantics.
>
>And by bdflush, which I suspect tends to conflict with sync_page_buffers()
>under pressure.  But that's a different problem.
>
>-
>
>
So the problem is that there is no coherently architected VM-to-FS 
interface that has been articulated, and we need one.

So far we can identify that we need something to pressure the FS, and 
something to ask for a particular page.

It might be desirable to pressure the FS more than one page aging at a 
time for reasons of performance as Rik pointed out.

Any other design considerations?


