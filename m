Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271337AbTHHNvK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 09:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271343AbTHHNvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 09:51:10 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:5838 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S271337AbTHHNvH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 09:51:07 -0400
Date: Fri, 8 Aug 2003 19:26:45 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: [PATCH][2.6-mm] Readahead issues and AIO read speedup
Message-ID: <20030808135645.GA3430@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20030807100120.GA5170@in.ibm.com> <200308071021.39816.pbadari@us.ibm.com> <20030807103930.69e497a7.akpm@osdl.org> <200308071341.50834.pbadari@us.ibm.com> <20030807135819.3368ee16.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030807135819.3368ee16.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07, 2003 at 01:58:19PM -0700, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> > On Thursday 07 August 2003 10:39 am, Andrew Morton wrote:
> >  > Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >  > > We should do readahead of actual pages required by the current
> >  > > read would be correct solution. (like Suparna suggested).
> >  >
> >  > I repeat: what will be the effect of this if all those pages are already in
> >  > pagecache?
> > 
> >  Hmm !! Do you think just peeking at pagecache and bailing out if
> >  nothing needed to be done, is too expensive ? Anyway, slow read
> >  code has to do this later. Doing it in readahead one more time causes
> >  significant perf. hit ?
> 
> It has been observed, yes.
> 
> > And also, do you think this is the most common case ?
> 
> It is a very common case.  It's one we need to care for.  Especially when
> lots of CPUs are hitting the same file.

So, you are concerned about the case when the window was maximally
shrunk via check_ra_success because the pages are already cached ?
Is it mainly for small reads that the performance hit due to the 
extra pagecache lookup is significant compared to the cycles spent 
in copy_to_user ? For less than page-sized reads clustering isn't
relevant, we can just keep the old behaviour there.

If on the other hand large cached reads are affected as well, then
we need to work on a solution.

> 
> There are things we can do to tweak it up, such as adding a max_index to
> find_get_pages(), then do multipage lookups, etc.  But not doing it at all
> is always the fastest way.

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

