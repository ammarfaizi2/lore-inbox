Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289343AbSAVSsu>; Tue, 22 Jan 2002 13:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289342AbSAVSso>; Tue, 22 Jan 2002 13:48:44 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:44306 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S289351AbSAVSsN>; Tue, 22 Jan 2002 13:48:13 -0500
Message-ID: <3C4DB256.172F8D6A@zip.com.au>
Date: Tue, 22 Jan 2002 10:41:26 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Andreas Dilger <adilger@turbolabs.com>, Chris Mason <mason@suse.com>,
        Rik van Riel <riel@conectiva.com.br>, Shawn Starr <spstarr@sh0n.net>,
        linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <Pine.LNX.4.33L.0201211153110.32617-100000@imladris.surriel.com> <3C4C20A2.9040009@namesys.com> <1780530000.1011633710@tiny> <3C4C5414.2090104@namesys.com> <1819870000.1011642257@tiny> <3C4C7D08.2020707@namesys.com> <1854570000.1011649986@tiny> <20020121230249.P4014@lynx.turbolabs.com> <3C4D4F5E.2000106@namesys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> 
> So is there a consensus view that we need 2 calls, one to write a
> particular page, and one to exert memory pressure, and the call to write
> a particular page should only be used when we really need to write that
> particular page?
> 

Note that writepage() doesn't get used much.  Most VM-initiated
filesystem writeback activity is via try_to_release_page(), which
has somewhat more vague and flexible semantics.

And by bdflush, which I suspect tends to conflict with sync_page_buffers()
under pressure.  But that's a different problem.

-
