Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268257AbUJCXy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268257AbUJCXy5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 19:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268255AbUJCXy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 19:54:57 -0400
Received: from jade.aracnet.com ([216.99.193.136]:35205 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S268257AbUJCXyw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 19:54:52 -0400
Date: Sun, 03 Oct 2004 16:53:40 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Paul Jackson <pj@sgi.com>
cc: pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com, colpatch@us.ibm.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-ID: <834330000.1096847619@[10.10.2.4]>
In-Reply-To: <20041003083936.7c844ec3.pj@sgi.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com><20040805190500.3c8fb361.pj@sgi.com><247790000.1091762644@[10.10.2.4]><200408061730.06175.efocht@hpce.nec.com><20040806231013.2b6c44df.pj@sgi.com><411685D6.5040405@watson.ibm.com><20041001164118.45b75e17.akpm@osdl.org><20041001230644.39b551af.pj@sgi.com><20041002145521.GA8868@in.ibm.com><415ED3E3.6050008@watson.ibm.com><415F37F9.6060002@bigpond.net.au><821020000.1096814205@[10.10.2.4]> <20041003083936.7c844ec3.pj@sgi.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Martin wrote:
>> Matt had proposed having a separate sched_domain tree for each cpuset, which
>> made a lot of sense, but seemed harder to do in practice because "exclusive"
>> in cpusets doesn't really mean exclusive at all.
> 
> See my comments on this from yesterday on this thread.
> 
> I suspect we don't want a distinct sched_domain for each cpuset, but
> rather a sched_domain for each of several entire subtrees of the cpuset
> hierarchy, such that every CPU is in exactly one such sched domain, even
> though it be in several cpusets in that sched_domain.

Mmmm. The fundamental problem I think we ran across (just whilst pondering,
not in code) was that some things (eg ... init) are bound to ALL cpus (or
no cpus, depending how you word it); i.e. they're created before the cpusets
are, and are a member of the grand-top-level-uber-master-thingummy.

How do you service such processes? That's what I meant by the exclusive
domains aren't really exclusive. 

Perhaps Matt can recall the problems better. I really liked his idea, aside
from the small problem that it didn't seem to work ;-)

> So we have eight cpusets, non-overlapping and covering the entire
> system, each with its own sched_domain.

But that's the problem ... I think there are *always* cpusets that overlap.
Which is sad (fixable?) because it breaks lots of intelligent things we
could do. 

> purposes.  I am afraid I've forgotten too much of my math from long long
> ago to state this with exactly the right terms.

That's OK, so have most of the rest of us, so even if you could remember,
it wouldn't help much ;-)

M.

