Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751538AbVKDPvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbVKDPvv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 10:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbVKDPvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 10:51:50 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:28634
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751537AbVKDPvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 10:51:50 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Date: Fri, 4 Nov 2005 09:50:58 -0600
User-Agent: KMail/1.8
Cc: Blaisorblade <blaisorblade@yahoo.it>, Jeff Dike <jdike@addtoit.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Yasunori Goto <y-goto@jp.fujitsu.com>,
       Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Mel Gorman <mel@csn.ul.ie>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Andrew Morton <akpm@osdl.org>, kravetz@us.ibm.com,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
References: <1130917338.14475.133.camel@localhost> <200511022341.50524.rob@landley.net> <200511040426.47043.blaisorblade@yahoo.it>
In-Reply-To: <200511040426.47043.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511040950.59942.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 November 2005 21:26, Blaisorblade wrote:
> > I was hoping that since the file was deleted from disk and is already
> > getting _some_ special treatment (since it's a longstanding "poor man's
> > shared memory" hack), that madvise wouldn't flush the data to disk, but
> > would just zero it out.  A bit optimistic on my part, I know. :)
>
> I read at some time that this optimization existed but was deemed obsolete
> and removed.
>
> Why obsolete? Because... we have tmpfs! And that's the point. With
> DONTNEED, we detach references from page tables, but the content is still
> pinned: it _is_ the "disk"! (And you have TMPDIR on tmpfs, right?)

If I had that kind of control over environment my build would always be 
deployed in (including root access), I wouldn't need UML. :)

(P.S. The default for Ubuntu "Horny Hedgehog" is no.  The only tmpfs mount 
is /dev/shm, and /tmp is on / which is ext3.  Yeah, I need to upgrade my 
laptop...)

> I guess you refer to using frag. avoidance on the guest

Yes.  Moot point since Linus doesn't want it.

> (if it matters for 
> the host, let me know). When it will be present using it will be nice, but
> currently we'd do madvise() on a page-per-page basis, and we'd do it on
> non-consecutive pages (basically, free pages we either find or free or
> purpose).

Might be a performance issue if that gets introduced with per-page 
granularity, and how do you avoid giving back pages we're about to re-use?  
Oh well, bench it when it happens.  (And in any case, it needs a tunable to 
beat the page cache into submission or there's no free memory to give back.  
If there's already such a tuneable, I haven't found it yet.)

Rob
