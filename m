Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268250AbUJCXss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268250AbUJCXss (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 19:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268254AbUJCXss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 19:48:48 -0400
Received: from jade.aracnet.com ([216.99.193.136]:9957 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S268250AbUJCXso
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 19:48:44 -0400
Date: Sun, 03 Oct 2004 16:47:10 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Paul Jackson <pj@sgi.com>
cc: pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-ID: <833710000.1096847229@[10.10.2.4]>
In-Reply-To: <20041003090209.69b4b561.pj@sgi.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com><20040805190500.3c8fb361.pj@sgi.com><247790000.1091762644@[10.10.2.4]><200408061730.06175.efocht@hpce.nec.com><20040806231013.2b6c44df.pj@sgi.com><411685D6.5040405@watson.ibm.com><20041001164118.45b75e17.akpm@osdl.org><20041001230644.39b551af.pj@sgi.com><20041002145521.GA8868@in.ibm.com><415ED3E3.6050008@watson.ibm.com><415F37F9.6060002@bigpond.net.au><821020000.1096814205@[10.10.2.4]> <20041003090209.69b4b561.pj@sgi.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Paul Jackson <pj@sgi.com> wrote (on Sunday, October 03, 2004 09:02:09 -0700):

> Martin wrote:
>> The way cpusets uses the current cpus_allowed mechanism is, to me, the most
>> worrying thing about it. Frankly, the cpus_allowed thing is kind of tacked
>> onto the existing scheduler, and not at all integrated into it, and doesn't
>> work well if you use it heavily (eg bind all the processes to a few CPUs,
>> and watch the rest of the system kill itself). 
> 
> True.  One detail of what you say I'm unclear on -- how will the rest of
> the system kill itself?  Why wouldn't the unemployed CPUs just idle
> around, waiting for something to do?

I think last time I looked they just sat there saying:

Rebalance!  
Ooooh, CPU 3 over there looks heavily loaded, I'll steal something.
That one. Try to migrate. Oops, no cpus_allowed bars me.
That one. Try to migrate. Oops, no cpus_allowed bars me.
That one. Try to migrate. Oops, no cpus_allowed bars me.
That one. Try to migrate. Oops, no cpus_allowed bars me.
That one. Try to migrate. Oops, no cpus_allowed bars me.
That one. Try to migrate. Oops, no cpus_allowed bars me.
That one. Try to migrate. Oops, no cpus_allowed bars me.
That one. Try to migrate. Oops, no cpus_allowed bars me.
That one. Try to migrate. Oops, no cpus_allowed bars me.
That one. Try to migrate. Oops, no cpus_allowed bars me.
Humpf. I give up.
Rebalance!  
Ooooh, CPU 3 over there looks heavily loaded, I'll steal something.
That one. Try to migrate. Oops, no cpus_allowed bars me.
That one. Try to migrate. Oops, no cpus_allowed bars me.
That one. Try to migrate. Oops, no cpus_allowed bars me.
That one. Try to migrate. Oops, no cpus_allowed bars me.
That one. Try to migrate. Oops, no cpus_allowed bars me.
That one. Try to migrate. Oops, no cpus_allowed bars me.
That one. Try to migrate. Oops, no cpus_allowed bars me.
That one. Try to migrate. Oops, no cpus_allowed bars me.
That one. Try to migrate. Oops, no cpus_allowed bars me.
That one. Try to migrate. Oops, no cpus_allowed bars me.
Humpf. I give up.
Rebalance!  
Ooooh, CPU 3 over there looks heavily loaded, I'll steal something.
That one. Try to migrate. Oops, no cpus_allowed bars me.
That one. Try to migrate. Oops, no cpus_allowed bars me.
That one. Try to migrate. Oops, no cpus_allowed bars me.
That one. Try to migrate. Oops, no cpus_allowed bars me.
That one. Try to migrate. Oops, no cpus_allowed bars me.
That one. Try to migrate. Oops, no cpus_allowed bars me.
That one. Try to migrate. Oops, no cpus_allowed bars me.
That one. Try to migrate. Oops, no cpus_allowed bars me.
That one. Try to migrate. Oops, no cpus_allowed bars me.
That one. Try to migrate. Oops, no cpus_allowed bars me.
Humpf. I give up.
... ad infinitum.

Desperately boring, and rather ineffective.

> As I recall, Ingo added task->cpus_allowed for the Tux in-kernel web
> server a few years back, and I piggy backed the cpuset stuff on that, to
> keep my patch size small.
> 
> Likely your same concerns apply to the task->mems_allowed field that
> I added, in the same fashion, in my cpuset patch of recent.

Mmm, I'm less concerned about that one, or at least I can't specifically
see how it breaks.
 
> We need a mechanism that the cpuset apparatus respects that maps each
> CPU to a sched_domain, exactly one sched_domain for any given CPU at any
> point in time, regardless of which task it is considering running at the
> moment.  Somewhat like dual-channeled disks, having more than one
> sched_domain apply at the same time to a given CPU leads to confusions
> best avoided unless desparately needed. 

Agreed. The cpus_allowed mechanism doesn't seem well suited to heavy use
anyway (I think John Hawkes had problems with it too). That's not your
fault ... but I'm not convinced it's a good foundation to be building
further things on either ;-)

M.

