Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314396AbSFNXaJ>; Fri, 14 Jun 2002 19:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313571AbSFNXaI>; Fri, 14 Jun 2002 19:30:08 -0400
Received: from holomorphy.com ([66.224.33.161]:27049 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S314085AbSFNXaG>;
	Fri, 14 Jun 2002 19:30:06 -0400
Date: Fri, 14 Jun 2002 16:29:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, axboe@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: bio_chain: proposed solution for bio_alloc failure and large IO simplification
Message-ID: <20020614232943.GK22961@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>,
	"Adam J. Richter" <adam@yggdrasil.com>, axboe@suse.de,
	linux-kernel@vger.kernel.org
In-Reply-To: <200206141652.JAA26744@adam.yggdrasil.com> <3D0A75A4.AB34AC59@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2002 at 04:00:52PM -0700, Andrew Morton wrote:
> Everything is pretty much in place to do this now.  The main piece
> which is missing is the gang page allocator (Hi, Bill).
> It'll be damn fast, and nicely scalable.  It's all about reducing the
> L1 cache footprint.  Making best use of data when it is in cache.
> Making best use of locks once they have been acquired.  If it is
> done right, it'll be almost as fast as 64k PAGE_CACHE_SIZE, with
> none of its disadvantages.
> In this context, bio_chain() is regression, because we're back
> into doing stuff once-per-page, and longer per-page call graphs.
> I'd rather not have to do it if it can be avoided.

gang_cpu is not quite ready to post, but work is happening on it
and it's happening today -- I have a suitable target in hand and 
am preparing it for testing. The bits written thus far consist of
a transparent per-cpu pool layer refilled using the gang transfer
mechanism, and I'm in the process of refining that to non-prototypical
code and extending it with appropriate deadlock avoidance so explicit
gang allocation requests can be satisfied.


Cheers,
Bill
