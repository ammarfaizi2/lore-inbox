Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbTDVPbf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 11:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263202AbTDVPbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 11:31:35 -0400
Received: from holomorphy.com ([66.224.33.161]:16283 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261693AbTDVPbe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 11:31:34 -0400
Date: Tue, 22 Apr 2003 08:42:48 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@redhat.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@digeo.com>,
       Andrea Arcangeli <andrea@suse.de>, mingo@elte.hu, hugh@veritas.com,
       dmccr@us.ibm.com, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <20030422154248.GI8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@redhat.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>,
	mingo@elte.hu, hugh@veritas.com, dmccr@us.ibm.com,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <170570000.1051021741@[10.10.2.4]> <Pine.LNX.4.44.0304221032560.10400-100000@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304221032560.10400-100000@devserv.devel.redhat.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 22, 2003 at 11:07:32AM -0400, Ingo Molnar wrote:
> also, it's an inherent DoS thing. Any application that has the 'privilege'
> of creating 1000 mappings in 1000 processes to the same inode (this is
> already being done, and it will be commonplace in a few years) will
> immediately DoS the whole VM. I might be repeating myself, but quadratic
> algorithms do get linearly _worse_ as the hw evolves. The pidhash
> quadratic behavior triggering the NMI watchdog on the biggest boxes is
> just one example of this.

I have to apologize for my misstatements of the problem here. You
yourself pointed out to me the hold time was, in fact, linear. Despite
the linearity of the algorithm, the failure mode persists. I've
postponed further investigation until later, when more invasive
techniques are admissible; /proc/ alone will not suffice if linear
algorithms under tasklist_lock can trigger this failure mode.

I believe further work is needed but I can't think of a 2.5.x mergeable
method to address it. I've attempted to devolve the work to others in
the hopes that future solutions might be devised. It's unfortunate but
general algorithmic scalability for scenarios like this has a real cost
for the low-end and it's a problem I don't feel comfortable trying to
fix in the middle of 2.5.x stabilization for more general systems.

Unless a refinement of either manfred's or your patches can be made to
pass the test (apologies again; I don't recall the results, my time on
the whole system is very limited and it was a while ago) I suspect very
little can be done for 2.5.x here. IMHO a series of patches to
eliminate all remaining linear scans under tasklist_lock alongside a
fair locking construct will be eventually required, though, of course,
only a solution is required, not my expectation.

-- wli
