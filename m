Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268813AbTBZRDz>; Wed, 26 Feb 2003 12:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268836AbTBZRDz>; Wed, 26 Feb 2003 12:03:55 -0500
Received: from zeus.kernel.org ([204.152.189.113]:28898 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S268813AbTBZRDc>;
	Wed, 26 Feb 2003 12:03:32 -0500
Date: Wed, 26 Feb 2003 13:02:21 -0300 (BRT)
From: Rik van Riel <riel@imladris.surriel.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
       Hanna Linder <hannal@us.ibm.com>, "" <lse-tech@lists.sf.et>,
       "" <linux-kernel@vger.kernel.org>
Subject: Re: Minutes from Feb 21 LSE Call
In-Reply-To: <10220000.1046239279@[10.10.2.4]>
Message-ID: <Pine.LNX.4.50L.0302261258280.6749-100000@imladris.surriel.com>
References: <20030225174359.GA10411@holomorphy.com> <20030225175928.GP29467@dualathlon.random>
 <20030225185008.GF10396@holomorphy.com> <20030225191817.GT29467@dualathlon.random>
 <372680000.1046201260@flay> <20030225203001.GV29467@dualathlon.random>
 <417110000.1046206424@flay> <20030225211718.GY29467@dualathlon.random>
 <20030225212635.GE10411@holomorphy.com> <Pine.LNX.4.50L.0302260221380.17379-100000@imladris.surriel.com>
 <20030226053805.GK10411@holomorphy.com> <10220000.1046239279@[10.10.2.4]>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2003, Martin J. Bligh wrote:
> > On Wed, Feb 26, 2003 at 02:24:18AM -0300, Rik van Riel wrote:
> >> ... but making the anonymous pages use an object based
> >> scheme probably will make things too expensive.

> >> My instinct is that a hybrid system will work well in

[snip] "wli wrote something"

> It seemed, at least on the simple kernel compile tests that I did, that
> all the long chains are not anonymous. It killed 95% of the space issue,
> which given the simplicity of the patch was pretty damned stunning. Yes,
> there's a pointer per page I guess we could kill in the struct page
> itself, but I think you already have a better method for killing mem_map
> bloat ;-)

Also, with copy-on-write and mremap after fork, doing an
object based rmap scheme for anonymous pages is just complex,
almost certainly far too complex to be worth it, since it just
has too many issues.  Just read the patches by bcrl and davem,
things get hairy fast.

The pte chain rmap scheme is clean, but suffers from too much
overhead for file mappings.

As shown by Dave's patch, a hybrid system really is simple and
clean, and it removes most of the pte chain overhead while still
keeping the code nice and efficient.

I think this hybrid system is the way to go, possibly with a few
more tweaks left and right...

regards,

Rik
-- 
Engineers don't grow up, they grow sideways.
http://www.surriel.com/		http://kernelnewbies.org/
