Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262849AbTDFG4J (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 01:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262852AbTDFG4J (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 01:56:09 -0500
Received: from holomorphy.com ([66.224.33.161]:12185 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262849AbTDFG4H (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 01:56:07 -0500
Date: Sat, 5 Apr 2003 23:07:10 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, andrea@suse.de, mingo@elte.hu,
       hugh@veritas.com, dmccr@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <20030406070710.GJ993@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>, andrea@suse.de,
	mingo@elte.hu, hugh@veritas.com, dmccr@us.ibm.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030404163154.77f19d9e.akpm@digeo.com> <12880000.1049508832@flay> <20030405024414.GP16293@dualathlon.random> <20030404192401.03292293.akpm@digeo.com> <20030405040614.66511e1e.akpm@digeo.com> <69120000.1049555511@[10.10.2.4]> <20030405161758.1ee19bfa.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030405161758.1ee19bfa.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 05, 2003 at 04:17:58PM -0800, Andrew Morton wrote:
> There are perhaps a few things we can do about that.
> It's only a problem on the kooky highmem boxes, and they need page clustering
> anyway.
> And this is just another instance of "lowmem pinned by highmem pages" which
> could be solved by unmapping (and not necessarily reclaiming) the highmem
> pages.  But that's a pretty lame thing to do.

I've actually liked this approach, despite not being terribly highly
performant, on the grounds it is relatively non-invasive, and that once
it's in place, various stronger (and more invasive) space reduction
techniques become optimizations instead of workload feasibility patches.
The fact it generalizes to other (non-highmem) situations is also good.

I'm not terribly attached to it, but since there is some mention of it,
thought it worth mentioning that there is _some_ middle ground that I
(as one of the "big highmem box bad guys") find acceptable.

I'm largely anticipating out-of-tree patches will be needed to run
these machines anyway and am prepared (in nontrivial senses; significant
amounts of my time in the future are allocated to maintaining and
implementing the things needed for it) to take on some of the
maintenance load to keep workloads running and running performantly on
these boxen (specifically pgcl; other patches [e.g. shpte] have other
maintainers).  It's probably not the best thing to say in the face of
the possibility of a truly immense maintenance load, but it is true.


-- wli
