Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268255AbUJDADt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268255AbUJDADt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 20:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268258AbUJDADt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 20:03:49 -0400
Received: from jade.aracnet.com ([216.99.193.136]:6042 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S268255AbUJDADr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 20:03:47 -0400
Date: Sun, 03 Oct 2004 17:02:36 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Paul Jackson <pj@sgi.com>
cc: pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-ID: <835810000.1096848156@[10.10.2.4]>
In-Reply-To: <834330000.1096847619@[10.10.2.4]>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com><20040805190500.3c8fb361.pj@sgi.com><247790000.1091762644@[10.10.2.4]><200408061730.06175.efocht@hpce.nec.com><20040806231013.2b6c44df.pj@sgi.com><411685D6.5040405@watson.ibm.com><20041001164118.45b75e17.akpm@osdl.org><20041001230644.39b551af.pj@sgi.com><20041002145521.GA8868@in.ibm.com><415ED3E3.6050008@watson.ibm.com><415F37F9.6060002@bigpond.net.au><821020000.1096814205@[10.10.2.4]> <20041003083936.7c844ec3.pj@sgi.com> <834330000.1096847619@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--"Martin J. Bligh" <mbligh@aracnet.com> wrote (on Sunday, October 03, 2004 16:53:40 -0700):

>> Martin wrote:
>>> Matt had proposed having a separate sched_domain tree for each cpuset, which
>>> made a lot of sense, but seemed harder to do in practice because "exclusive"
>>> in cpusets doesn't really mean exclusive at all.
>> 
>> See my comments on this from yesterday on this thread.
>> 
>> I suspect we don't want a distinct sched_domain for each cpuset, but
>> rather a sched_domain for each of several entire subtrees of the cpuset
>> hierarchy, such that every CPU is in exactly one such sched domain, even
>> though it be in several cpusets in that sched_domain.
> 
> Mmmm. The fundamental problem I think we ran across (just whilst pondering,
> not in code) was that some things (eg ... init) are bound to ALL cpus (or
> no cpus, depending how you word it); i.e. they're created before the cpusets
> are, and are a member of the grand-top-level-uber-master-thingummy.
> 
> How do you service such processes? That's what I meant by the exclusive
> domains aren't really exclusive. 
> 
> Perhaps Matt can recall the problems better. I really liked his idea, aside
> from the small problem that it didn't seem to work ;-)
> 
>> So we have eight cpusets, non-overlapping and covering the entire
>> system, each with its own sched_domain.
> 
> But that's the problem ... I think there are *always* cpusets that overlap.
> Which is sad (fixable?) because it breaks lots of intelligent things we
> could do. 

Hmmm. What if when you created a new, exclusive CPUset, the cpus you spec'ed
were *removed* from the parent CPUset (and existing processes forcibly
migrated off). That'd fix most of it, and would bring us much closer to the
true meaning of "exclusive". Changes your semantics a bit, but still ...

OK, so there is one problem I can see - you couldn't remove the last CPU
from the parent if there were any jobs running in it, but presumably fixable
(eg you have to move them into the created child, or fail the call).

M.

