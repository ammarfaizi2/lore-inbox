Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWGWSNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWGWSNL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 14:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWGWSNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 14:13:11 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:54958 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751142AbWGWSNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 14:13:10 -0400
Date: Sun, 23 Jul 2006 11:12:43 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, dino@in.ibm.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, davej@redhat.com,
       ashok.raj@intel.com
Subject: Re: [PATCH] Cpuset: fix ABBA deadlock with cpu hotplug lock
Message-Id: <20060723111243.d1373616.pj@sgi.com>
In-Reply-To: <20060714095434.24283.5979.sendpatchset@jackhammer.engr.sgi.com>
References: <20060714095434.24283.5979.sendpatchset@jackhammer.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I added the CC list from the "remove cpu hotplug bustification" thread. -pj]

Nine days ago, I offered this patch to fix a particular instance of
ABBA deadlock we were seeing on a single customer machine, between the
cpu hotplug lock and one of the cpuset locks.  In this case, the patch
was simple enough - reorder a couple of operations to avoid the risk of
taking these locks in the wrong order.

pj wrote:
> This fix appears right from inspection, but it will take a few
> more days running it on that customers workload to be confident
> we nailed it.  We don't have any other reproducible test case.

We now have enough exposure running this fix on that customers workload
to be confident this fix works.  We should have seen at least ten of
these crashes by now.  We've seen zero.

If the upcoming 2.6.18 is still open for non-critical fixes please
consider this patch.  In this case, it is non-critical because few
systems (exactly one system, world wide, so far) hit it.  It is quite
fatal when hit.

On the other hand, if you decide to nuke the cpu hotplug lock for
2.6.18, then just forget this patch, as it would no longer apply.

There's no need of trimming the patients ingrown toenail if you
amputate the leg.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
